<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delishio - Food Delivery</title>
<style>
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
}

:root{
  --primary-green: #1b5e20;    /* Dark Green */
  --leaf-green: #4caf50;       /* Vibrant Green */
  --mint-bg: #f1f8e9;          /* Very Light Green */
  --text-dark: #2f2f2f;
  --glass: rgba(255,255,255,0.8);
  --border: rgba(46, 125, 50, 0.2);
}

/* ================= BODY ================= */
body{
  font-family:'Segoe UI',system-ui;
  min-height:100vh;
  color:var(--text-dark);
  background: linear-gradient(135deg, #e8f5e9, #f1f8e9, #ffffff);
  position:relative;
  overflow-x:hidden;
}

/* ================= FLOATING PARTICLES ================= */
.star{
  position:absolute;
  width:10px;
  height:10px;
  background: var(--leaf-green);
  clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%); /* Diamond shape */
  opacity:0.4;
  animation:float 10s linear infinite;
  z-index: 0;
}

.star:nth-child(1){left:10%; top:20%; animation-duration:12s;}
.star:nth-child(2){left:85%; top:15%; animation-duration:14s;}
.star:nth-child(3){left:40%; top:50%; animation-duration:10s;}
.star:nth-child(4){left:65%; top:75%; animation-duration:16s;}
.star:nth-child(5){left:25%; top:85%; animation-duration:11s;}

@keyframes float{
  0% {transform:translateY(0px) rotate(0deg);}
  50% {transform:translateY(-30px) rotate(180deg);}
  100% {transform:translateY(0px) rotate(360deg);}
}

