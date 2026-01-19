# 🍽️ DELISHIO – Online Food Delivery Application
A full-stack food ordering web application built using Java, JSP, Servlets, JDBC, and MySQL, designed as a real-world food delivery platform.  
This is my first complete web application, with User and Admin modules for end-to-end operations.  

---
## 🚀 Project Overview

Delishio simulates a real-world food delivery system where **users** can:

- Register and log in  
- Browse restaurants & view menus  
- Add items to cart with quantity control  
- Place and track orders  
- Cancel orders before preparation begins  

The **Admin module** allows managing:

- Restaurants  
- Menu items  
- Orders  
- Customers  

All data is stored securely in **MySQL**, ensuring smooth real-time operations.  

---

## 🛠️ Tech Stack

| Layer        | Technology |
|-------------|------------|
| Frontend    | HTML, CSS, JSP |
| Backend     | Java, Java Servlets, JDBC |
| Database    | MySQL (Workbench) |
| Server      | Apache Tomcat |
| IDE         | Eclipse |
| Architecture| MVC with DAO Pattern |

---

## 📂 Project Structure

DelishioApp/
├── database_schema.sql
├── src/main/java/com/delishio/
│ ├── models/ # User, Restaurant, MenuItem, Order, OrderItem, Cart
│ ├── util/ # MyConnection.java
│ ├── dao/ # DAO Interfaces
│ ├── daoimpl/ # DAO Implementations
│ └── controllers/ # All Servlets (Register, Login, Menu, Cart, Orders)
├── src/main/webapp/
│ ├── index.jsp
│ ├── login.jsp
│ ├── register.jsp
│ ├── navbar.jsp
│ ├── home.jsp
│ ├── menu.jsp
│ ├── cart.jsp
│ ├── verify-otp.jsp
│ ├── order-success.jsp
│ ├── order-history.jsp
│ ├── order-details.jsp
│ ├── admin-dashboard.jsp
│ ├── add-restaurant.jsp
│ ├── add-menu.jsp
│ ├── admin-orders.jsp
│ ├── css/
│ │ └── style.css
│ └── images/
└── WEB-INF/
└── web.xml


---

## 🎯 Features

### **User Module**
- Registration, login, and OTP-based password reset  
- Browse restaurants & menus  
- Add/remove items in cart  
- Place & track orders  
- Cancel orders before "Preparing Your Order"  
- Navigation: Home, Restaurants, Cart, Orders  

### **Admin Module**
- Dashboard: Restaurants, Menu Items, Orders, Customers  
- Add/edit restaurants (name, type, address, phone, rating, delivery time, image)  
- Add menu items for specific restaurants  
- Manage orders and view statuses  
- View registered customers  

---

## 📝 Quick Setup

CREATE DATABASE IF NOT EXISTS delishio;
USE delishio;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    role ENUM('customer', 'admin') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Restaurants Table
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    address TEXT,
    phone VARCHAR(15),
    rating DECIMAL(2,1) DEFAULT 0.0,
    delivery_time VARCHAR(20),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menu Items Table
CREATE TABLE menu_items (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    image_url VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    delivery_address TEXT NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'out_for_delivery', 'delivered', 'cancelled') DEFAULT 'pending',
    otp VARCHAR(6),
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu_items(menu_id)
);

-- Cart Table
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu_items(menu_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_menu (user_id, menu_id)
);

-- Sample Data for Testing

-- Insert Admin User (password: admin123)
INSERT INTO users (username, email, password, phone, role) VALUES 
('admin', 'admin@byte2bite.com', 'admin123', '9876543210', 'admin');

-- Insert Sample Customer (password: user123)
INSERT INTO users (username, email, password, phone, address, role) VALUES 
('john_doe', 'john@example.com', 'user123', '9876543211', '123 Main St, City', 'customer');

-- Insert Sample Restaurants
INSERT INTO restaurants (name, cuisine_type, address, phone, rating, delivery_time, image_url) VALUES
('Pizza Palace', 'Italian', '456 Food St, City', '9876543212', 4.5, '30-40 mins', 'pizza.jpg'),
('Burger Hub', 'American', '789 Taste Ave, City', '9876543213', 4.2, '25-35 mins', 'burger.jpg'),
('Sushi Express', 'Japanese', '321 Fresh Rd, City', '9876543214', 4.8, '40-50 mins', 'sushi.jpg'),
('Spice Garden', 'Indian', '654 Curry Lane, City', '9876543215', 4.6, '35-45 mins', 'indian.jpg');

- Insert Sample Menu Items
INSERT INTO menu_items (restaurant_id, item_name, description, price, category, is_available) VALUES
(1, 'Margherita Pizza', 'Classic pizza with tomato and mozzarella', 299.00, 'Main Course', TRUE),
(1, 'Pepperoni Pizza', 'Spicy pepperoni with cheese', 399.00, 'Main Course', TRUE),
(1, 'Garlic Bread', 'Toasted bread with garlic butter', 99.00, 'Appetizer', TRUE),
(2, 'Classic Burger', 'Beef patty with lettuce and tomato', 199.00, 'Main Course', TRUE),
(2, 'Cheese Burger', 'Double cheese with beef patty', 249.00, 'Main Course', TRUE),
(2, 'French Fries', 'Crispy golden fries', 79.00, 'Side', TRUE),
(3, 'California Roll', 'Crab, avocado, and cucumber', 349.00, 'Main Course', TRUE),
(3, 'Salmon Nigiri', 'Fresh salmon over rice', 299.00, 'Main Course', TRUE),
(4, 'Butter Chicken', 'Creamy tomato-based curry', 279.00, 'Main Course', TRUE),
(4, 'Biryani', 'Aromatic rice with spices', 249.00, 'Main Course', TRUE);

-- Indexes for Performance
CREATE INDEX idx_restaurant_active ON restaurants(is_active);
CREATE INDEX idx_menu_restaurant ON menu_items(restaurant_id);
CREATE INDEX idx_order_user ON orders(user_id);
CREATE INDEX idx_order_status ON orders(status);
CREATE INDEX idx_cart_user ON cart(user_id);

🔑 Default Credentials
| Role  | Email                                           | Password |
| ----- | ----------------------------------------------- | -------- |
| Admin | [admin@delishio.com](mailto:admin@delishio.com) | admin123 |
| User  | [john@example.com](mailto:john@example.com)     | user123  |

💡 Key Learnings
-End-to-end Java web application development
-Implementing MVC architecture with DAO pattern
-Database design and JDBC connectivity
-Managing User & Admin modules
-Debugging & improving application flow
-Git & GitHub version control

✅ Everything is complete – models, DAOs, servlets, JSPs, CSS, configuration, and database schema. No code skipped!

🎬 Live Demo 🔗
https://drive.google.com/file/d/1TECrPDdkanJGiU3DcZDNpfEphtnzZoKY/view?usp=sharing

🌈 Final Thoughts

This project represents my first complete full-stack application. From designing UIs, implementing backend logic, handling databases, to managing both User and Admin modules — every challenge helped me grow as a developer.
Delishio is not just an application; it’s a reflection of learning by doing, persistence, and passion for coding.

Made with ❤️ by Pooja B Hanamagond
"Every bug squashed was a lesson learned".


