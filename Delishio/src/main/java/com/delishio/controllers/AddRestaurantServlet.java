// ==================== FILE 5: AddRestaurantServlet.java ====================
// File: com/delishio/controllers/AddRestaurantServlet.java
package com.delishio.controllers;

import com.delishio.dao.RestaurantDAO;
import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/add-restaurant")
public class AddRestaurantServlet extends HttpServlet {
    
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.getRequestDispatcher("add-restaurant.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String name = request.getParameter("name");
        String cuisineType = request.getParameter("cuisineType");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        double rating = Double.parseDouble(request.getParameter("rating"));
        String deliveryTime = request.getParameter("deliveryTime");
        String imageUrl = request.getParameter("imageUrl");
        
        Restaurant restaurant = new Restaurant();
        restaurant.setName(name);
        restaurant.setCuisineType(cuisineType);
        restaurant.setAddress(address);
        restaurant.setPhone(phone);
        restaurant.setRating(rating);
        restaurant.setDeliveryTime(deliveryTime);
        restaurant.setImageUrl(imageUrl);
        restaurant.setIsActive(1);
        
        Restaurant addedRestaurant = restaurantDAO.addRestaurant(restaurant);
        
        if (addedRestaurant != null) {
            response.sendRedirect("admin-dashboard.jsp?success=Restaurant added successfully!");
        } else {
            request.setAttribute("error", "Failed to add restaurant!");
            request.getRequestDispatcher("add-restaurant.jsp").forward(request, response);
        }
    }
}