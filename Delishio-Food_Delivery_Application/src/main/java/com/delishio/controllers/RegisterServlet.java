// ==================== FILE 1: RegisterServlet.java ====================
// File: com/delishio/controllers/RegisterServlet.java
package com.delishio.controllers;

import com.delishio.dao.UserDAO;
import com.delishio.daoimpl.UserDAOImpl;
import com.delishio.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (username == null || email == null || password == null) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("customer");

        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?success=Registration successful!");
        } else {
            request.setAttribute("error", "Registration failed!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
