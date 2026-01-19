// ==================== FILE 4: RestaurantServlet.java ====================
// File: com/delishio/controllers/RestaurantServlet.java
package com.delishio.controllers;

import com.delishio.dao.RestaurantDAO;
import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {
    
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            listRestaurants(request, response);
        } else if (action.equals("search")) {
            searchRestaurants(request, response);
        }
    }
    
    private void listRestaurants(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Restaurant> restaurants = restaurantDAO.getActiveRestaurants();
        request.setAttribute("restaurants", restaurants);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    
    private void searchRestaurants(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Restaurant> restaurants = restaurantDAO.searchRestaurants(keyword);
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}

