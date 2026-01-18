<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.MenuItem" %>
<%@ page import="com.delishio.models.Restaurant" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= restaurant != null ? restaurant.getName() : "Menu" %> - Delishio</title>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
* {margin:0;padding:0;box-sizing:border-box;}

:root{
  /* Updated to your Wine & Gold Palette */
  --wine-dark: #4a0404;
  --wine-light: #720917;
  --gold: #f8b500;
  --cream: #fceabb;
  --bg-white: #ffffff;
  --text-dark: #1a1a1a;
  --text-gray: #666;
  --border: rgba(74, 4, 4, 0.1);
}

body{
  font-family:'Segoe UI',system-ui;
  min-height:100vh;
  background: var(--bg-white);
  color: var(--text-dark);
  overflow-x: hidden;
}

.container{
  max-width:1300px;
  margin:0 auto;
  padding: 20px;
}

/* ===== RESTAURANT HEADER ===== */
.restaurant-header{
  background:#98FB98;
  border-radius:25px;
  padding:40px;
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-bottom:40px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.05);
  border: 1px solid var(--border);
}

.restaurant-header h1{
  font-size:36px;
  font-weight:900;
  /* Wine Gradient Text */
  background:black;
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
  margin-bottom:10px;
}

.cuisine-type {
  font-weight: 600;
  color: var(--text-gray);
  margin-bottom: 8px;
}

.restaurant-meta span {
    background: #fdf2f2;
    color: var(--wine-light);
    padding: 5px 15px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 700;
    margin-right: 10px;
}

/* ===== MENU GRID ===== */
.menu-grid{
  display:grid;
  grid-template-columns:repeat(auto-fill, minmax(300px, 1fr));
  gap:30px;
}

/* ===== MENU CARD ===== */
.menu-card{
  background: white;
  border-radius:25px;
  overflow:hidden;
  box-shadow: 0 10px 25px rgba(0,0,0,0.05);
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
  border: 1px solid var(--border);
}

.menu-card:hover{
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(74, 4, 4, 0.1);
  border-color: green;
}

.menu-image img{
  width:100%;
  height:200px;
  object-fit:cover;
  transition: 0.5s;
}

.menu-card:hover .menu-image img{
  transform: scale(1.1);
}

.menu-info{
  padding:25px;
}

.menu-info h3{
  font-size:20px;
  font-weight:800;
  color: var(--wine-dark);
  margin-bottom:10px;
}

.category{
  display:inline-block;
  background: var(--gold);
  color: var(--wine-dark);
  padding:4px 12px;
  border-radius:50px;
  font-size:11px;
  font-weight: 800;
  margin-bottom:12px;
  text-transform: uppercase;
}

.description{
  font-size:14px;
  color:var(--text-gray);
  line-height: 1.5;
  height: 42px;
  overflow: hidden;
  margin-bottom:15px;
}

/* ===== FOOTER & PRICE ===== */
.menu-footer{
  display:flex;
  justify-content:space-between;
  align-items:center;
  margin-top:20px;
  padding-top: 15px;
  border-top: 1px solid #f5f5f5;
}

.price{
  font-size:22px;
  font-weight:900;
  color: var(--wine-dark);
}

/* ===== BUTTONS (WINE GRADIENT) ===== */
.btn-primary{
  padding:12px 25px;
  border:none;
  border-radius:15px;
  background:green;
  color:white;
  font-weight:700;
  cursor:pointer;
  text-decoration:none;
  transition:.3s;
  box-shadow: 0 5px 15px rgba(74, 4, 4, 0.2);
}

.btn-primary:hover{
  transform: scale(1.05);
  box-shadow: 0 8px 20px rgba(74, 4, 4, 0.3);
}

.btn-back {
    background: transparent;
    color: black;
    border: 2px solid var(--wine-dark);
    margin-top: 10px;
    display: inline-block;
}

.btn-back:hover {
    background: gold;
    color: white;
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){
  .restaurant-header { flex-direction: column; text-align: center; }
  .restaurant-header .btn-primary { margin-top: 20px; }
}
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <% if (restaurant != null) { %>
            <div class="restaurant-header" data-aos="fade-down">
                <div class="restaurant-details">
                    <h1><%= restaurant.getName() %></h1>
                    <p class="cuisine-type">🍴 <%= restaurant.getCuisineType() %></p>
                    <div class="restaurant-meta">
                        <span class="rating">⭐ <%= restaurant.getRating() %></span>
                        <span class="delivery-time">🕒 <%= restaurant.getDeliveryTime() %> mins</span>
                    </div>
                    <p style="margin-top:10px; color:#888;">📍 <%= restaurant.getAddress() %></p>
                </div>
                <a href="<%= request.getContextPath() %>/restaurants" class="btn-primary btn-back">
                    ← Back to Restaurants
                </a>
            </div>

            <h2 style="margin-bottom:30px; font-weight:800; color:var(--wine-dark);">Menu Selection</h2>

            <div class="menu-grid">
                <% if (menuItems != null && !menuItems.isEmpty()) {
                    int delay = 0;
                    for (MenuItem item : menuItems) { %>
                        <div class="menu-card" data-aos="fade-up" data-aos-delay="<%= delay %>">
                            <div class="menu-image">
                                <img src="<%= request.getContextPath() %>/images/<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "default-food.png" %>" 
                                     alt="<%= item.getItemName() %>"
                                     onerror="this.src='<%= request.getContextPath() %>/images/default-food.png'">
                            </div>
                            <div class="menu-info">
                                <span class="category"><%= item.getCategory() %></span>
                                <h3><%= item.getItemName() %></h3>
                                <p class="description"><%= item.getDescription() %></p>
                                
                                <div class="menu-footer">
                                    <span class="price">₹<%= String.format("%.0f", item.getPrice()) %></span>
                                    <% if (item.isAvailable()) { %>
                                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                            <input type="hidden" name="quantity" value="1">
                                            <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">
                                            <button type="submit" class="btn-primary">Add +</button>
                                        </form>
                                    <% } else { %>
                                        <span style="color:#ccc; font-weight:700;">Sold Out</span>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    <% delay += 100; }
                } else { %>
                    <p style="grid-column: 1/-1; text-align: center; padding: 50px;">No items found.</p>
                <% } %>
            </div>
        <% } %>
    </div>

    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
    </script>
</body>
</html>