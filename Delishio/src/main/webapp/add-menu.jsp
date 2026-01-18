<!-- ==================== FILE 14: add-menu.jsp ==================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.Restaurant" %>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Menu Item - Delishio</title>
   <style>
   /* ==================== Add Menu Specific Styles ==================== */
/* Container for the form to match dashboard spacing */
.admin-container {
    max-width: 900px;
    margin: 50px auto;
    padding: 0 20px;
}

/* The Main Form Card - Matching the Dashboard Look */
.admin-form-container {
    background: #ffffff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    border-top: 6px solid #2ecc71; /* The Green Accent */
}

.admin-form-container h1 {
    color: #27ae60;
    margin-bottom: 30px;
    text-align: center;
    font-size: 2rem;
}

/* Input Fields */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #2c3e50;
}

.form-group input, 
.form-group select, 
.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

.form-group input:focus {
    border-color: #2ecc71;
    outline: none;
}

/* Button Layout */
.form-actions {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.btn {
    flex: 1;
    padding: 15px;
    border-radius: 30px;
    font-weight: bold;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    border: none;
}

.btn-primary {
    background-color: #2ecc71;
    color: white;
}

.btn-secondary {
    background-color: #ecf0f1;
    color: #7f8c8d;
}
   </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
<div class="admin-container">
    <div class="admin-form-container">
        <h1>🍕 Add Menu Item</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error" style="background: #fee; color: #c0392b; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 5px solid #c0392b;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="add-menu" method="post">
            <div class="form-group">
                <label for="restaurantId">🏪 Select Restaurant</label>
                <select id="restaurantId" name="restaurantId" required>
                    <option value="">-- Choose Restaurant --</option>
                    <% if (restaurants != null) {
                        for (Restaurant restaurant : restaurants) { %>
                            <option value="<%= restaurant.getRestaurantId() %>"><%= restaurant.getName() %></option>
                    <%  }
                    } %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="itemName">Food Item Name</label>
                <input type="text" id="itemName" name="itemName" placeholder="e.g. Paneer Butter Masala" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="3" placeholder="Briefly describe the dish..." required></textarea>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label for="price">Price (₹)</label>
                    <input type="number" id="price" name="price" min="0" step="0.01" placeholder="299.00" required>
                </div>
                
                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" required>
                        <option value="">-- Select Category --</option>
                        <option value="Appetizer">Appetizer</option>
                        <option value="Main Course">Main Course</option>
                        <option value="Dessert">Dessert</option>
                        <option value="Beverage">Beverage</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" placeholder="paste-image-link-here.jpg">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Add Menu Item</button>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

