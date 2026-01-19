<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Delishio</title>
    <style>
/* =====================
   MODERN GREEN THEME 
   ===================== */
:root {
  --primary-green: #2d6a4f;    /* Deep Forest */
  --medium-green: #52b788;     /* Fresh Emerald */
  --light-green: #d8f3dc;      /* Mint Pale */
  --bg-mint: #f0f7f4;
  --text-dark: #1b4332;
  --white: #ffffff;
}

*{margin:0;padding:0;box-sizing:border-box;}

body {
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
  min-height: 100vh;
  color: var(--text-dark);
  background: radial-gradient(circle at top right, #d8f3dc, #f0f7f4 50%);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

/* ===== AUTH BOX ===== */
.auth-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  flex: 1;
}

.auth-box {
  background: var(--white);
  padding: 50px 45px;
  border-radius: 30px;
  max-width: 440px;
  width: 100%;
  box-shadow: 0 25px 50px rgba(27, 67, 50, 0.12);
  text-align: center;
  border: 1px solid rgba(45, 106, 79, 0.1);
  position: relative;
}

.auth-box h2 {
  font-size: 30px;
  font-weight: 800;
  color: var(--primary-green);
  margin-bottom: 15px;
  letter-spacing: -0.5px;
}

.auth-box p.subtitle {
  font-size: 15px;
  color: #666;
  margin-bottom: 30px;
  line-height: 1.5;
}

/* ===== ALERT ===== */
.alert {
  padding: 14px;
  border-radius: 12px;
  margin-bottom: 20px;
  font-size: 14px;
  font-weight: 500;
  background: #ffe3e3;
  color: #c92a2a;
  border: 1px solid rgba(201, 42, 42, 0.2);
}

/* ===== FORM ===== */
.form-group {
  display: flex;
  flex-direction: column;
  text-align: left;
  margin-bottom: 25px;
}

.form-group label {
  font-size: 13px;
  font-weight: 700;
  color: var(--primary-green);
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.form-group input {
  padding: 15px;
  border-radius: 12px;
  border: 2px solid #e9ecef;
  background: #f8f9fa;
  font-size: 15px;
  color: var(--text-dark);
  transition: all 0.3s ease;
  outline: none;
}

/* ===== INPUT GLOW ON FOCUS ===== */
.form-group input:focus {
  border-color: var(--medium-green);
  background: var(--white);
  box-shadow: 0 0 0 4px rgba(82, 183, 136, 0.15);
}

/* ===== BUTTONS ===== */
.btn {
  padding: 15px 28px;
  border-radius: 12px;
  font-weight: 700;
  text-decoration: none;
  border: none;
  cursor: pointer;
  width: 100%;
  transition: all 0.3s ease;
  font-size: 16px;
}

.btn-primary {
  background: var(--primary-green);
  color: var(--white);
  box-shadow: 0 10px 20px rgba(45, 106, 79, 0.2);
}

.btn-primary:hover {
  background: var(--medium-green);
  transform: translateY(-2px);
  box-shadow: 0 12px 25px rgba(45, 106, 79, 0.25);
}

/* ===== FOOTER LINKS ===== */
.auth-footer {
  margin-top: 25px;
  font-size: 14px;
  color: #666;
  text-align: center;
}

.auth-footer a {
  color: var(--primary-green);
  text-decoration: none;
  font-weight: 700;
  transition: 0.3s;
}

.auth-footer a:hover {
  color: var(--medium-green);
  text-decoration: underline;
}

/* ===== UNIQUE SECURITY FOOTER ===== */
.security-footer {
    width: 100%;
    text-align: center;
    padding: 30px;
    color: var(--primary-green);
    font-size: 13px;
    opacity: 0.7;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .auth-box{padding: 40px 25px;}
}
</style>
    
</head>
<body>

<div class="auth-container">
    <div class="auth-box">
        <h2>🔒 Reset Password</h2>
        <p class="subtitle">Enter your registered phone number to receive a secure OTP for password recovery.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form class="auth-form" action="forgot-password" method="post">
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="e.g. +91 8073452652" required>
            </div>

            <button type="submit" class="btn btn-primary">Send Verification Code</button>
        </form>

        <div class="auth-footer">
            <a href="login.jsp">← Return to Login</a>
        </div>
    </div>
</div>

<footer class="security-footer">
    &copy; <%= java.time.Year.now() %> Delishio Security. All connections are encrypted.
</footer>

</body>
</html>