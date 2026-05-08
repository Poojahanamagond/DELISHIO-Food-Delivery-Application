package com.delishio.daoimpl;

import com.delishio.dao.MenuDAO;
import com.delishio.models.MenuItem;
import com.delishio.util.MyConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    
    private Connection connection;
    
    public MenuDAOImpl() {
        this.connection = MyConnection.getConnection();
        System.out.println("MenuDAOImpl initialized. Connection: " + (connection != null ? "OK" : "NULL"));
    }
    
    @Override
    public MenuItem addMenuItem(MenuItem menuItem) {
        String sql = "INSERT INTO menu_items (restaurant_id, item_name, description, price, category, image_url, is_available) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, menuItem.getRestaurantId());
            pstmt.setString(2, menuItem.getItemName());
            pstmt.setString(3, menuItem.getDescription());
            pstmt.setDouble(4, menuItem.getPrice());
            pstmt.setString(5, menuItem.getCategory());
            pstmt.setString(6, menuItem.getImageUrl());
            pstmt.setBoolean(7, menuItem.isAvailable());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        menuItem.setMenuId(rs.getInt(1));
                        System.out.println("Menu item added successfully with ID: " + menuItem.getMenuId());
                        return menuItem;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding menu item: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public MenuItem getMenuItemById(int menuId) {
        String sql = "SELECT * FROM menu_items WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menuId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMenuItemFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching menu item by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public List<MenuItem> getMenuByRestaurantId(int restaurantId) {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE restaurant_id = ? ORDER BY category, item_name";
        
        System.out.println("Fetching menu items for restaurant ID: " + restaurantId);
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MenuItem item = extractMenuItemFromResultSet(rs);
                    menuItems.add(item);
                    System.out.println("Found menu item: " + item.getItemName());
                }
            }
            
            System.out.println("Total menu items found: " + menuItems.size());
        } catch (SQLException e) {
            System.err.println("Error fetching menu by restaurant ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return menuItems;
    }
    public List<MenuItem> getFoodByMood(String mood) {

        List<MenuItem> list = new ArrayList<>();

        try {
            Connection con = MyConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM menu_items WHERE LOWER(mood_tag) LIKE ?"
            );

            ps.setString(1, "%" + mood.toLowerCase() + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                MenuItem m = new MenuItem();

                m.setMenuId(rs.getInt("menu_id"));
                m.setItemName(rs.getString("item_name"));
                m.setPrice(rs.getDouble("price"));
                m.setImageUrl(rs.getString("image_url"));
                m.setRestaurantId(rs.getInt("restaurant_id")); // ✅ IMPORTANT

                list.add(m);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<MenuItem> getSnacks() {

        List<MenuItem> list = new ArrayList<>();

        try {
            Connection con = MyConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM menu_items WHERE LOWER(category) = 'snacks' LIMIT 3"
            );

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                MenuItem m = new MenuItem();

                m.setMenuId(rs.getInt("menu_id"));
                m.setItemName(rs.getString("item_name"));
                m.setPrice(rs.getDouble("price"));
                m.setImageUrl(rs.getString("image_url"));
                m.setRestaurantId(rs.getInt("restaurant_id"));

                list.add(m);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    @Override
    public List<MenuItem> getAllMenuItems() {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu_items ORDER BY restaurant_id, category";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                menuItems.add(extractMenuItemFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all menu items: " + e.getMessage());
            e.printStackTrace();
        }
        
        return menuItems;
    }
    
    @Override
    public boolean updateMenuItem(MenuItem menuItem) {
        String sql = "UPDATE menu_items SET restaurant_id = ?, item_name = ?, description = ?, price = ?, category = ?, image_url = ?, is_available = ? WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menuItem.getRestaurantId());
            pstmt.setString(2, menuItem.getItemName());
            pstmt.setString(3, menuItem.getDescription());
            pstmt.setDouble(4, menuItem.getPrice());
            pstmt.setString(5, menuItem.getCategory());
            pstmt.setString(6, menuItem.getImageUrl());
            pstmt.setBoolean(7, menuItem.isAvailable());
            pstmt.setInt(8, menuItem.getMenuId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error updating menu item: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean deleteMenuItem(int menuId) {
        String sql = "DELETE FROM menu_items WHERE menu_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, menuId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting menu item: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public List<MenuItem> getAvailableMenuItems(int restaurantId) {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE restaurant_id = ? AND is_available = TRUE ORDER BY category, item_name";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(extractMenuItemFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching available menu items: " + e.getMessage());
            e.printStackTrace();
        }
        
        return menuItems;
    }
    public List<Integer> getMenuIdsByNames(List<String> names) {

        List<Integer> menuIds = new ArrayList<>();

        try {
            Connection con = MyConnection.getConnection();

            for(String name : names) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT menu_id FROM menu_items WHERE LOWER(item_name) LIKE ? AND is_available = 1"
                );

                ps.setString(1, "%" + name + "%");

                ResultSet rs = ps.executeQuery();

                if(rs.next()) {
                    menuIds.add(rs.getInt("menu_id"));
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return menuIds;
    }
    public Integer getMenuIdByItemAndRestaurant(String item, String restaurant) {

        Integer menuId = null;

        try {
            Connection con = MyConnection.getConnection();

            String query = "SELECT m.menu_id FROM menu_items m " +
                    "JOIN restaurants r ON m.restaurant_id = r.restaurant_id " +
                    "WHERE LOWER(m.item_name) LIKE ? " +
                    "AND LOWER(r.name) LIKE ?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, "%" + item + "%");
            ps.setString(2, "%" + restaurant + "%");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                menuId = rs.getInt("menu_id");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return menuId;
    }
    
    
    private MenuItem extractMenuItemFromResultSet(ResultSet rs) throws SQLException {
        MenuItem menuItem = new MenuItem();
        menuItem.setMenuId(rs.getInt("menu_id"));
        menuItem.setRestaurantId(rs.getInt("restaurant_id"));
        menuItem.setItemName(rs.getString("item_name"));
        menuItem.setDescription(rs.getString("description"));
        menuItem.setPrice(rs.getDouble("price"));
        menuItem.setCategory(rs.getString("category"));
        menuItem.setImageUrl(rs.getString("image_url"));
        menuItem.setAvailable(rs.getBoolean("is_available"));
        menuItem.setCreatedAt(rs.getTimestamp("created_at"));
        return menuItem;
    }
}