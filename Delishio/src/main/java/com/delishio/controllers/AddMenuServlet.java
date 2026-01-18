package com.delishio.controllers;

import com.delishio.dao.MenuDAO;
import com.delishio.dao.RestaurantDAO;
import com.delishio.daoimpl.MenuDAOImpl;
import com.delishio.daoimpl.RestaurantDAOImpl;
import com.delishio.models.MenuItem;
import com.delishio.models.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/add-menu")
public class AddMenuServlet extends HttpServlet {

    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
        request.setAttribute("restaurants", restaurants);
        request.getRequestDispatcher("add-menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MenuItem item = new MenuItem();
        item.setRestaurantId(Integer.parseInt(request.getParameter("restaurantId")));
        item.setItemName(request.getParameter("itemName"));
        item.setPrice(Double.parseDouble(request.getParameter("price")));

        menuDAO.addMenuItem(item);
        response.sendRedirect("admin-dashboard.jsp");
    }
}
