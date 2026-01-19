
package com.delishio.controllers;

import com.delishio.dao.UserDAO;
import com.delishio.daoimpl.UserDAOImpl;
import com.delishio.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String email = request.getParameter("email");
    	String password = request.getParameter("password");

    	if (email == null || password == null) {
    	    request.setAttribute("error", "Invalid request!");
    	    request.getRequestDispatcher("/login.jsp").forward(request, response);
    	    return;
    	}

    	email = email.trim();
    	password = password.trim();

        User user = userDAO.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            response.sendRedirect(
                "admin".equals(user.getRole())
                        ? "admin-dashboard.jsp"
                        : "home.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
