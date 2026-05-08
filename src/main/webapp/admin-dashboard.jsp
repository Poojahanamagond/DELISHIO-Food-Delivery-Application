<!-- ==================== FILE 12: admin-dashboard.jsp ==================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Delishio</title>
    <style>
    /* ==================== Green Theme Admin Dashboard ==================== */
:root {
    --primary-green: #2ecc71;
    --dark-green: #27ae60;
    --background-gray: #f4f7f6;
    --text-dark: #2c3e50;
    --white: #ffffff;
    --shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}


body {
    background-color: var(--background-gray);
    color: var(--text-dark);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
}

.container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

h1 {
    color: var(--dark-green);
    font-size: 2.5rem;
    margin-bottom: 10px;
}

/* Alert Styling */
.alert-success {
    background-color: #d4edda;
    color: #155724;
    padding: 15px;
    border-radius: 8px;
    border-left: 5px solid var(--primary-green);
    margin-bottom: 30px;
}

/* Admin Grid Layout */
.admin-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1-fr));
    gap: 25px;
    margin-top: 30px;
}

/* Card Styling */
.admin-card {
    background: var(--white);
    padding: 30px;
    border-radius: 12px;
    box-shadow: var(--shadow);
    transition: transform 0.3s ease, border-color 0.3s ease;
    border-top: 5px solid var(--primary-green);
    text-align: center;
}

.admin-card:hover {
    transform: translateY(-5px);
    border-top-color: var(--dark-green);
}

.admin-card h2 {
    color: var(--text-dark);
    font-size: 1.5rem;
    margin-bottom: 15px;
}

.admin-card p {
    color: #7f8c8d;
    margin-bottom: 25px;
}

/* Button Styling */
.btn {
    display: inline-block;
    padding: 12px 24px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: bold;
    transition: background 0.3s ease;
}

.btn-primary {
    background-color: var(--primary-green);
    color: white;
}

.btn-primary:hover {
    background-color: var(--dark-green);
    box-shadow: 0 4px 10px rgba(46, 204, 113, 0.3);
}

/* Navbar Integration (Assuming your navbar uses these) */
nav {
    background-color: var(--dark-green) !important;
    padding: 1rem;
    box-shadow: var(--shadow);
}
    </style>
</head>
<body>
    <%@ include file="admin-navbar.jsp" %>
    
    <div class="container">
        <h1>👨‍💼 Admin Dashboard</h1>
        
   <p style="font-size: 1.1rem; color: #666;">Welcome back, <strong><%= username %></strong>!</p>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <div class="admin-grid">
        <div class="admin-card">
    <h2>📩 Restaurant Requests</h2>
    <p>Approve or reject new restaurant registrations</p>
    <a href="admin-requests" class="btn btn-primary">View Requests</a>
</div>
            <div class="admin-card">
                <h2>🏪 Restaurants</h2>
                <p>Manage restaurant listings</p>
                <a href="add-restaurant" class="btn btn-primary">Add Restaurant</a>
            </div>
            
            <div class="admin-card">
                <h2>🍕 Menu Items</h2>
                <p>Add and manage menu items</p>
                <a href="add-menu" class="btn btn-primary">Add Menu Item</a>
            </div>
            
            <div class="admin-card">
                <h2>📦 Orders</h2>
                <p>View and manage all orders</p>
                <a href="admin-orders" class="btn btn-primary">View Orders</a>
            </div>
            
            <div class="admin-card">
    <h2>👥 Customers</h2>
    <p>View customer information</p>
    <a href="view-users" class="btn btn-primary">View Customers</a>
</div>

   
   
        </div>
    </div>
</body>
</html>

