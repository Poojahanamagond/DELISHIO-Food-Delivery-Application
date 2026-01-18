package com.delishio.controllers;

import com.delishio.dao.MenuDAO;
import com.delishio.dao.RestaurantDAO;
import com.delishio.daoimpl.MenuDAOImpl;
import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.MenuItem;
import com.delishio.models.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
        System.out.println("MenuServlet initialized successfully!");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("MenuServlet doGet called");

        HttpSession session = request.getSession(false);

        try {
            // Get restaurantId parameter
            String restaurantIdParam = request.getParameter("restaurantId");

            // SESSION FALLBACK: if parameter is missing, try session
            if ((restaurantIdParam == null || restaurantIdParam.isEmpty() || restaurantIdParam.equals("null"))
                    && session != null && session.getAttribute("cartRestaurantId") != null) {
                restaurantIdParam = session.getAttribute("cartRestaurantId").toString();
                System.out.println("Fallback restaurant ID from session: " + restaurantIdParam);
            }

            if (restaurantIdParam == null || restaurantIdParam.isEmpty() || restaurantIdParam.equals("null")) {
                System.out.println("No restaurant ID provided, redirecting to restaurants");
                response.sendRedirect(request.getContextPath() + "/restaurants");
                return;
            }
            
            int restaurantId = Integer.parseInt(restaurantIdParam);
            System.out.println("Parsed restaurant ID: " + restaurantId);
            
            // Get restaurant details
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
            System.out.println("Restaurant found: " + (restaurant != null ? restaurant.getName() : "null"));
            
            if (restaurant == null) {
                System.out.println("Restaurant not found, redirecting");
                response.sendRedirect(request.getContextPath() + "/restaurants");
                return;
            }

            // Save restaurantId in session for cart/add-more flow
            if (session != null) {
                session.setAttribute("cartRestaurantId", restaurantId);
            }
            
            // Get menu items
            List<MenuItem> menuItems = menuDAO.getMenuByRestaurantId(restaurantId);
            System.out.println("Menu items found: " + (menuItems != null ? menuItems.size() : "null"));
            
            // Set attributes
            request.setAttribute("menuItems", menuItems);
            request.setAttribute("restaurant", restaurant);
            
            // Forward to JSP
            System.out.println("Forwarding to menu.jsp");
            request.getRequestDispatcher("/menu.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid restaurant ID format: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/restaurants");
        } catch (Exception e) {
            System.err.println("Error in MenuServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/restaurants");
        }
    }
}
