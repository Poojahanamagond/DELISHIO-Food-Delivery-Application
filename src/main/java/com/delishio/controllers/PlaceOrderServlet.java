package com.delishio.controllers;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl; // Assuming you're using the DAO/DAOimpl split
import com.delishio.models.Order;
import com.delishio.models.OrderItem;
import com.delishio.util.MyConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Random;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String instructions = request.getParameter("instructions");
            String paymentMethod = request.getParameter("paymentMethod");
            String cardNumber = request.getParameter("cardNumber");
            String upiId = request.getParameter("upiId");

            // Generate order number
            String orderNumber = "DL" + new Random().nextInt(999999);

            // Get cart items from session
            HttpSession session = request.getSession();
            List<OrderItem> cartItems = (List<OrderItem>) session.getAttribute("cart");

            // Calculate total amount
            double totalAmount = 0;
            if (cartItems != null) {
                for (OrderItem item : cartItems) {
                    totalAmount += item.getPrice() * item.getQuantity();
                }
            }

            // Create order object
            Order order = new Order(orderNumber, address, phone, instructions,
                                    paymentMethod, totalAmount);

            // Set payment details based on method
            if ("card".equals(paymentMethod) && cardNumber != null) {
                String maskedCard = "****-****-****-" + cardNumber.replaceAll("\\s", "").substring(12);
                order.setCardNumber(maskedCard);
            } else if ("upi".equals(paymentMethod) && upiId != null) {
                order.setUpiId(upiId);
            }

            // Save order to database using MyConnection
            Connection connection = MyConnection.getConnection();
            OrderDAO orderDAO = new OrderDAOImpl(connection);

            boolean success = orderDAO.saveOrder(order, cartItems);

            if (success) {
                session.setAttribute("orderNumber", orderNumber);
                session.setAttribute("address", address);
                session.setAttribute("phone", phone);
                session.setAttribute("paymentMethod", paymentMethod);
                session.setAttribute("totalAmount", totalAmount);
                session.removeAttribute("cart");
                response.sendRedirect("order-success.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to place order. Please try again.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

            MyConnection.closeConnection();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("checkout.jsp");
    }
}