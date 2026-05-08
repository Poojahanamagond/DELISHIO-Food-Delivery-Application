package com.delishio.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.delishio.dao.MenuDAO;
import com.delishio.daoimpl.MenuDAOImpl;
import com.delishio.models.MenuItem;

@WebServlet("/mood")
public class MoodServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mood = request.getParameter("mood");

        MenuDAO menuDAO = new MenuDAOImpl();
        List<MenuItem> menuList = menuDAO.getFoodByMood(mood);

        String combo = null;

        if ("happy".equalsIgnoreCase(mood)) {
            combo = "Burger + Coke 🍔🥤";
        } 
        else if ("sad".equalsIgnoreCase(mood)) {
            combo = "Ice Cream + Chocolate 🍨🍫";
        } 
        else if ("tired".equalsIgnoreCase(mood)) {
            combo = "Coffee + Sandwich ☕🥪";
        }

        request.setAttribute("menuList", menuList);
        request.setAttribute("combo", combo);
        request.setAttribute("mood", mood);

        // ✅ CORRECT FILE NAME
        request.getRequestDispatcher("voiceResults.jsp").forward(request, response);
    }
}