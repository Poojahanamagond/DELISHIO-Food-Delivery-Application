package com.delishio.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.RestaurantRequest;
import com.delishio.util.EmailUtil; // 🔥 IMPORT

@WebServlet("/admin-requests")
public class AdminRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RestaurantDAOImpl dao = new RestaurantDAOImpl();

        List<RestaurantRequest> list = dao.getAllRequests();

        request.setAttribute("requests", list);

        request.getRequestDispatcher("adminRequests.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if(action != null) {

            int id = Integer.parseInt(request.getParameter("id"));

            RestaurantDAOImpl dao = new RestaurantDAOImpl();

            // 🔥 GET EMAIL FIRST
            String email = dao.getEmailById(id);

            if("approve".equals(action)) {

                dao.approveRestaurant(id);

                EmailUtil.sendEmail(
                    email,
                    "Restaurant Approved 🎉",
                    "Hello,\n\nYour restaurant has been approved.\n\n- Team Delishio"+ "Please send us your complete menu details including:\n"
                    	    + "- Item names\n"
                    	    + "- Prices\n"
                    	    + "- Categories\n"
                    	    + "- Images (optional)\n\n"
                    	    + "Once received, our admin team will upload your menu.\n\n"
                    	    + "Thank you for joining Delishio!\n\n"
                    	    + "- Team Delishio"
                );

            } else if("reject".equals(action)) {

                dao.rejectRestaurant(id);

                // 🔥 SEND EMAIL
                EmailUtil.sendEmail(
                    email,
                    "Restaurant Rejected ❌",
                    "Sorry, your request was rejected. Please try again or contact support."
                );
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin-requests");
    }
}