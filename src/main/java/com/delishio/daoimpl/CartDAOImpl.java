package com.delishio.daoimpl;

import com.delishio.dao.CartDAO;
import com.delishio.models.Cart;
import com.delishio.util.MyConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    private Connection connection;

    public CartDAOImpl() {
        this.connection = MyConnection.getConnection();
    }

    @Override
    public boolean addToCart(Cart cart) {
        String checkSql = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND menu_id = ?";
        String updateSql = "UPDATE cart SET quantity = quantity + ? WHERE cart_id = ?";
        String insertSql = "INSERT INTO cart (user_id, menu_id, quantity) VALUES (?, ?, ?)";

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, cart.getUserId());
            checkStmt.setInt(2, cart.getMenuId());

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    int cartId = rs.getInt("cart_id");
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, cart.getQuantity());
                        updateStmt.setInt(2, cartId);
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, cart.getUserId());
                        insertStmt.setInt(2, cart.getMenuId());
                        insertStmt.setInt(3, cart.getQuantity());
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding to cart: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Cart> getCartItems(int userId) {
        List<Cart> cartList = new ArrayList<>();

        String sql = """
            SELECT 
                c.cart_id,
                c.user_id,
                c.menu_id,
                c.quantity,
                m.item_name,
                m.price,
                m.image_url
            FROM cart c
            JOIN menu_items m ON c.menu_id = m.menu_id
            WHERE c.user_id = ?
        """;

        try (Connection con = MyConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart(userId, userId, userId, userId, userId);
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setMenuId(rs.getInt("menu_id"));
                cart.setQuantity(rs.getInt("quantity"));

                cart.setItemName(rs.getString("item_name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setImageUrl(rs.getString("image_url"));

                cartList.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartList;
    }

    @Override
    public boolean updateCartQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, cartId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating cart quantity: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean removeFromCart(int cartId) {
        String sql = "DELETE FROM cart WHERE cart_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error removing from cart: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error clearing cart: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public double getCartTotal(int userId) {
        String sql = "SELECT SUM(c.quantity * m.price) as total FROM cart c " +
                     "JOIN menu_items m ON c.menu_id = m.menu_id WHERE c.user_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error calculating cart total: " + e.getMessage());
            e.printStackTrace();
        }

        return 0.0;
    }

    @Override
    public void incrementQuantity(int cartId) {
        String sql = "UPDATE cart SET quantity = quantity + 1 WHERE cart_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error incrementing quantity: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void decrementQuantity(int cartId) {
        String sql = "UPDATE cart SET quantity = quantity - 1 WHERE cart_id = ? AND quantity > 1";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error decrementing quantity: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<Cart> getCartByUserAndRestaurant(Integer userId, int restaurantId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = """
            SELECT c.cart_id, c.user_id, c.menu_id, c.quantity, m.item_name, m.price, m.image_url
            FROM cart c
            JOIN menu_items m ON c.menu_id = m.menu_id
            WHERE c.user_id = ? AND m.restaurant_id = ?
        """;

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, restaurantId);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(restaurantId, restaurantId, restaurantId, restaurantId, restaurantId);
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setMenuId(rs.getInt("menu_id"));
                cart.setQuantity(rs.getInt("quantity"));

                cart.setItemName(rs.getString("item_name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setImageUrl(rs.getString("image_url"));

                cartList.add(cart);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching cart by user and restaurant: " + e.getMessage());
            e.printStackTrace();
        }

        return cartList;
    }
    public void addToCart(int userId, int menuId) {

        try {
            Connection con = MyConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO cart (user_id, menu_id, quantity) VALUES (?, ?, 1)"
            );

            ps.setInt(1, userId);
            ps.setInt(2, menuId);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void clearCartByUserAndRestaurant(Integer userId, int restaurantId) {
        String sql = """
            DELETE c
            FROM cart c
            JOIN menu_items m ON c.menu_id = m.menu_id
            WHERE c.user_id = ? AND m.restaurant_id = ?
        """;

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, restaurantId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error clearing cart by user and restaurant: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
