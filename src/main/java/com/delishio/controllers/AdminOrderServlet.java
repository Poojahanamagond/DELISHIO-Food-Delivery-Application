package com.delishio.controllers;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.models.Order;
import com.delishio.util.MyConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin-orders")
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        Connection connection = MyConnection.getConnection();
        orderDAO = new OrderDAOImpl(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("admin-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String orderNumber = request.getParameter("orderNumber"); // ✅ match JSP
            String status = request.getParameter("status");

            boolean updated = orderDAO.updateOrderStatus(orderNumber, status);

            if (updated) {
                response.sendRedirect("admin-orders?success=Order status updated!");
            } else {
                response.sendRedirect("admin-orders?error=Failed to update order status!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}