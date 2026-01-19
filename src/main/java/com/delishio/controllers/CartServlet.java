package com.delishio.controllers;

import com.delishio.dao.MenuDAO;
import com.delishio.daoimpl.MenuDAOImpl;
import com.delishio.models.MenuItem;
import com.delishio.models.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private MenuDAO menuDAO;
    
    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
        System.out.println("CartServlet initialized successfully!");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        
        // Convert cart to list for display
        List<CartItem> cartItems = new ArrayList<>(cart.values());
        
        // Calculate totals
        double subtotal = 0.0;
        for (CartItem item : cartItems) {
            subtotal += item.getTotalPrice();
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal); // Add delivery charges if needed
        
        System.out.println("Cart size: " + cartItems.size());
        System.out.println("Subtotal: " + subtotal);
        
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Get or create cart
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        
        try {
            if ("add".equals(action)) {
                addToCart(request, cart);
            } else if ("update".equals(action)) {
                updateCartQuantity(request, cart);
            } else if ("remove".equals(action)) {
                removeFromCart(request, cart);
            } else if ("clear".equals(action)) {
                cart.clear();
            }
            
            session.setAttribute("cart", cart);
            
        } catch (Exception e) {
            System.err.println("Error in CartServlet: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Redirect back to cart page
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void addToCart(HttpServletRequest request, Map<Integer, CartItem> cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        
        System.out.println("Adding to cart - Menu ID: " + menuId + ", Quantity: " + quantity);
        
        // Get menu item details from database
        MenuItem menuItem = menuDAO.getMenuItemById(menuId);
        
        if (menuItem != null) {
            if (cart.containsKey(menuId)) {
                // Item already in cart, update quantity
                CartItem existingItem = cart.get(menuId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                System.out.println("Updated existing item. New quantity: " + existingItem.getQuantity());
            } else {
                // Add new item to cart
                CartItem cartItem = new CartItem();
                cartItem.setMenuId(menuItem.getMenuId());
                cartItem.setItemName(menuItem.getItemName());
                cartItem.setPrice(menuItem.getPrice());
                cartItem.setQuantity(quantity);
                cartItem.setImageUrl(menuItem.getImageUrl());
                cartItem.setRestaurantId(restaurantId);
                
                cart.put(menuId, cartItem);
                System.out.println("Added new item to cart: " + menuItem.getItemName());
            }
        }
    }
    
    private void updateCartQuantity(HttpServletRequest request, Map<Integer, CartItem> cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        String operation = request.getParameter("operation");
        
        System.out.println("Update cart - Menu ID: " + menuId + ", Operation: " + operation);
        
        if (cart.containsKey(menuId)) {
            CartItem item = cart.get(menuId);
            
            if ("increase".equals(operation)) {
                item.setQuantity(item.getQuantity() + 1);
                System.out.println("Increased quantity to: " + item.getQuantity());
            } else if ("decrease".equals(operation)) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                    System.out.println("Decreased quantity to: " + item.getQuantity());
                } else {
                    cart.remove(menuId);
                    System.out.println("Removed item from cart (quantity was 1)");
                }
            }
        }
    }
    
    private void removeFromCart(HttpServletRequest request, Map<Integer, CartItem> cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        cart.remove(menuId);
        System.out.println("Removed item from cart - Menu ID: " + menuId);
    }
}