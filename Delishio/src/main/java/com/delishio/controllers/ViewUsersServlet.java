package com.delishio.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.delishio.daoimpl.UserDAOImpl; // Assuming you have a UserDAO
import com.delishio.models.User;

@WebServlet("/view-users") // This MUST match the href in your admin card
public class ViewUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch users from Database
        UserDAOImpl userDao = new UserDAOImpl();
        List<User> userList = userDao.getAllUsers();
        
        // 2. Attach list to the request
        request.setAttribute("users", userList);
        
        // 3. Forward to the JSP page
        request.getRequestDispatcher("view-users.jsp").forward(request, response);
    }
}