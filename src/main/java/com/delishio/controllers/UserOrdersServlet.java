package com.delishio.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.models.Order;
import com.delishio.models.User;
import com.delishio.util.MyConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class UserOrdersServlet extends HttpServlet {

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

        // 🔒 Login check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Get logged-in user
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        try {
            // ✅ Fetch user orders
            List<Order> orders = orderDAO.getOrdersByUserId(userId);

            // ✅ Send to JSP
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("my-orders.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
        }
    }
}
