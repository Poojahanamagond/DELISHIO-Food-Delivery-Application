<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin-Navbar</title>
<style>
.delishio-nav {
    background-color: #2ecc71; /* Exact green from Image 2 */
    padding: 15px 50px;
    color: white;
}
.nav-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
}
.brand {
    font-size: 1.5rem;
    font-weight: bold;
}
.admin-badge {
    font-size: 0.7rem;
    background: rgba(255,255,255,0.3);
    padding: 3px 8px;
    border-radius: 5px;
    margin-left: 10px;
    text-transform: uppercase;
}
.nav-links a {
    color: white;
    text-decoration: none;
    margin-left: 25px;
    font-weight: 500;
}
.btn-logout {
    background-color: #e74c3c !important; /* Red color */
    padding: 8px 20px !important;
    border-radius: 20px !important;
}
</style>
</head>
<body>
<nav class="delishio-nav">
    <div class="nav-content">
        <div class="brand">
            🍔 Delishio <span class="admin-badge">ADMIN PANEL</span>
        </div>
        <div class="nav-links">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="view-users">Customers</a>
            <a href="admin-orders">Orders</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </div>
</nav>
</body>
</html>