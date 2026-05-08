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
*{margin:0;padding:0;box-sizing:border-box;}

body{
    font-family:'Segoe UI',system-ui;
    min-height:100vh;
    background: white; 
    color: #ffffff;
    overflow-x: hidden;
}

.wrapper{
    width:100%;
    max-width: 1800px;
    margin: 0 auto;
    padding:0 30px 60px;
}

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
}

.banner-container{
    width:100%;
    height:620px;
    position:relative;
    overflow:hidden;
    border-radius:30px;
    margin-bottom:50px;
}

.banner{
    position:absolute;
    inset:0;
    background-size:cover;
    background-position:center;
    opacity:0;
    transform: scale(1.1);
    transition: opacity 1.5s ease-in-out, transform 6s linear;
}
.banner.active{
    opacity:1;
    transform: scale(1);
}

.restaurants-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(320px,1fr));
    gap:30px;
}

.restaurant-card{
    background:white;
    border-radius:25px;
    overflow:hidden;
}

.restaurant-image img{
    width:100%;
    height:240px;
    object-fit:cover;
}

.restaurant-info{
    padding:25px;
}
.restaurant-info h3{
    color:black;
}

.restaurant-meta{
    display:flex;
    gap:15px;
}

.rating-pill { background:#fff9e6; padding:4px 10px; }
.time-pill { background:#f0f7ff; padding:4px 10px; }

.restaurant-info .btn{
    display:block;
    margin-top:20px;
    padding:14px;
    text-align:center;
    border-radius:15px;
    background:black;
    color:white;
    text-decoration:none;
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

    <div class="search-section">
        <form action="restaurants" method="get" style="display: flex;">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" class="search-input"
                   placeholder="Search sushi, pizza, burgers...">
            <button class="btn">Search</button>
        </form>
    </div>

    <button type="button" onclick="startVoice()" style="
    margin-left:10px;
    padding:12px 18px;
    border-radius:50%;
    border:none;
    background:black;
    color:white;
    cursor:pointer;
">
🎤
</button>

    <div class="banner-container">
        <div class="banner active" style="background-image:url('images/banner.png')"></div>
        <div class="banner" style="background-image:url('images/banner02.png')"></div>
    </div>

    <div class="restaurants-grid">
    <% for(Restaurant restaurant:restaurants){ %>

        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="<%= request.getContextPath() %>/images/<%= restaurant.getImageUrl() %>">
            </div>
            <div class="restaurant-info">
                <h3><%= restaurant.getName() %></h3>
                <div class="restaurant-meta">
                    <span class="rating-pill">⭐ <%= restaurant.getRating() %></span>
                    <span class="time-pill">🕒 <%= restaurant.getDeliveryTime() %></span>
                </div>
                <a class="btn"
                   href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>">
                   Explore Menu
                </a>
            </div>
        </div>

    <% } %>
    </div>

</div>


<script>
function startVoice() {

    const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();

    recognition.onresult = function(event) {

        let text = event.results[0][0].transcript.toLowerCase();

        alert("You said: " + text);

        // 🎯 ONLY MOOD LOGIC
        if(text.includes("happy") || text.includes("sad") || text.includes("tired")) {

            fetch("<%= request.getContextPath() %>/mood", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "mood=" + encodeURIComponent(text)
            })
            .then(res => res.text())
            .then(data => {
                document.open();
                document.write(data);
                document.close();
            });

        } else {
            alert("Try saying: I feel happy / sad / tired");
        }
    };

    recognition.onerror = function() {
        alert("Voice not supported. Use Chrome.");
    };

    recognition.start();
}
</script>

</body>
</html>