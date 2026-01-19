package com.delishio.models;

import java.io.Serializable;

public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int menuId;
    private String itemName;
    private double price;
    private int quantity;
    private String imageUrl;
    private int restaurantId;
    
    // Constructors
    public CartItem() {
    }
    
    public CartItem(int menuId, String itemName, double price, int quantity, String imageUrl, int restaurantId) {
        this.menuId = menuId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
        this.restaurantId = restaurantId;
    }
    
    // Getters and Setters
    public int getMenuId() {
        return menuId;
    }
    
    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }
    
    public String getItemName() {
        return itemName;
    }
    
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public int getRestaurantId() {
        return restaurantId;
    }
    
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
    
    // Calculate total price for this item
    public double getTotalPrice() {
        return price * quantity;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "menuId=" + menuId +
                ", itemName='" + itemName + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", totalPrice=" + getTotalPrice() +
                ", imageUrl='" + imageUrl + '\'' +
                ", restaurantId=" + restaurantId +
                '}';
    }
}