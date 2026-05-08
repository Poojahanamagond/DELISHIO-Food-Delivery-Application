package com.delishio.daoimpl;

import com.delishio.dao.RestaurantDAO;
import com.delishio.models.Restaurant;
import com.delishio.models.RestaurantRequest;
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
    public boolean addRestaurantRequest(RestaurantRequest r) {

        boolean status = false;

        try {
            Connection con = MyConnection.getConnection();

            String query = "INSERT INTO restaurant_requests(name,email,phone,address) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, r.getName());
            ps.setString(2, r.getEmail());
            ps.setString(3, r.getPhone());
            ps.setString(4, r.getAddress());

            int rows = ps.executeUpdate();

            if(rows > 0) status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
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

    public List<RestaurantRequest> getAllRequests() {

        List<RestaurantRequest> list = new ArrayList<>();

        try {
            Connection con = MyConnection.getConnection();

            String query = "SELECT * FROM restaurant_requests WHERE status='PENDING'";

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                RestaurantRequest r = new RestaurantRequest();

                r.setRequestId(rs.getInt("request_id"));
                r.setName(rs.getString("name"));
                r.setEmail(rs.getString("email"));
                r.setPhone(rs.getString("phone"));
                r.setAddress(rs.getString("address"));
                r.setDocument(rs.getString("document"));

                list.add(r);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void approveRestaurant(int id) {

        try {
            Connection con = MyConnection.getConnection();

            // 🔥 1. CHECK ALREADY APPROVED OR NOT
            PreparedStatement check = con.prepareStatement(
                "SELECT approved FROM restaurant_requests WHERE request_id=?"
            );
            check.setInt(1, id);

            ResultSet rs = check.executeQuery();

            if(rs.next()) {

                int approved = rs.getInt("approved");

                // ✅ ONLY IF NOT APPROVED
                if(approved == 0) {

                    // 🔥 2. INSERT INTO restaurants
                    PreparedStatement insert = con.prepareStatement(
                        "INSERT INTO restaurants (name, address, phone, is_active) " +
                        "SELECT name, address, phone, 1 FROM restaurant_requests WHERE request_id=?"
                    );
                    insert.setInt(1, id);
                    insert.executeUpdate();

                    // 🔥 3. UPDATE STATUS + APPROVED FLAG
                    PreparedStatement update = con.prepareStatement(
                        "UPDATE restaurant_requests SET status='approved', approved=1 WHERE request_id=?"
                    );
                    update.setInt(1, id);
                    update.executeUpdate();

                    System.out.println("Restaurant approved & added!");
                } else {
                    System.out.println("Already approved. Skipping insert.");
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void rejectRestaurant(int id) {

        try {
            Connection con = MyConnection.getConnection();

            String query = "UPDATE restaurant_requests SET status='REJECTED' WHERE request_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void saveRestaurantRequest(String name, String email, String phone, String address, String document) {

        try {
            Connection con = MyConnection.getConnection();

            String query = "INSERT INTO restaurant_requests(name,email,phone,address,document) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, document);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

	public void saveRequest(RestaurantRequest r) {
		
		try {
            Connection con = MyConnection.getConnection();

            String sql = "INSERT INTO restaurant_requests(name,email,phone,address,document) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, r.getName());
            ps.setString(2, r.getEmail());
            ps.setString(3, r.getPhone());
            ps.setString(4, r.getAddress());
            ps.setString(5, r.getDocument()); // 🔥 MUST

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
		
	}

	public String getEmailById(int id) {

    String email = null;

    try {
        Connection con = MyConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT email FROM restaurant_requests WHERE request_id=?"
        );

        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            email = rs.getString("email");
        }

    } catch(Exception e) {
        e.printStackTrace();
    }

    return email;
}}