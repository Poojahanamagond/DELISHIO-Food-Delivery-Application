package com.delishio.models;

import java.sql.Timestamp;

public class MenuItem {
    private int menuId;
    private int restaurantId;
    private String itemName;
    private String description;
    private double price;
    private String category;
    private String imageUrl;
    private boolean isAvailable;
    private Timestamp createdAt;

    public MenuItem() {}

    // Getters and Setters
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

	@Override
	public String toString() {
		return "MenuItem [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName
				+ ", description=" + description + ", price=" + price + ", category=" + category + ", imageUrl="
				+ imageUrl + ", isAvailable=" + isAvailable + ", createdAt=" + createdAt + "]";
	}
    
}