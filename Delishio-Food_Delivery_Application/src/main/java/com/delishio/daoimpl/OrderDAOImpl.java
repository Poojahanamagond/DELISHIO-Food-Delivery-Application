package com.delishio.daoimpl;

import com.delishio.dao.OrderDAO;
import com.delishio.models.Order;
import com.delishio.models.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {
    private Connection connection;

    public OrderDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public int insertOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (order_number, customer_address, customer_phone, " +
                     "delivery_instructions, payment_method, card_number, upi_id, " +
                     "order_status, total_amount, user_id, restaurant_id) " +   // ✅ added
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, order.getOrderNumber());
            pstmt.setString(2, order.getCustomerAddress());
            pstmt.setString(3, order.getCustomerPhone());
            pstmt.setString(4, order.getDeliveryInstructions());
            pstmt.setString(5, order.getPaymentMethod());
            pstmt.setString(6, order.getCardNumber());
            pstmt.setString(7, order.getUpiId());
            pstmt.setString(8, order.getOrderStatus());
            pstmt.setDouble(9, order.getTotalAmount());
            pstmt.setInt(10, order.getUserId());        // ✅ added
            pstmt.setInt(11, order.getRestaurantId());  // ✅ added

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
    }

    @Override
    public void insertOrderItems(int orderId, List<OrderItem> items) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, food_name, quantity, price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            for (OrderItem item : items) {
                pstmt.setInt(1, orderId);
                pstmt.setString(2, item.getFoodName());
                pstmt.setInt(3, item.getQuantity());
                pstmt.setDouble(4, item.getPrice());
                pstmt.addBatch();
            }
            pstmt.executeBatch();
        }
    }

    @Override
    public boolean saveOrder(Order order, List<OrderItem> items) {
        try {
            connection.setAutoCommit(false);

            int orderId = insertOrder(order);

            if (items != null && !items.isEmpty()) {
                insertOrderItems(orderId, items);
            }

            connection.commit();
            return true;

        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public Order getOrderByNumber(String orderNumber) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_number = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, orderNumber);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderNumber(rs.getString("order_number"));
                order.setCustomerAddress(rs.getString("customer_address"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setDeliveryInstructions(rs.getString("delivery_instructions"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCardNumber(rs.getString("card_number"));
                order.setUpiId(rs.getString("upi_id"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setUserId(rs.getInt("user_id"));           // ✅ added
                order.setRestaurantId(rs.getInt("restaurant_id")); // ✅ added

                order.setOrderItems(getOrderItems(order.getOrderId()));

                return order;
            }
        }
        return null;
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        List<OrderItem> items = new ArrayList<>();

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setFoodName(rs.getString("food_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                items.add(item);
            }
        }
        return items;
    }

    @Override
    public List<Order> getAllOrders() throws SQLException {
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderNumber(rs.getString("order_number"));
                order.setCustomerAddress(rs.getString("customer_address"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setDeliveryInstructions(rs.getString("delivery_instructions"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setUserId(rs.getInt("user_id"));           // ✅ added
                order.setRestaurantId(rs.getInt("restaurant_id")); // ✅ added
                orders.add(order);
            }
        }
        return orders;
    }

    @Override
    public boolean updateOrderStatus(String orderNumber, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_number = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setString(2, orderNumber);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean cancelOrder(String orderNumber) {
        return updateOrderStatus(orderNumber, "Cancelled");
    }
public List<Order> getOrdersByUserId(int userId) throws SQLException {
    String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
    List<Order> orders = new ArrayList<>();

    try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
       pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("order_id"));
            order.setOrderNumber(rs.getString("order_number"));
            order.setOrderStatus(rs.getString("order_status"));
            order.setOrderDate(rs.getTimestamp("order_date"));
            order.setTotalAmount(rs.getDouble("total_amount"));
            order.setRestaurantId(rs.getInt("restaurant_id"));
            orders.add(order);
        }
    }
    return orders;
}

}