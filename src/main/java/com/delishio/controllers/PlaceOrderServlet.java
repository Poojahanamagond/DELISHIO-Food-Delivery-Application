package com.delishio.controllers;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.models.Order;
import com.delishio.models.OrderItem;
import com.delishio.util.MyConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String instructions = request.getParameter("instructions");
        String paymentMethod = request.getParameter("paymentMethod");

        List<OrderItem> cart =
                (List<OrderItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double total = 0;
        for (OrderItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setCustomerAddress(address);
        order.setCustomerPhone(phone);
        order.setDeliveryInstructions(instructions);
        order.setPaymentMethod(paymentMethod);
        order.setTotalAmount(total);

        try (Connection con = MyConnection.getConnection()) {
            OrderDAO dao = new OrderDAOImpl(con);

            boolean success = dao.saveOrder(order, cart);

            if (success) {
                session.removeAttribute("cart");
                response.sendRedirect("order-success.jsp");
            } else {
                request.setAttribute("error", "Order failed");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
