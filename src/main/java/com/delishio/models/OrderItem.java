package com.delishio.models;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int menuItemId;
    private String menuItemName;
    private int quantity;
    private double subtotal;
    private int itemId;
    private String FoodName;
    private Double Price;

    public OrderItem() {
    }

	public OrderItem(int orderItemId, int orderId, int menuItemId, String menuItemName, int quantity, double subtotal,
			int itemId, String foodName, Double price) {
		super();
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuItemId = menuItemId;
		this.menuItemName = menuItemName;
		this.quantity = quantity;
		this.subtotal = subtotal;
		this.itemId = itemId;
		FoodName = foodName;
		Price = price;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getMenuItemId() {
		return menuItemId;
	}

	public void setMenuItemId(int menuItemId) {
		this.menuItemId = menuItemId;
	}

	public String getMenuItemName() {
		return menuItemName;
	}

	public void setMenuItemName(String menuItemName) {
		this.menuItemName = menuItemName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getFoodName() {
		return FoodName;
	}

	public void setFoodName(String foodName) {
		FoodName = foodName;
	}

	public Double getPrice() {
		return Price;
	}

	public void setPrice(Double price) {
		Price = price;
	}

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId + ", menuItemId=" + menuItemId
				+ ", menuItemName=" + menuItemName + ", quantity=" + quantity + ", subtotal=" + subtotal + ", itemId="
				+ itemId + ", FoodName=" + FoodName + ", Price=" + Price + "]";
	}

	


    
}