<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.RestaurantRequest" %>

<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<RestaurantRequest> list = (List<RestaurantRequest>) request.getAttribute("requests");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Requests</title>

<style>
body {
    font-family: 'Segoe UI', system-ui;
    background: #f4f7f6;
    margin: 0;
}

/* Container */
.container {
    max-width: 1100px;
    margin: 40px auto;
    padding: 20px;
}

/* Title */
h2 {
    text-align: center;
    color: #27ae60;
    margin-bottom: 30px;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
}

th {
    background: #2ecc71;
    color: white;
    padding: 15px;
}

td {
    padding: 14px;
    text-align: center;
    border-bottom: 1px solid #eee;
}

/* Hover effect */
tr:hover {
    background: #f9f9f9;
}

/* Buttons */
button {
    padding: 8px 14px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    margin: 2px;
}

/* Approve */
.approve-btn {
    background: #2ecc71;
    color: white;
}

/* Reject */
.reject-btn {
    background: #e74c3c;
    color: white;
}

/* Hover */
.approve-btn:hover {
    background: #27ae60;
}

.reject-btn:hover {
    background: #c0392b;
}

/* Back button */
.back-btn {
    display: inline-block;
    margin-top: 25px;
    padding: 10px 18px;
    background: #333;
    color: white;
    border-radius: 10px;
    text-decoration: none;
}

.back-btn:hover {
    background: black;
}

/* Empty message */
.no-data {
    text-align: center;
    margin-top: 30px;
    color: #777;
}
</style>
</head>

<body>

<div class="container">

<h2>📩 Restaurant Requests</h2>

<% if(list == null || list.isEmpty()) { %>

    <p class="no-data">No pending requests</p>

<% } else { %>

<table>
<tr>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Address</th>
    
    <th>Action</th>
</tr>

<% for(RestaurantRequest r : list){ %>

<tr>
    <td><%= r.getName() %></td>
    <td><%= r.getEmail() %></td>
    <td><%= r.getPhone() %></td>
    <td><%= r.getAddress() %></td>

    <!-- 🔥 DOCUMENT COLUMN -->
    <td>
        <% if(r.getDocument() != null && !r.getDocument().isEmpty()){ %>
            <a href="<%= request.getContextPath() %>/uploads/<%= r.getDocument() %>" target="_blank">
                View 📄
            </a>
        <% } else { %>
            No File
        <% } %>
    </td>

    <!-- ACTION -->
    <td>
        <form action="<%= request.getContextPath() %>/admin-requests" method="post" style="display:inline;">
            <input type="hidden" name="action" value="approve">
            <input type="hidden" name="id" value="<%= r.getRequestId() %>">
            <button class="approve-btn">Approve</button>
        </form>

        <form action="<%= request.getContextPath() %>/admin-requests" method="post" style="display:inline;">
            <input type="hidden" name="action" value="reject">
            <input type="hidden" name="id" value="<%= r.getRequestId() %>">
            <button class="reject-btn">Reject</button>
        </form>
    </td>
</tr>

<% } %>

</table>

<% } %>

<div style="text-align:center;">
    <a href="admin-dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>