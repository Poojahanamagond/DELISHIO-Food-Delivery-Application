<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.Restaurant" %>
<%@ page import="com.delishio.dao.RestaurantDAO" %>
<%@ page import="com.delishio.daoimpl.RestaurantDAOImpl" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
    List<Restaurant> restaurants = restaurantDAO.getActiveRestaurants();
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - Delishio</title>

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Segoe UI',system-ui;
    min-height:100vh;
    /* Wine/Burgundy Gradient */
    background: white; 
    color: #ffffff; /* Changed default text to white for readability */
    overflow-x: hidden;
}

.wrapper{
    width:100%;
    max-width: 1800px;
    margin: 0 auto;
    padding:0 30px 60px;
}

/* HEADER ANIMATION */
.page-header{
    text-align:center;
    margin:40px 0;
    animation: floatHeader 4s ease-in-out infinite;
}
@keyframes floatHeader {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.page-header h1{
    font-size:42px;
    font-weight:900;
    background: linear-gradient(90deg, #fceabb, #f8b500);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* SEARCH GLASSMORPISM */
.search-section{
    display:flex;
    justify-content:center;
    margin-bottom:40px;
}
.search-input{
    padding:15px 25px;
    border-radius:999px 0 0 999px;
    border: 1px solid #e0e0e0;
    width:400px;
    font-size:16px;
    outline: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
}
.search-section .btn{
    padding:15px 35px;
    border-radius:0 999px 999px 0;
    border:none;
    background:green;
    color:white;
    font-weight:700;
    cursor:pointer;
    transition: 0.3s;
}
.search-section .btn:hover{
    letter-spacing: 1px;
    box-shadow: 0 5px 15px rgba(118, 184, 90, 0.4);
}

/* ADVANCED BANNER WITH KEN BURNS EFFECT */
.banner-container{
    width:100%;
    height:620px;
    position:relative;
    overflow:hidden;
    border-radius:30px;
    margin-bottom:50px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}

.banner{
    position:absolute;
    inset:0;
    background-size:cover;
    background-position:center;
    opacity:0;
    transform: scale(1.1); /* Start slightly zoomed for Ken Burns */
    transition: opacity 1.5s ease-in-out, transform 6s linear;
}

.banner.active{
    opacity:1;
    transform: scale(1); /* Zoom out effect while active */
}

/* BANNER OVERLAY GRADIENT */
.banner-container::after {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.4), transparent);
    pointer-events: none;
}

/* RESTAURANTS GRID */
.restaurants-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(320px,1fr));
    gap:30px;
    width:100%;
}

/* MODERN CARD DESIGN */
.restaurant-card{
    background:white;
    border-radius:25px;
    overflow:hidden;
    box-shadow: 0 10px 20px rgba(0,0,0,0.05);
    transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    position: relative;
    border: 1px solid #f0f0f0;
}

.restaurant-card:hover{
    transform: translateY(-15px) scale(1.02);
    box-shadow: 0 30px 60px rgba(0,0,0,0.12);
    border-color: #76b85a;
}

.restaurant-image{
    position: relative;
    overflow: hidden;
}

.restaurant-image img{
    width:100%;
    height:240px;
    object-fit:cover;
    transition: transform 0.6s ease;
}

.restaurant-card:hover .restaurant-image img{
    transform: scale(1.15);
}

/* "OPEN" TAG SPECIAL */
.restaurant-card::before {
    content: 'TOP RATED';
    position: absolute;
    top: 20px;
    right: 20px;
    background: #ffcc00;
    color: #000;
    padding: 5px 12px;
    border-radius: 50px;
    font-size: 10px;
    font-weight: 800;
    z-index: 5;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

.restaurant-info{
    padding: 25px;
}
.restaurant-info h3{
    font-size:22px;
    font-weight:800;
    margin-bottom:10px;
    color: #1a1a1a;
}

.restaurant-meta{
    display:flex;
    gap: 15px;
    font-size:14px;
    margin: 15px 0;
}

.rating-pill {
    background: #fff9e6;
    color: #f1c40f;
    padding: 4px 10px;
    border-radius: 8px;
    font-weight: 700;
}

.time-pill {
    background: #f0f7ff;
    color: #3498db;
    padding: 4px 10px;
    border-radius: 8px;
    font-weight: 700;
}

.restaurant-info .btn{
    display:block;
    margin-top:20px;
    padding:14px;
    text-align:center;
    border-radius:15px;
    background: #000; /* Sleek black button */
    color:white;
    font-weight:700;
    text-decoration:none;
    transition: 0.3s;
}

.restaurant-card:hover .btn {
    background: green;
    transform: scale(1.05);
}

/* RESPONSIVE BANNER HEIGHT */
@media (max-width:1024px){ .banner-container{height:400px;} }
@media (max-width:768px){ 
    .banner-container{height:300px;} 
    .search-input { width: 200px; }
}
</style>
</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="wrapper">

    <div class="page-header">
        <h1>Welcome, <%= username %>!</h1>
        <p>Your favorite meals are just one click away.</p>
    </div>

    <div class="search-section" data-aos="fade-up">
        <form action="restaurants" method="get" style="display: flex;">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" class="search-input"
                   placeholder="Search sushi, pizza, burgers...">
            <button class="btn">Search</button>
        </form>
    </div>

    <div class="banner-container" data-aos="zoom-in">
        <div class="banner active" style="background-image:url('images/banner.png')"></div>
        <div class="banner" style="background-image:url('images/banner02.png')"></div>
    </div>

    <div class="restaurants-grid">
    <% if(restaurants!=null && !restaurants.isEmpty()){
        int delay = 0;
        for(Restaurant restaurant:restaurants){ %>

        <div class="restaurant-card" data-aos="fade-up" data-aos-delay="<%= delay %>">
            <div class="restaurant-image">
                <img src="<%= request.getContextPath() %>/images/<%= restaurant.getImageUrl() %>" loading="lazy">
            </div>
            <div class="restaurant-info">
                <h3><%= restaurant.getName() %></h3>
                <p style="color: #888;">🍴 <%= restaurant.getCuisineType() %></p>
                <div class="restaurant-meta">
                    <span class="rating-pill">⭐ <%= restaurant.getRating() %></span>
                    <span class="time-pill">🕒 <%= restaurant.getDeliveryTime() %></span>
                </div>
                <p style="font-size: 13px; color:black;">📍 <%= restaurant.getAddress() %></p>
                <a class="btn"
                   href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>">
                   Explore Menu
                </a>
            </div>
        </div>

    <% delay += 100; } } else { %>
        <p>No restaurants available.</p>
    <% } %>
    </div>

</div>



<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
// Initialize Scroll Animations
AOS.init({
    duration: 1000,
    once: true
});

// Advanced Banner Logic with Ken Burns Reset
let banners=document.querySelectorAll(".banner");
let index=0;

setInterval(()=>{
    // Remove active class
    banners[index].classList.remove("active");
    
    // Increment index
    index=(index+1)%banners.length;
    
    // Add active class (Triggers CSS transitions)
    banners[index].classList.add("active");
}, 5000); // 5 seconds gives more time for the Ken Burns zoom to show
</script>

</body>
</html>