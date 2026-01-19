
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.delishio.models.CartItem" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    Double subtotal = (Double) request.getAttribute("subtotal");
    Double total = (Double) request.getAttribute("total");
    
    if (subtotal == null) subtotal = 0.0;
    if (total == null) total = 0.0;
%>
<%
    Integer cartRestaurantId = (Integer) session.getAttribute("cartRestaurantId");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart - Delishio</title>
    <style>
* { margin:0; padding:0; box-sizing:border-box; }

/* ===== COLORS ===== */
:root{
  --green:#8fcf6f;
  --green-dark:#76b85a;
  --green-light:#cdeac7;
  --text-dark:#2b2b2b;
  --text-light:#555;
  --border:rgba(0,0,0,0.08);
}

/* ===== BODY ===== */
body{
  font-family:'Segoe UI',system-ui;
  min-height:100vh;
  background: linear-gradient(135deg, var(--green-light), var(--green));
  color:var(--text-dark);
}

/* ===== HEADER ===== */
.cart-header{
  background:white;
  border-radius:20px;
  padding:20px;
  text-align:center;
  margin:20px auto;
  max-width:1200px;
  box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.cart-header h1{
  font-size:32px;
  font-weight:700;
  display:flex;
  justify-content:center;
  align-items:center;
  gap:10px;
  color:var(--text-dark);
}

.back-link{
  display:inline-block;
  margin:10px 5px;
  padding:8px 18px;
  background:linear-gradient(135deg,var(--green),var(--green-dark));
  color:white;
  text-decoration:none;
  border-radius:999px;
  font-weight:600;
  transition:.3s;
}

.back-link:hover{
  transform:translateY(-2px) scale(1.02);
  box-shadow:0 8px 24px rgba(79,157,63,0.35);
}

/* ===== CART CONTAINER ===== */
.cart-container{
  max-width:1200px;
  margin:20px auto;
  display:grid;
  grid-template-columns:1fr 350px;
  gap:25px;
  padding:0 10px;
}

@media(max-width:1024px){ .cart-container{ grid-template-columns:1fr; } }

/* ===== CART ITEMS ===== */
.cart-items{
  background:white;
  border-radius:20px;
  padding:20px;
  box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.cart-item{
  display:flex;
  gap:20px;
  padding:15px;
  border-bottom:1px solid var(--border);
  align-items:center;
  transition:.3s;
}

.cart-item:hover{
  transform:translateY(-3px);
  box-shadow:0 8px 20px rgba(0,0,0,0.1);
}

.item-image{
  width:100px;
  height:100px;
  border-radius:15px;
  overflow:hidden;
  flex-shrink:0;
  box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

.item-image img{
  width:100%;
  height:100%;
  object-fit:cover;
}

.item-details{
  flex:1;
}

.item-name{
  font-size:18px;
  font-weight:700;
  color:var(--text-dark);
  margin-bottom:6px;
}

.item-price{
  font-size:16px;
  font-weight:600;
  color:var(--green-dark);
}

.item-controls{
  display:flex;
  align-items:center;
  gap:10px;
}

.quantity-control{
  display:flex;
  align-items:center;
  gap:10px;
  background:#f5f5f5;
  padding:6px 12px;
  border-radius:25px;
}

.quantity-btn{
  width:30px;
  height:30px;
  border:none;
  background:linear-gradient(135deg,var(--green),var(--green-dark));
  color:white;
  border-radius:50%;
  cursor:pointer;
  font-size:18px;
  display:flex;
  justify-content:center;
  align-items:center;
  transition:.3s;
}

.quantity-btn:hover{
  transform:scale(1.1);
  box-shadow:0 4px 12px rgba(79,157,63,0.35);
}

.item-total{
  font-weight:700;
  font-size:16px;
  min-width:80px;
  text-align:right;
  color:var(--text-dark);
}

.remove-btn{
  padding:6px 12px;
  background:	green;
  color:white;
  border:none;
  border-radius:8px;
  cursor:pointer;
  font-size:13px;
  transition:.3s;
}

.remove-btn:hover{
  transform:translateY(-2px);
  box-shadow:0 5px 20px rgba(255,107,107,0.35);
}

/* ===== ORDER SUMMARY ===== */
.order-summary{
  background:white;
  border-radius:20px;
  padding:25px;
  box-shadow:0 10px 30px rgba(0,0,0,0.08);
  position:sticky;
  top:20px;
}

.order-summary h2{
  font-size:22px;
  font-weight:700;
  margin-bottom:20px;
  color:var(--green-dark);
}

.summary-row{
  display:flex;
  justify-content:space-between;
  margin-bottom:10px;
  font-size:14px;
  color:var(--text-light);
}

.summary-row.total{
  font-size:18px;
  font-weight:700;
  color:var(--text-dark);
  margin-top:15px;
  padding-top:10px;
  border-top:1px solid var(--border);
}

.place-order-btn{
  width:100%;
  padding:12px;
  border:none;
  border-radius:999px;
  cursor:pointer;
  font-weight:600;
  font-size:16px;
  background:linear-gradient(135deg,var(--green),var(--green-dark));
  color:white;
  margin-top:15px;
  transition:.3s;
}

.place-order-btn:hover{
  transform:translateY(-2px) scale(1.02);
  box-shadow:0 8px 24px rgba(79,157,63,0.35);
}

/* ===== EMPTY CART ===== */
.empty-cart{
  text-align:center;
  padding:50px 20px;
  color:var(--text-light);
}

.empty-cart-icon{
  font-size:80px;
  margin-bottom:15px;
}

.empty-cart h2{
  font-size:26px;
  margin-bottom:10px;
}

.continue-shopping{
  display:inline-block;
  padding:12px 30px;
  border-radius:999px;
  font-weight:600;
  text-decoration:none;
  background:linear-gradient(135deg,var(--green),var(--green-dark));
  color:white;
  transition:.3s;
}

.continue-shopping:hover{
  transform:translateY(-2px) scale(1.02);
  box-shadow:0 8px 20px rgba(79,157,63,0.35);
}
</style>
    
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="cart-header">
    <h1>🛒 My Cart</h1>

    <% if (cartRestaurantId != null) { %>
        <!-- Add More Items button -->
        <a href="<%= request.getContextPath() %>/menu?restaurantId=<%= cartRestaurantId %>" class="back-link">➕ Add More Items</a>
        <!-- Continue Shopping button -->
        <a href="<%= request.getContextPath() %>/restaurants" class="back-link">← Continue Shopping</a>
    <% } else { %>
        <!-- Only Continue Shopping if no restaurant in cart -->
        <a href="<%= request.getContextPath() %>/restaurants" class="back-link">← Continue Shopping</a>
    <% } %>
</div>

<% if (cartItems != null && !cartItems.isEmpty()) { %>
    <div class="cart-container">
        <!-- Cart Items Section -->
        <div class="cart-items">
            <% for (CartItem item : cartItems) { %>
                <div class="cart-item">
                    <div class="item-image">
                        <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                            <img src="<%= request.getContextPath() %>/images/<%= item.getImageUrl() %>" 
                                 alt="<%= item.getItemName() %>" onerror="this.src='<%= request.getContextPath() %>/images/default-food.png'">
                        <% } else { %>
                            <img src="<%= request.getContextPath() %>/images/default-food.png" alt="<%= item.getItemName() %>">
                        <% } %>
                    </div>
                    <div class="item-details">
                        <div class="item-name"><%= item.getItemName() %></div>
                        <div class="item-price">₹<%= String.format("%.2f", item.getPrice()) %> per unit</div>
                    </div>
                    <div class="item-controls">
                        <div class="quantity-control">
                            <!-- Decrease -->
                            <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="operation" value="decrease">
                                <button type="submit" class="quantity-btn">−</button>
                            </form>
                            <span class="quantity-display"><%= item.getQuantity() %></span>
                            <!-- Increase -->
                            <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="operation" value="increase">
                                <button type="submit" class="quantity-btn">+</button>
                            </form>
                        </div>
                        <div class="item-total">₹<%= String.format("%.2f", item.getTotalPrice()) %></div>
                        <!-- Remove -->
                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Order Summary Section -->
        <div class="order-summary">
            <h2>Order Summary</h2>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹<%= String.format("%.2f", subtotal) %></span>
            </div>
            <div class="summary-row total">
                <span>Total</span>
                <span>₹<%= String.format("%.2f", total) %></span>
            </div>

            <!-- Payment Method -->
           <form action="<%= request.getContextPath() %>/checkout" method="get">
    <button type="submit" class="place-order-btn">
        Proceed to Checkout
    </button>
</form>

        </div>
    </div>
<% } else { %>
    <!-- Empty Cart -->
    <div class="cart-items">
        <div class="empty-cart">
            <div class="empty-cart-icon">🛒</div>
            <h2>Your Cart is Empty</h2>
            <p>Looks like you haven't added anything to your cart yet.</p>
            <a href="<%= request.getContextPath() %>/restaurants" class="continue-shopping">Start Shopping</a>
        </div>
    </div>
<% } %>

<script>
function togglePayment() {
    let method = document.getElementById("paymentMethod").value;

    document.getElementById("upiBox").style.display =
        method === "UPI" ? "block" : "none";

    document.getElementById("cardBox").style.display =
        method === "CARD" ? "block" : "none";
}
</script>

</body>
</html>
