package com.delishio.dao;

import com.delishio.models.Order;
import com.delishio.models.OrderItem;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    int insertOrder(Order order) throws SQLException;
    void insertOrderItems(int orderId, List<OrderItem> items) throws SQLException;
    boolean saveOrder(Order order, List<OrderItem> items);
    Order getOrderByNumber(String orderNumber) throws SQLException;
    List<OrderItem> getOrderItems(int orderId) throws SQLException;
    List<Order> getAllOrders() throws SQLException;
    boolean updateOrderStatus(String orderNumber, String status);
    boolean cancelOrder(String orderNumber);
	List<Order> getOrdersByUserId(int userId) throws SQLException;
}