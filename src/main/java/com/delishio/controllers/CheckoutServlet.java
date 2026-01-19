package com.delishio.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // Show checkout page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    // Handle form submission
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();

        // Get form data
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String instructions = request.getParameter("instructions");
        String paymentMethod = request.getParameter("paymentMethod");

        // Get total amount from session cart or set default
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        if (totalAmount == null) totalAmount = 0.0;

        // Generate random order number
        String orderNumber = "DEL" + (10000 + new Random().nextInt(90000));

        // Save order details in session
        session.setAttribute("orderNumber", orderNumber);
        session.setAttribute("address", address);
        session.setAttribute("phone", phone);
        session.setAttribute("instructions", instructions);
        session.setAttribute("paymentMethod", paymentMethod);
        session.setAttribute("totalAmount", totalAmount);

        // Optionally, you can also clear the cart here
        // session.removeAttribute("cart");

        // Redirect to order success page
        response.sendRedirect("order-success.jsp");
    }
}
