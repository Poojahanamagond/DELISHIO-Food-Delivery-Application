<!-- ==================== FILE 13: add-restaurant.jsp ==================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Restaurant - Delishio</title>
   <style>
   /* Reuse the root variables from the dashboard */
:root {
    --primary-green: #2ecc71;
    --dark-green: #27ae60;
    --bg-light: #f4f7f6;
    --white: #ffffff;
    --text: #333;
    --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

body {
    background-color: var(--bg-light);
    font-family: 'Segoe UI', sans-serif;
}

.container {
    max-width: 800px;
    margin: 40px auto;
    padding: 0 20px;
}

/* Form Card Styling */
.admin-form-card {
    background: var(--white);
    padding: 40px;
    border-radius: 15px;
    box-shadow: var(--shadow);
    border-top: 6px solid var(--primary-green);
}

.admin-form-card h1 {
    margin-top: 0;
    color: var(--dark-green);
    font-size: 1.8rem;
    margin-bottom: 30px;
    text-align: center;
}

/* Form Groups */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: 600;
    margin-bottom: 8px;
    color: #555;
}

.form-group input, 
.form-group textarea {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    box-sizing: border-box; /* Crucial for padding */
    transition: all 0.3s ease;
}

.form-group input:focus, 
.form-group textarea:focus {
    border-color: var(--primary-green);
    outline: none;
    box-shadow: 0 0 8px rgba(46, 204, 113, 0.2);
}

/* Button Styling */
.form-actions {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.btn {
    padding: 12px 25px;
    border-radius: 8px;
    font-weight: bold;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    border: none;
    flex: 1;
}

.btn-primary {
    background-color: var(--primary-green);
    color: white;
}

.btn-primary:hover {
    background-color: var(--dark-green);
}

.btn-secondary {
    background-color: #eee;
    color: #666;
}

.btn-secondary:hover {
    background-color: #ddd;
}
   </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
    <div class="admin-form-card">
        <h1>🏪 Add New Restaurant</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error" style="background:#fff1f0; color:#d43f3a; padding:15px; border-radius:8px; margin-bottom:20px; border:1px solid #ffa39e;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="add-restaurant" method="post">
            <div class="form-group">
                <label for="name">Restaurant Name *</label>
                <input type="text" id="name" name="name" placeholder="Enter restaurant name" required>
            </div>
            
            <div class="form-group">
                <label for="cuisineType">Cuisine Type *</label>
                <input type="text" id="cuisineType" name="cuisineType" placeholder="e.g., Italian, Chinese" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address *</label>
                <textarea id="address" name="address" rows="3" placeholder="Full street address" required></textarea>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label for="phone">Phone *</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                
                <div class="form-group">
                    <label for="rating">Rating (0-5) *</label>
                    <input type="number" id="rating" name="rating" min="0" max="5" step="0.1" value="4.0" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="deliveryTime">Delivery Time *</label>
                <input type="text" id="deliveryTime" name="deliveryTime" placeholder="e.g., 30-45 mins" required>
            </div>
            
            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" placeholder="https://example.com/image.jpg">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Restaurant</button>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

