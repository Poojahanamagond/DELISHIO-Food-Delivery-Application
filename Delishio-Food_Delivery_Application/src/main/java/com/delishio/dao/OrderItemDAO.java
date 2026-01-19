package com.delishio.dao;

import com.delishio.models.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    boolean addOrderItem(OrderItem orderItem);
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    boolean deleteOrderItemsByOrderId(int orderId);
}