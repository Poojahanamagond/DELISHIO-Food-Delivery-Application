<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.Order" %>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Delishio</title>
    <style>
    /* ==================== Admin Orders Table ==================== */
.admin-orders-card {
    background: var(--white);
    padding: 30px;
    border-radius: 12px;
    box-shadow: var(--shadow);
    border-top: 6px solid var(--primary-green);
    margin-top: 20px;
    overflow-x: auto; /* Ensures table is responsive on mobile */
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

thead th {
    background-color: #f8f9fa;
    color: var(--text-dark);
    text-align: left;
    padding: 15px;
    border-bottom: 2px solid #eee;
    font-weight: 600;
}

tbody td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
}

tbody tr:hover {
    background-color: #fcfdfc;
}

/* Status Badges */
.status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: bold;
    text-transform: capitalize;
}

.status-confirmed { background: #e3f2fd; color: #1976d2; }
.status-preparing { background: #fff3e0; color: #ef6c00; }
.status-out_for_delivery { background: #f3e5f5; color: #8e24aa; }
.status-delivered { background: #e8f5e9; color: #2e7d32; }
.status-cancelled { background: #ffebee; color: #c62828; }

/* Table Form Elements */
.admin-orders-table select {
    padding: 8px;
    border-radius: 6px;
    border: 1px solid #ddd;
    font-size: 0.9rem;
    cursor: pointer;
}

.no-results {
    text-align: center;
    padding: 40px;
    color: #888;
    font-style: italic;
}
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

  <div class="container">
    <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="margin: 0;">📦 All Orders</h1>
        <a href="admin-dashboard.jsp" class="btn btn-secondary" style="padding: 10px 20px;">← Dashboard</a>
    </header>

    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            ✅ <%= request.getParameter("success") %>
        </div>
    <% } %>

    <div class="admin-orders-card">
        <% if (orders != null && !orders.isEmpty()) { %>
            <div class="admin-orders-table">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orders) { %>
                            <tr>
                                <td style="font-weight: bold; color: var(--dark-green);">#<%= order.getOrderId() %></td>
                                <td>User ID: <%= order.getUserId() %></td>
                                <td>₹<%= String.format("%.2f", order.getTotalAmount()) %></td>
                                <td>
                                    <span class="status-badge status-<%= order.getOrderStatus() %>">
                                        <%= order.getOrderStatus().replace("_", " ") %>
                                    </span>
                                </td>
                                <td><%= order.getCreatedAt() %></td>
                                <td>
                                    <form action="admin-orders" method="post" style="display: inline;">
                                        <input type="hidden" name="orderNumber" value="<%= order.getOrderNumber() %>">
                                        <select name="status" onchange="this.form.submit()" style="border-color: var(--primary-green);">
                                            <option value="">Update Status</option>
                                            <option value="confirmed" <%= "confirmed".equals(order.getOrderStatus()) ? "selected" : "" %>>Confirmed</option>
                                            <option value="preparing" <%= "preparing".equals(order.getOrderStatus()) ? "selected" : "" %>>Preparing</option>
                                            <option value="out_for_delivery" <%= "out_for_delivery".equals(order.getOrderStatus()) ? "selected" : "" %>>Out for Delivery</option>
                                            <option value="delivered" <%= "delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                                            <option value="cancelled" <%= "cancelled".equals(order.getOrderStatus()) ? "selected" : "" %>>Cancelled</option>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="no-results">
                <img src="img/empty-orders.png" alt="No orders" style="width: 100px; opacity: 0.3; display: block; margin: 0 auto 20px;">
                <p>No orders have been placed yet.</p>
            </div>
        <% } %>
    </div>


        <a href="admin-dashboard.jsp" class="btn">← Back to Dashboard</a>
    </div>
</body>
</html>