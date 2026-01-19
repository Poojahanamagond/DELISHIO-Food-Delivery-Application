package com.delishio.models;

import java.sql.Timestamp;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String cuisineType;
    private String address;
    private String phone;
    private double rating;
    private String deliveryTime;
    private String imageUrl;
    private int isActive;
    private Timestamp createdAt;

    public Restaurant() {}

    // Getters and Setters
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    
    public String getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

	@Override
	public String toString() {
		return "Restaurant [restaurantId=" + restaurantId + ", name=" + name + ", cuisineType=" + cuisineType
				+ ", address=" + address + ", phone=" + phone + ", rating=" + rating + ", deliveryTime=" + deliveryTime
				+ ", imageUrl=" + imageUrl + ", isActive=" + isActive + ", createdAt=" + createdAt + "]";
	}
    
    
}