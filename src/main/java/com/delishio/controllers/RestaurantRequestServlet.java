package com.delishio.controllers;

import java.io.File;
import java.io.IOException;

import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.RestaurantRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/restaurantRequest")
public class RestaurantRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // 🔥 FILE PART
        Part filePart = request.getPart("document");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        // 🔥 SAVE TO MODEL
        RestaurantRequest r = new RestaurantRequest();
        r.setName(name);
        r.setEmail(email);
        r.setPhone(phone);
        r.setAddress(address);
        r.setDocument(fileName); // IMPORTANT

        RestaurantDAOImpl dao = new RestaurantDAOImpl();
        dao.saveRequest(r);

        response.sendRedirect("success.jsp");
    }
}