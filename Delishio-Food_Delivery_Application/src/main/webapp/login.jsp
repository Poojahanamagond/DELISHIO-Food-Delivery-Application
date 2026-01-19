<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Delishio</title>
<style>
/* =====================
   MODERN GREEN THEME 
   ===================== */
:root {
  --primary-green: #2d6a4f;    /* Deep Forest */
  --medium-green: #52b788;     /* Fresh Emerald */
  --light-green: #d8f3dc;      /* Mint Pale */
  --bg-gradient: linear-gradient(135deg, #d8f3dc 0%, #f0f7f4 100%);
  --text-dark: #1b4332;
  --white: #ffffff;
  --error-bg: #ffe3e3;
  --error-text: #c92a2a;
}

*{margin:0;padding:0;box-sizing:border-box;}

body {
  font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
  min-height: 100vh;
  background: var(--bg-gradient);
  display: flex;
  flex-direction: column; /* Changed to column to accommodate footer */
  justify-content: center;
  align-items: center;
  padding: 20px;
  overflow-x: hidden;
}

/* ===== AUTH BOX ===== */
.auth-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  flex: 1; /* Pushes footer down */
}

.auth-box {
  background: var(--white);
  padding: 50px 40px;
  border-radius: 30px;
  max-width: 440px;
  width: 100%;
  box-shadow: 0 25px 50px rgba(27, 67, 50, 0.12);
  text-align: center;
  border: 1px solid rgba(45, 106, 79, 0.1);
  position: relative;
}

.auth-box h2 {
  font-size: 34px;
  font-weight: 800;
  color: var(--primary-green);
  margin-bottom: 8px;
  letter-spacing: -1px;
}

.auth-box h3 {
  font-size: 18px;
  font-weight: 500;
  margin-bottom: 30px;
  color: #555;
}

/* ===== ALERTS ===== */
.alert {
  padding: 14px;
  border-radius: 12px;
  margin-bottom: 20px;
  font-size: 14px;
  font-weight: 500;
}

.alert-error {
  background: var(--error-bg);
  color: var(--error-text);
  border: 1px solid rgba(201, 42, 42, 0.2);
}

.alert-success {
  background: var(--light-green);
  color: var(--primary-green);
  border: 1px solid rgba(45, 106, 79, 0.2);
}

/* ===== FORM ELEMENTS ===== */
.form-group {
  text-align: left;
  margin-bottom: 20px;
}

.form-group label {
  font-size: 14px;
  font-weight: 600;
  color: var(--primary-green);
  margin-bottom: 8px;
  display: block;
}

input[type="email"],
input[type="password"] {
  width: 100%;
  padding: 15px;
  border-radius: 12px;
  border: 2px solid #e9ecef;
  background: #f8f9fa;
  font-size: 15px;
  color: var(--text-dark);
  transition: all 0.3s ease;
  outline: none;
}

input:focus {
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

/* ===== LINKS ===== */
.auth-footer {
  margin-top: 20px;
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
.site-footer {
  width: 100%;
  text-align: center;
  padding: 30px;
  color: var(--primary-green);
  font-size: 13px;
  opacity: 0.7;
}

/* ===== CONFETTI ===== */
.confetti {
  position: fixed;
  width: 8px;
  height: 8px;
  top: -10px;
  z-index: 1;
  pointer-events: none;
  animation: fall linear forwards;
}

.password-wrapper {
/* Eye Icon Styling */
.password-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

#togglePassword {
  position: absolute;
  right: 15px;
  color: var(--primary-green);
  cursor: pointer;
  font-size: 18px;
  opacity: 0.7;
  transition: opacity 0.3s ease;
}

#togglePassword:hover {
  opacity: 1;
}

/* Ensure padding on the right so text doesn't overlap the icon */
input[type="password"], 
input[type="text"] {
  padding-right: 45px !important;
}

@keyframes fall {
  0% {transform:translateY(0px) rotate(0deg);}
  100% {transform:translateY(110vh) rotate(720deg);}
}
</style>
</head>
<body>

<div class="auth-container">
    <div class="auth-box">
        <h2>🥗 Delishio</h2>
        <h3>Welcome Back!</h3>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getParameter("success") %>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="name@example.com" required>
            </div>

           <div class="form-group">
    <label for="password">Password</label>
    <div class="password-wrapper" style="position: relative;">
        <input type="password" id="password" name="password" placeholder="••••••••" required style="width: 100%;">
        <i class="fa-solid fa-eye" id="togglePassword" style="position: absolute; right: 10px; top: 30%; cursor: pointer;"></i>
    </div>
    
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">



            <button type="submit" class="btn btn-primary">Sign In</button>
        </form>

        <p class="auth-footer">
            <a href="forgot-password.jsp">Forgot Password?</a>
        </p>

        <p class="auth-footer">
            New to Delishio? <a href="register.jsp">Create an account</a>
        </p>
        
        <p class="auth-footer" style="margin-top: 25px; border-top: 1px solid #eee; pt: 20px;">
            <a href="index.jsp" style="font-weight: 500; color: #999;">← Back to Home</a>
        </p>
    </div>
</div>

<footer class="site-footer">
    &copy; <%= java.time.Year.now() %> Delishio Delivery Services. All Rights Reserved.
</footer>

<script>
function createConfetti() {
    const colors = ['#2d6a4f', '#52b788', '#95d5b2', '#74c69d', '#b7e4c7'];
    for(let i=0; i<80; i++){
        const conf = document.createElement('div');
        conf.className = 'confetti';
        conf.style.left = Math.random()*100 + 'vw';
        conf.style.background = colors[Math.floor(Math.random()*colors.length)];
        conf.style.borderRadius = Math.random() > 0.5 ? '50%' : '0';
        conf.style.width = conf.style.height = Math.random()*7 + 5 + 'px';
        conf.style.animationDuration = (Math.random()*2 + 3) + 's';
        conf.style.animationDelay = Math.random()*2 + 's';
        document.body.appendChild(conf);
        setTimeout(()=>{ conf.remove(); }, 6000);
    }
}

<% if (request.getParameter("success") != null) { %>
    createConfetti();
<% } %>

const togglePassword = document.querySelector('#togglePassword');
const passwordInput = document.querySelector('#password');

togglePassword.addEventListener('click', function () {
    // Toggle the type attribute
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    
    // Toggle the icon class (eye vs eye-slash)
    this.classList.toggle('fa-eye');
    this.classList.toggle('fa-eye-slash');
});
</script>
</body>
</html>