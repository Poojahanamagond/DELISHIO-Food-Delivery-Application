package com.delishio.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.models.Order;
import com.delishio.util.MyConnection;
import com.sun.jdi.connect.spi.Connection;

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
        java.sql.Connection connection = MyConnection.getConnection();
        orderDAO = new OrderDAOImpl(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId"); // Make sure this is set during login
        List<Order> orders;
		try {
			orders = orderDAO.getOrdersByUserId(userId);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // You’ll need to implement this method

    }
}