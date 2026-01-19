package com.delishio.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.delishio.dao.UserDAO;
import com.delishio.daoimpl.UserDAOImpl;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");

        if (phone == null || phone.length() != 10) {
            request.setAttribute("error", "Enter valid phone number");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // ✅ Check phone number in DB
        if (!userDAO.isPhoneExists(phone)) {
            request.setAttribute("error", "Phone number not registered");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate OTP
        int otp = (int)(Math.random() * 900000) + 100000;

        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("phone", phone);

        // 🔒 SIMULATED OTP (for demo)
        request.setAttribute("debugOtp", otp);

        request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
    }
}