/* ================= NAVBAR ================= */
.navbar{
  background: var(--glass);
  backdrop-filter:blur(15px);
  -webkit-backdrop-filter:blur(15px);
  padding:20px 60px;
  display:flex;
  justify-content:space-between;
  align-items:center;
  border-bottom:1px solid var(--border);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.nav-brand h1{
  font-size:28px;
  font-weight:800;
  color: var(--primary-green);
}

/* ================= BUTTONS ================= */
.btn{
  padding:14px 32px;
  border-radius:12px;
  font-weight:600;
  text-decoration:none;
  transition: .3s cubic-bezier(0.4, 0, 0.2, 1);
  display: inline-block;
  cursor: pointer;
}

.btn-secondary {
  background: transparent;
  color: var(--primary-green);
  border: 1px solid var(--primary-green);
  margin-right: 10px;
}

.btn-primary{
  background: var(--primary-green);
  color:#ffffff;
  border: none;
  box-shadow:0 8px 20px rgba(27, 94, 32, 0.2);
}

.btn:hover{
  transform:translateY(-3px);
  box-shadow: 0 12px 24px rgba(0,0,0,0.1);
}

/* ================= HERO ================= */
.hero-section{
  padding:120px 20px 80px;
  text-align:center;
  position: relative;
  z-index: 1;
}

.hero-content h1{
  font-size:68px;
  font-weight:900;
  color: var(--primary-green);
}

.hero-content h2{
  font-size:38px;
  margin:15px 0;
  color: var(--leaf-green);
}

.hero-content p{
  font-size:19px;
  color:#555;
  margin-bottom:45px;
}

.hero-buttons{
  display:flex;
  justify-content:center;
  gap:20px;
}

/* ================= FEATURES ================= */
.features{
  max-width:1200px;
  margin:auto;
  padding:80px 40px;
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
  gap:35px;
}

.feature-card{
  background:white;
  border-radius:24px;
  padding:45px 35px;
  border: 1px solid var(--border);
  transition:.4s;
}

.feature-card:hover{
  transform:translateY(-12px);
  border-color: var(--leaf-green);
  box-shadow: 0 15px 35px rgba(76, 175, 80, 0.1);
}

.feature-card h3{
  font-size:24px;
  font-weight:700;
  margin-bottom:15px;
  color: var(--primary-green);
}

.feature-card p{
  font-size:16px;
  color:#666;
  line-height: 1.6;
}

/* ================= UNIQUE GREEN FOOTER ================= */
.site-footer {
  background: #112d13; /* Very Dark Forest Green */
  color: #dcedc8;
  padding: 80px 60px 30px;
  border-radius: 60px 60px 0 0;
  margin-top: 50px;
}

.footer-top {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: 50px;
  margin-bottom: 50px;
}

.footer-brand h2 {
  color: #fff;
  font-size: 32px;
  margin-bottom: 20px;
}

.footer-brand p {
  opacity: 0.7;
  max-width: 300px;
  line-height: 1.6;
}

.footer-column h4 {
  color: #8bc34a; /* Lime Green */
  margin-bottom: 25px;
  font-size: 18px;
  text-transform: uppercase;
}

.footer-column ul {
  list-style: none;
}

.footer-column ul li {
  margin-bottom: 15px;
}

.footer-column ul li a {
  color: #dcedc8;
  text-decoration: none;
  transition: 0.3s;
}

.footer-column ul li a:hover {
  color: #fff;
  padding-left: 5px;
}

.footer-bottom {
  text-align: center;
  padding-top: 40px;
  border-top: 1px solid rgba(255,255,255,0.05);
  font-size: 14px;
  opacity: 0.5;
}

/* ================= RESPONSIVE ================= */
@media(max-width:992px){
  .footer-top { grid-template-columns: 1fr 1fr; }
}

@media(max-width:768px){
  .hero-content h1{font-size:48px}
  .hero-content h2{font-size:28px}
  .hero-buttons{flex-direction:column}
  .footer-top { grid-template-columns: 1fr; text-align: center; }
  .footer-brand p { margin: 0 auto; }
}
</style>
</head>

<body>
  <div class="star"></div>
  <div class="star"></div>
  <div class="star"></div>
  <div class="star"></div>
  <div class="star"></div>
  
  <div class="landing-container">
        <nav class="navbar">
            <div class="nav-brand">
                <h1>🍔 Delishio</h1>
            </div>
            <div class="nav-links">
                <a href="login.jsp" class="btn btn-secondary">Login</a>
                <a href="register.jsp" class="btn btn-primary">Register</a>
            </div>
        </nav>

        <div class="hero-section">
            <div class="hero-content">
                <h1>Delicious Food</h1>
                <h2>Delivered to Your Doorstep</h2>
                <p>Order from your favorite restaurants and get it delivered fast!</p>
                <div class="hero-buttons">
                    <a href="register.jsp" class="btn btn-primary">Get Started</a>
                    <a href="login.jsp" class="btn btn-secondary">Login</a>
                </div>
            </div>
        </div>

        <div class="features">
            <div class="feature-card">
                <h3>🍕 Wide Selection</h3>
                <p>Choose from hundreds of restaurants</p>
            </div>
            <div class="feature-card">
                <h3>⚡ Fast Delivery</h3>
                <p>Get your food delivered in 30-45 minutes</p>
            </div>
            <div class="feature-card">
                <h3>💳 Easy Payment</h3>
                <p>Multiple payment options available</p>
            </div>
        </div>
  </div>

  <footer class="site-footer">
      <div class="footer-top">
          <div class="footer-brand">
              <h2>Delishio</h2>
              <p>Every single bite is delicious❤️.</p>
          </div>
          <div class="footer-column">
              <h4>Explore</h4>
              <ul>
                  <li><a href="#">Restaurants</a></li>
                  <li><a href="#">Popular Near Me</a></li>
                  <li><a href="#">Daily Deals</a></li>
              </ul>
          </div>
          <div class="footer-column">
              <h4>Company</h4>
              <ul>
                  <li><a href="#">About Us</a></li>
                  <li><a href="#">Partner with us</a></li>
                  <li><a href="#">Contact Support</a></li>
              </ul>
          </div>
          <div class="footer-column">
              <h4>Legal</h4>
              <ul>
                  <li><a href="#">Privacy Policy</a></li>
                  <li><a href="#">Terms of Use</a></li>
                  <li><a href="#">Cookie Settings</a></li>
              </ul>
          </div>
      </div>
      <div class="footer-bottom">
          &copy; 2026 Delishio Delivery Services. All Rights Reserved.
      </div>
  </footer>
</body>
</html>