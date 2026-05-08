<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Registration</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', system-ui;
    background: linear-gradient(135deg, #f5f7fa, #e4efe9);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* 🔥 Card */
.form-box {
    background: #ffffff;
    padding: 35px 30px;
    border-radius: 20px;
    width: 380px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    text-align: center;
    animation: fadeIn 0.6s ease;
}

/* 🔥 Title */
.form-box h2 {
    margin-bottom: 20px;
    color: #222;
    font-weight: 700;
}

/* 🔥 Inputs */
input, textarea {
    width: 100%;
    padding: 12px;
    margin: 12px 0;
    border-radius: 10px;
    border: 1px solid #ddd;
    font-size: 14px;
    transition: 0.3s;
}

/* 🔥 Focus effect */
input:focus, textarea:focus {
    border-color: #2ecc71;
    box-shadow: 0 0 0 2px rgba(46,204,113,0.15);
    outline: none;
}

/* 🔥 Button */
button {
    width: 100%;
    padding: 13px;
    background: linear-gradient(90deg, #2ecc71, #27ae60);
    color: white;
    border: none;
    border-radius: 12px;
    font-weight: bold;
    font-size: 15px;
    cursor: pointer;
    transition: 0.3s;
}

/* Hover */
button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(46,204,113,0.3);
}

/* 🔥 Back link */
a {
    display: inline-block;
    margin-top: 15px;
    color: #555;
    text-decoration: none;
    font-size: 14px;
}

a:hover {
    color: #2ecc71;
}

/* 🔥 Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(15px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>

<body>

<div class="form-box">

    <h2>Register Your Restaurant 🍽️</h2>
<form action="<%= request.getContextPath() %>/restaurantRequest" 
      method="post" 
      enctype="multipart/form-data">

    <input type="text" name="name" placeholder="Restaurant Name" required>
    <input type="email" name="email" placeholder="Email" required>
    <input type="text" name="phone" placeholder="Phone" required>
    <textarea name="address" placeholder="Address" required></textarea>

    <!-- 🔥 ADD THIS -->
    <input type="file" name="document" required>

    <button type="submit">Submit Request</button>
</form>

    <br>

    <a href="index.jsp">← Back to Home</a>

</div>

</body>
</html>