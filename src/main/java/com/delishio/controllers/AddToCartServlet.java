package com.delishio.controllers;

import com.delishio.models.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String foodName = request.getParameter("foodName");
        String quantityStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");
        
        try {
            int quantity = Integer.parseInt(quantityStr);
            double price = Double.parseDouble(priceStr);
            
            // Create order item
            OrderItem item = new OrderItem(quantity, quantity, quantity, foodName, quantity, price, quantity, priceStr, price);
            
            // Get cart from session
            HttpSession session = request.getSession();
            List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new ArrayList<>();
            }
            
            // Check if item already exists in cart
            boolean itemExists = false;
            for (OrderItem cartItem : cart) {
                if (cartItem.getFoodName().equals(foodName)) {
                    // Update quantity
                    cartItem.setQuantity(cartItem.getQuantity() + quantity);
                    itemExists = true;
                    break;
                }
            }
            
            // Add new item if it doesn't exist
            if (!itemExists) {
                cart.add(item);
            }
            
            // Save cart to session
            session.setAttribute("cart", cart);
            
            // Send response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"message\": \"Item added to cart\"}");
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid input\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("menu.jsp");
    }
}