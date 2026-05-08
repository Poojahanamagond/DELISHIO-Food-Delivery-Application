<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.List,com.delishio.models.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<h2>📦 My Orders</h2>

<% if (orders == null || orders.isEmpty()) { %>
    <p>You have not placed any orders yet.</p>
<% } else { %>
    <% for (Order o : orders) { %>
        <div style="border:1px solid #ccc; padding:12px; margin-bottom:10px">
            <b>Order ID:</b> <%= o.getOrderId() %><br>
            <b>Total:</b> ₹<%= o.getTotalAmount() %><br>
            <b>Status:</b> <%= o.getOrderStatus() %><br>
            <b>Date:</b> <%= o.getOrderDate() %>
        </div>
    <% } %>
<% } %>

</body>
</html>