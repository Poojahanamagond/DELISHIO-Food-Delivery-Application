package com.delishio.models;

import java.sql.Timestamp;

public class Cart {
    private int cartId;
    private int userId;
    private int menuId;
    private int quantity;
    private Timestamp addedAt;
    
    private String itemName;
    private double price;
    private String imageUrl;

    public Cart(Integer userId2, int i, int restaurantId, int j, double d) {}

    // Getters and Setters
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public double getSubtotal() { return price * quantity; }

	@Override
	public String toString() {
		return "Cart [cartId=" + cartId + ", userId=" + userId + ", menuId=" + menuId + ", quantity=" + quantity
				+ ", addedAt=" + addedAt + ", itemName=" + itemName + ", price=" + price + ", imageUrl=" + imageUrl
				+ "]";
	}

	public int getMenuItemId() {
		// TODO Auto-generated method stub
		return 0;
	}
    
}