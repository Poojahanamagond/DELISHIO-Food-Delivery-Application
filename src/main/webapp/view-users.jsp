<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.User" %>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Delishio</title>
    <style>
    /* ==================== Customers Table View ==================== */
.admin-orders-card {
    background: var(--white);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    border-top: 6px solid #2ecc71; /* Matching Dashboard Green */
    margin-top: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

thead th {
    background-color: #f9fbf9;
    color: #2c3e50;
    text-align: left;
    padding: 18px 15px;
    border-bottom: 2px solid #edf2f0;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.85rem;
    letter-spacing: 0.5px;
}

tbody td {
    padding: 18px 15px;
    border-bottom: 1px solid #f1f1f1;
    color: #444;
    vertical-align: middle;
}

tbody tr:hover {
    background-color: #f8fff9; /* Very light green on hover */
    transition: background 0.2s ease;
}

/* Status Badge for Role */
.status-badge {
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: bold;
    display: inline-block;
    text-transform: capitalize;
}

/* Responsive fix */
@media (max-width: 768px) {
    .admin-orders-card {
        overflow-x: auto;
    }
}
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

   <div class="container">
    <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; margin-top: 20px;">
        <h1 style="color: var(--dark-green); margin: 0;">👥 Registered Customers</h1>
        <a href="admin-dashboard.jsp" class="btn btn-secondary" style="background: #eee; color: #555; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">← Dashboard</a>
    </header>

    <div class="admin-orders-card"> 
        <% if (users != null && !users.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email Address</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (User u : users) { %>
                        <tr>
                            <td style="font-weight: bold; color: #27ae60;"><%= u.getUserId() %></td>
                            <td style="font-weight: 500;"><%= u.getUsername() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getPhone() != null ? u.getPhone() : "N/A" %></td>
                            <td>
                                <span class="status-badge" style="background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9;">
                                    <%= u.getRole() %>
                                </span>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div style="text-align: center; padding: 50px;">
                <p style="color: #888; font-size: 1.1rem;">No customers found in the database.</p>
            </div>
        <% } %>
    </div>
</div>
</body>
</html>