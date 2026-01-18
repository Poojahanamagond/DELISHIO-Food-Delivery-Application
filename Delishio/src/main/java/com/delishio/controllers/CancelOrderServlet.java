package com.delishio.controllers;

import com.delishio.dao.OrderDAO;
import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.util.MyConnection;   // use your existing connection utility

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderNumber = request.getParameter("orderNumber"); // use orderNumber, not orderId

        try (Connection connection = MyConnection.getConnection()) {
            OrderDAO orderDAO = new OrderDAOImpl(connection);

            boolean cancelled = orderDAO.cancelOrder(orderNumber);

            if (cancelled) {
                response.sendRedirect("cancel-success.jsp");
            } else {
                response.sendRedirect("orders.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}