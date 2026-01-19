package com.delishio.models;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private String orderNumber;
    private String customerAddress;
    private String customerPhone;
    private String deliveryInstructions;
    private String paymentMethod;
    private String cardNumber;
    private String upiId;
    private String orderStatus;
    private Timestamp orderDate;
    private double totalAmount;
    private List<OrderItem> orderItems;
    private int userId;          // ✅ for linking to user
    private int restaurantId;    // ✅ for linking to restaurant

    // Constructors
    public Order() {}

    public Order(String orderNumber, String customerAddress, String customerPhone,
                 String deliveryInstructions, String paymentMethod, double totalAmount) {
        this.orderNumber = orderNumber;
        this.customerAddress = customerAddress;
        this.customerPhone = customerPhone;
        this.deliveryInstructions = deliveryInstructions;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.orderStatus = "Confirmed"; // default status
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getDeliveryInstructions() { return deliveryInstructions; }
    public void setDeliveryInstructions(String deliveryInstructions) { this.deliveryInstructions = deliveryInstructions; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

    public String getUpiId() { return upiId; }
    public void setUpiId(String upiId) { this.upiId = upiId; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    // Alias for JSP compatibility
    public Timestamp getCreatedAt() { return orderDate; }
}