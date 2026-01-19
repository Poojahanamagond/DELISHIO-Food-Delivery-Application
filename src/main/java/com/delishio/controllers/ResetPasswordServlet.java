package com.delishio.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.delishio.dao.UserDAO;
import com.delishio.daoimpl.UserDAOImpl;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String phone = (String) session.getAttribute("phone");
        String newPassword = request.getParameter("newPassword");

        userDAO.updatePasswordByPhone(phone, newPassword);

        session.invalidate();

        response.sendRedirect("login.jsp?success=Password reset successful");
    }
}