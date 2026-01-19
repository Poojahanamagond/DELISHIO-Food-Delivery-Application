package com.delishio.daoimpl;

import com.delishio.dao.RestaurantDAO;
import com.delishio.models.Restaurant;
import com.delishio.util.MyConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {
    
    private Connection connection;
    
    public RestaurantDAOImpl() {
        this.connection = MyConnection.getConnection();
    }
    
    @Override
    public Restaurant addRestaurant(Restaurant restaurant) {
        String sql = "INSERT INTO restaurants (name, cuisine_type, address, phone, rating, delivery_time, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setString(3, restaurant.getAddress());
            pstmt.setString(4, restaurant.getPhone());
            pstmt.setDouble(5, restaurant.getRating());
            pstmt.setString(6, restaurant.getDeliveryTime());
            pstmt.setString(7, restaurant.getImageUrl());
            pstmt.setInt(8, restaurant.getIsActive());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        restaurant.setRestaurantId(rs.getInt(1));
                        System.out.println("Restaurant added successfully with ID: " + restaurant.getRestaurantId());
                        return restaurant;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding restaurant: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        String sql = "SELECT * FROM restaurants WHERE restaurant_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractRestaurantFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching restaurant by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants ORDER BY rating DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all restaurants: " + e.getMessage());
            e.printStackTrace();
        }
        
        return restaurants;
    }
    
    @Override
    public List<Restaurant> getActiveRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE is_active = TRUE ORDER BY rating DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching active restaurants: " + e.getMessage());
            e.printStackTrace();
        }
        
        return restaurants;
    }
    
    @Override
    public boolean updateRestaurant(Restaurant restaurant) {
        String sql = "UPDATE restaurants SET name = ?, cuisine_type = ?, address = ?, phone = ?, rating = ?, delivery_time = ?, image_url = ?, is_active = ? WHERE restaurant_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setString(3, restaurant.getAddress());
            pstmt.setString(4, restaurant.getPhone());
            pstmt.setDouble(5, restaurant.getRating());
            pstmt.setString(6, restaurant.getDeliveryTime());
            pstmt.setString(7, restaurant.getImageUrl());
            pstmt.setInt(8, restaurant.getIsActive());
            pstmt.setInt(9, restaurant.getRestaurantId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error updating restaurant: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public boolean deleteRestaurant(int restaurantId) {
        String sql = "DELETE FROM restaurants WHERE restaurant_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, restaurantId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting restaurant: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    @Override
    public List<Restaurant> searchRestaurants(String keyword) {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE (name LIKE ? OR cuisine_type LIKE ?) AND is_active = TRUE";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(extractRestaurantFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching restaurants: " + e.getMessage());
            e.printStackTrace();
        }
        
        return restaurants;
    }
    
    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurantId(rs.getInt("restaurant_id"));
        restaurant.setName(rs.getString("name"));
        restaurant.setCuisineType(rs.getString("cuisine_type"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setPhone(rs.getString("phone"));
        restaurant.setRating(rs.getDouble("rating"));
        restaurant.setDeliveryTime(rs.getString("delivery_time"));
        restaurant.setImageUrl(rs.getString("image_url"));
        restaurant.setIsActive(rs.getInt("is_active"));
        restaurant.setCreatedAt(rs.getTimestamp("created_at"));
        return restaurant;
    }
}