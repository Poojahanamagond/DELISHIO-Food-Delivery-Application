<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Request Submitted - Delishio</title>

<style>
body {
    font-family: 'Segoe UI', system-ui;
    background: linear-gradient(135deg, #2ecc71, #27ae60);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.box {
    background: white;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    width: 400px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    animation: fadeIn 0.6s ease;
}

@keyframes fadeIn {
    from {opacity:0; transform: translateY(20px);}
    to {opacity:1; transform: translateY(0);}
}

.icon {
    font-size: 60px;
    color: #2ecc71;
}

h2 {
    margin: 15px 0;
    color: #2c3e50;
}

p {
    color: #555;
    margin-bottom: 25px;
}

.btn {
    display: inline-block;
    padding: 12px 20px;
    background: #2ecc71;
    color: white;
    border-radius: 25px;
    text-decoration: none;
    margin: 5px;
    font-weight: bold;
}

.btn:hover {
    background: #27ae60;
}
</style>

</head>

<body>

<div class="box">

```
<div class="icon">✅</div>

<h2>Request Submitted!</h2>

<p>
    Your restaurant registration request has been sent to admin.<br><br>
    ⏳ Please wait for approval.<br>
    📧 You will receive a confirmation email once approved.
</p>

<a href="index.jsp" class="btn">🏠 Go Home</a>
<a href="login.jsp" class="btn">🔐 Login</a>
```

</div>

</body>
</html>

</body>
</html>