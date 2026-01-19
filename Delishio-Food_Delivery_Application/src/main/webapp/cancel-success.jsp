<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Order Cancelled</title>
<style>
body{
    background:#fff3f3;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    font-family:Arial;
}
.box{
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 10px 30px rgba(0,0,0,.2);
    text-align:center;
}
h2{color:#cdeac7};
a{
    display:inline-block;
    margin-top:15px;
    padding:10px 20px;
    background:#cdeac7             
    color:white;
    border-radius:8px;
    text-decoration:none;
    
  
}

/* ===== BODY BACKGROUND ===== */
body{
  font-family:'Segoe UI',system-ui;
  min-height:100vh;
  color:var(--text);
  background: linear-gradient(135deg,var(--green-soft),#e2f2d8);
}
</style>
</head>

<body>
<div class="box">
    <h2>Order Cancelled ❌</h2>
    <p>Your order has been cancelled successfully.</p>
    <a href="home.jsp">Go Home</a>
</div>
</body>
</html>
