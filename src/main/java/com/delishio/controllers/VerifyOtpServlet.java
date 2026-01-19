package com.delishio.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int enteredOtp = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();

        int sessionOtp = (int) session.getAttribute("otp");

        if (enteredOtp == sessionOtp) {
            response.sendRedirect("reset-password.jsp");
        } else {
            request.setAttribute("error", "Invalid OTP");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }
}
