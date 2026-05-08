package com.delishio.controllers;

import java.io.IOException;
import java.sql.Connection;

import com.delishio.daoimpl.OrderDAOImpl;
import com.delishio.util.MyConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myOrders")
public class OrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = MyConnection.getConnection()) {
            OrderDAOImpl dao = new OrderDAOImpl(con);
            request.setAttribute("orders", dao.getOrdersByUserId(userId));
            request.getRequestDispatcher("my-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
