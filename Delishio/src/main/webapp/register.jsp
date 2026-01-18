<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Delishio</title>
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
  padding: 40px 20px;
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
  padding: 40px 45px;
  border-radius: 30px;
  max-width: 500px;
  width: 100%;
  box-shadow: 0 25px 50px rgba(27, 67, 50, 0.12);
  text-align: center;
  border: 1px solid rgba(45, 106, 79, 0.1);
  position: relative;
  z-index: 2;
}

.auth-box h2 {
  font-size: 32px;
  font-weight: 800;
  color: var(--primary-green);
  margin-bottom: 10px;
  letter-spacing: -1px;
}

.auth-box h3 {
  font-size: 18px;
  font-weight: 500;
  margin-bottom: 25px;
  color: #666;
}

/* ===== ALERT ===== */
.alert {
  padding: 12px 20px;
  border-radius: 12px;
  margin-bottom: 18px;
  font-size: 14px;
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
  margin-bottom: 18px;
}

.form-group label {
  font-size: 13px;
  font-weight: 700;
  margin-bottom: 6px;
  color: var(--primary-green);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.form-group input,
.form-group textarea,
.form-group select {
  padding: 12px 16px;
  border-radius: 12px;
  background: #f8f9fa;
  font-size: 14px;
  outline: none;
  color: var(--text-dark);
  border: 2px solid #e9ecef;
  transition: all 0.3s ease;
}

/* ===== INPUT GLOW ON FOCUS ===== */
.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
  border-color: var(--medium-green);
  background: var(--white);
  box-shadow: 0 0 0 4px rgba(82, 183, 136, 0.15);
}

.form-group textarea { resize: none; }

/* ===== BUTTONS ===== */
.btn {
  padding: 14px 28px;
  border-radius: 12px;
  font-weight: 700;
  text-decoration: none;
  border: none;
  cursor: pointer;
  width: 100%;
  transition: all 0.3s ease;
  margin-top: 10px;
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
  box-shadow: 0 15px 25px rgba(45, 106, 79, 0.25);
}

/* ===== FOOTER LINKS ===== */
.auth-footer {
  margin-top: 15px;
  font-size: 14px;
  color: #666;
}

.auth-footer a {
  color: var(--primary-green);
  text-decoration: none;
  font-weight: 700;
}

.auth-footer a:hover {
  color: var(--medium-green);
  text-decoration: underline;
}

/* ===== UNIQUE PAGE FOOTER ===== */
.page-footer {
    width: 100%;
    text-align: center;
    padding: 40px 20px 20px;
    color: var(--primary-green);
    font-size: 13px;
    opacity: 0.7;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
  .auth-box{padding: 30px 20px;}
  .auth-box h2 { font-size: 28px; }
}
.password-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.password-wrapper input {
    width: 100%;
    padding-right: 45px; /* Make space for the icon */
}

.toggle-password {
    position: absolute;
    right: 15px;
    cursor: pointer;
    color: var(--primary-green);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0.7;
    transition: 0.3s;
}

.toggle-password:hover {
    opacity: 1;
    transform: scale(1.1);
}
</style>
</head>

<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>🥗 Delishio</h2>
            <h3>Create Account</h3>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/register" method="post">

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a unique name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="example@mail.com" required>
                </div>
                
                <div class="form-group">
    <label for="password">Password</label>
    <div class="password-wrapper">
        <input type="password" id="password" name="password" placeholder="••••••••" required>
        <span class="toggle-password" onclick="togglePassword()">
            <svg id="eye-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
            </svg>
        </span>
    </div>
</div>
                
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" placeholder="+91 00000-00000" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="2" placeholder="Street, City, Zip Code" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="role">Register as</label>
                    <select id="role" name="role">
                        <option value="customer">Customer (Order Food)</option>
                        <option value="admin">Admin (Manage Shop)</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Create My Account</button>
            </form>
            
            <p class="auth-footer">
                Already have an account? <a href="login.jsp">Login here</a>
            </p>
            <p class="auth-footer" style="margin-top: 20px; border-top: 1px solid #eee; padding-top: 15px;">
                <a href="index.jsp" style="font-weight: 500; color: #999;">← Back to Home</a>
            </p>
        </div>
    </div>

    <footer class="page-footer">
        &copy; <%= java.time.Year.now() %> Delishio Inc. Every bite is a green choice.
    </footer>
    <script>
function togglePassword() {
    const passwordInput = document.getElementById("password");
    const eyeIcon = document.getElementById("eye-icon");
    
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        // Change icon to "eye-off" (cross through eye)
        eyeIcon.innerHTML = `
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
            <line x1="1" y1="1" x2="23" y2="23"></line>
        `;
    } else {
        passwordInput.type = "password";
        // Change icon back to normal eye
        eyeIcon.innerHTML = `
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
        `;
    }
}
</script>
</body>

</html>