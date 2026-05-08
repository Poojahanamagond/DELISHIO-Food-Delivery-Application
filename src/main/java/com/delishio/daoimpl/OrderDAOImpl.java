package com.delishio.daoimpl;

import com.delishio.dao.OrderDAO;
import com.delishio.models.Order;
import com.delishio.models.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private Connection con;

    public OrderDAOImpl(Connection con) {
        this.con = con;
    }

    // 1️⃣ INSERT ORDER (returns generated order_id)
    @Override
    public int insertOrder(Order order) throws SQLException {

        String sql = "INSERT INTO orders " +
                "(user_id, customer_address, customer_phone, delivery_instructions, payment_method, total_amount, order_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'PLACED')";

        PreparedStatement ps =
                con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setInt(1, order.getUserId());
        ps.setString(2, order.getCustomerAddress());
        ps.setString(3, order.getCustomerPhone());
        ps.setString(4, order.getDeliveryInstructions());
        ps.setString(5, order.getPaymentMethod());
        ps.setDouble(6, order.getTotalAmount());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1); // order_id
        }
        return 0;
    }

    // 2️⃣ INSERT ORDER ITEMS
    @Override
    public void insertOrderItems(int orderId, List<OrderItem> items)
            throws SQLException {

        String sql = "INSERT INTO order_items " +
                "(order_id, food_id, food_name, quantity, price) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(sql);

        for (OrderItem item : items) {
            ps.setInt(1, orderId);
            ps.setString(2, item.getFoodName());
            ps.setString(3, item.getFoodName());
            ps.setInt(4, item.getQuantity());
            ps.setDouble(5, item.getPrice());
            ps.addBatch();
        }

        ps.executeBatch();
    }

    // 3️⃣ SAVE ORDER (MAIN METHOD USED BY SERVLET)
    @Override
    public boolean saveOrder(Order order, List<OrderItem> items) {

        try {
            con.setAutoCommit(false);

            int orderId = insertOrder(order);
            if (orderId == 0) {
                con.rollback();
                return false;
            }

            insertOrderItems(orderId, items);

            con.commit();
            return true;

        } catch (Exception e) {
            try { con.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            return false;
        }
    }

    // 4️⃣ GET ORDER BY ORDER NUMBER
    @Override
    public Order getOrderByNumber(String orderNumber) throws SQLException {

        String sql = "SELECT * FROM orders WHERE order_number=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, orderNumber);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Order o = new Order();
            o.setOrderId(rs.getInt("order_id"));
            o.setTotalAmount(rs.getDouble("total_amount"));
            o.setOrderStatus(rs.getString("order_status"));
            o.setOrderDate(rs.getTimestamp("order_date"));
            return o;
        }
        return null;
    }

    // 5️⃣ GET ORDER ITEMS
    @Override
    public List<OrderItem> getOrderItems(int orderId) throws SQLException {

        List<OrderItem> list = new ArrayList<>();

        String sql = "SELECT * FROM order_items WHERE order_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, orderId);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            OrderItem item = new OrderItem();
            item.setFoodName(rs.getString("food_name"));
            item.setQuantity(rs.getInt("quantity"));
            item.setPrice(rs.getDouble("price"));
            list.add(item);
        }
        return list;
    }

    // 6️⃣ ADMIN: GET ALL ORDERS
    @Override
    public List<Order> getAllOrders() throws SQLException {

        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Order o = new Order();
            o.setOrderId(rs.getInt("order_id"));
            o.setTotalAmount(rs.getDouble("total_amount"));
            o.setOrderStatus(rs.getString("order_status"));
            o.setOrderDate(rs.getTimestamp("order_date"));
            orders.add(o);
        }
        return orders;
    }

    // 7️⃣ UPDATE ORDER STATUS
    @Override
    public boolean updateOrderStatus(String orderNumber, String status) {

        try {
            String sql = "UPDATE orders SET order_status=? WHERE order_number=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, orderNumber);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 8️⃣ CANCEL ORDER
    @Override
    public boolean cancelOrder(String orderNumber) {
        return updateOrderStatus(orderNumber, "CANCELLED");
    }

    // 9️⃣ USER → MY ORDERS
    @Override
    public List<Order> getOrdersByUserId(int userId) throws SQLException {

        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Order o = new Order();
            o.setOrderId(rs.getInt("order_id"));
            o.setTotalAmount(rs.getDouble("total_amount"));
            o.setOrderStatus(rs.getString("order_status"));
            o.setOrderDate(rs.getTimestamp("order_date"));
            orders.add(o);
        }
        return orders;
    }
}
