<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>

<%
    response.setCharacterEncoding("UTF-8");
%>

<%@ page import="java.util.Map" %>
<%@ page import="com.delishio.models.CartItem" %>
<%@ page import="com.delishio.models.User" %>

<%
    User navUser = (User) session.getAttribute("user");
    
    // Calculate cart count
    int cartCount = 0;
    Map<Integer, CartItem> navCart = (Map<Integer, CartItem>) session.getAttribute("cart");
    if (navCart != null) {
        for (CartItem item : navCart.values()) {
            cartCount += item.getQuantity();
        }
    }
%>
<style>
.navbar {
    /* Matches your Wine Home Page Background */
    background: green; 
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    padding: 12px 0;
    position: sticky;
    top: 0;
    z-index: 1000;
    border-bottom: 1px solid rgba(255, 215, 0, 0.2); /* Subtle Gold border */
}

/* NAVBAR CONTAINER */
.navbar-container {
    max-width: 2000px;
    margin: 0 auto;
    padding: 0 30px;
    display: flex;
    align-items: center;
    /* This creates the split: Logo on left, everything else on right */
    justify-content: space-between; 
}

.logo {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    font-size: 26px;
    font-weight: 800;
    background: linear-gradient(90deg, #fceabb, #f8b500);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    /* Reset margin to let flexbox handle positioning */
    margin-right: 0; 
}

/* RIGHT SECTION WRAPPER */

/* We group the Menu and User Info together */
.right-section {
    display: flex;
    align-items: center;
    gap: 40px; 
}
/* MENU */
.nav-menu {
    display: flex;
    align-items: center;
    list-style: none;
    gap: 30px;
}

/* USER INFO AREA */
.user-info {
    display: flex;
    align-items: center;
    gap: 20px;
    padding-left: 25px;
    /* Optional: vertical divider line */
    border-left: 1px solid rgba(255, 255, 255, 0.2); 
}

/* Style for the emoji/icons in links */
.nav-link {
    color: #fceabb;
    text-decoration: none;
    font-weight: 500;
    transition: 0.3s;
}

.nav-link:hover {
    color: #f8b500;
}
/* LOGO - Gold Text */
.logo {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    font-size: 26px;
    font-weight: 800;
    /* Gold Gradient Logo */
    background: linear-gradient(90deg, #fceabb, #f8b500);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-right: 50px; 
}

/* MENU LINKS - Cream/White Text */
.nav-menu {
    display: flex;
    align-items: center;
    list-style: none;
    gap: 35px;
}

.nav-link {
    text-decoration: none;
    color: #fceabb; /* Cream color */
    font-size: 15px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    opacity: 0.9;
}

.nav-link:hover {
    color: #f8b500; /* Turns Gold on hover */
    opacity: 1;
    transform: translateY(-1px);
}

/* CART BADGE - High Contrast */
.cart-icon {
    position: relative;
}

.cart-badge {
    position: absolute;
    top: -10px;
    right: -12px;
    background: #f8b500; /* Gold Badge */
    color: #4a0404; /* Wine Text */
    border-radius: 50%;
    width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    font-weight: 800;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

/* USER AREA */
.user-info {
    margin-left: auto; 
    display: flex;
    align-items: center;
    gap: 25px;
}

.user-name {
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 6px;
}

/* LOGOUT BUTTON - Sleek Gold */
.logout-btn {
    padding: 8px 18px;
    background: transparent;
    color: #f8b500;
    border: 1.5px solid #f8b500;
    border-radius: 8px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 700;
    text-decoration: none;
    transition: all 0.3s;
}

.logout-btn:hover {
    background: #f8b500;
    color: #4a0404;
    box-shadow: 0 0 15px rgba(248, 181, 0, 0.4);
}
</style>

<nav class="navbar">
    <div class="navbar-container">
        <a href="<%= request.getContextPath() %>/home" class="logo">
            <span style="-webkit-text-fill-color: initial;">🍔</span>
            <span>Delishio</span>
        </a>
        
        <ul class="nav-menu">
            <li>
                <a href="<%= request.getContextPath() %>/restaurants" class="nav-link">🏠 Home</a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/restaurants" class="nav-link">🍽️ Restaurants</a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/cart" class="nav-link cart-icon">
                    🛒 Cart
                    <% if (cartCount > 0) { %>
                        <span class="cart-badge"><%= cartCount %></span>
                    <% } %>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/orders" class="nav-link">📦 Orders</a>
            </li>
        </ul>
        
        <div class="user-info">
            <% if (navUser != null) { %>
                <span class="user-name">
                    👤 <%= navUser.getUsername() %>
                </span>
                <a href="<%= request.getContextPath() %>/logout" class="logout-btn">
                    Logout
                </a>
            <% } %>
        </div>
    </div>
</nav>