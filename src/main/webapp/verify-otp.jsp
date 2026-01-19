<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Delishio</title>
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
  margin-bottom: 12px;
  letter-spacing: -0.5px;
}

/* ===== DEMO OTP BADGE ===== */
.otp-demo {
  font-size: 11px;
  color: var(--medium-green);
  background: var(--light-green);
  padding: 4px 12px;
  border-radius: 20px;
  display: inline-block;
  margin-bottom: 20px;
  font-weight: 600;
}

/* ===== ALERT ===== */
.alert {
  padding: 14px;
  border-radius: 12px;
  margin-bottom: 20px;
  font-size: 14px;
  font-weight: 500;
}

.alert-error {
  background: #ffe3e3;
  color: #c92a2a;
  border: 1px solid rgba(201, 42, 42, 0.2);
}

/* ===== FORM ===== */
.form-group {
  display: flex;
  flex-direction: column;
  text-align: left;
  margin-bottom: 22px;
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
  font-size: 18px; /* Slightly larger for OTP digits */
  letter-spacing: 4px; /* Space out digits */
  text-align: center;
  color: var(--text-dark);
  transition: all 0.3s ease;
  outline: none;
}

.form-group input:focus {
  border-color: var(--medium-green);
  background: var(--white);
  box-shadow: 0 0 0 4px rgba(82, 183, 136, 0.15);
}

/* ===== BUTTONS ===== */
.btn-primary {
  width: 100%;
  padding: 15px;
  border-radius: 12px;
  border: none;
  background: var(--primary-green);
  color: var(--white);
  font-size: 16px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
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
}

.auth-footer a {
  color: var(--primary-green);
  text-decoration: none;
  font-weight: 700;
}

.auth-footer a:hover {
  text-decoration: underline;
}

/* ===== SITE FOOTER ===== */
.site-footer {
  padding: 30px;
  color: var(--primary-green);
  font-size: 13px;
  opacity: 0.7;
}

@media(max-width:480px){
  .auth-box{padding: 40px 25px;}
}
</style>
</head>
<body>

<div class="auth-container">
    <div class="auth-box">
        <h2>📱 Verify Code</h2>
        <p style="color: #666; font-size: 14px; margin-bottom: 15px;">We sent a 6-digit code to your phone.</p>

        <%-- Styled Demo OTP display --%>
        <% if (request.getAttribute("debugOtp") != null) { %>
            <div class="otp-demo">
                Demo Code: <strong><%= request.getAttribute("debugOtp") %></strong>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form class="auth-form" action="verify-otp" method="post">
            <div class="form-group">
                <label>Enter 6-Digit OTP</label>
                <input type="text" name="otp" placeholder="000000" maxlength="6" required autocomplete="one-time-code">
            </div>

            <button type="submit" class="btn btn-primary">Verify & Continue</button>
        </form>

        <div class="auth-footer">
            <a href="forgot-password.jsp">← Change Phone Number</a>
        </div>
    </div>
</div>

<footer class="site-footer">
    &copy; <%= java.time.Year.now() %> Delishio Verification System. Secure & Fast.
</footer>

</body>
</html>