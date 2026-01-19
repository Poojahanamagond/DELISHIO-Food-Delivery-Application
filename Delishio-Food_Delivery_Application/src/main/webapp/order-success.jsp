<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Original Logic Preserved
    String orderNumber = (String) session.getAttribute("orderNumber");
    String address = (String) session.getAttribute("address");
    String phone = (String) session.getAttribute("phone");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    Double totalAmount = (Double) session.getAttribute("totalAmount");
    
    if (orderNumber == null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - Delishio</title>
    <style>
        :root {
            --primary-green: #2e7d32;
            --light-green: #4caf50;
            --bg-green: #f1f8e9;
            --white: #ffffff;
            --text: #2b2b2b;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-green);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
        }

        .container {
            width: 100%;
            max-width: 500px;
        }

        .success-card {
            background: var(--white);
            border-radius: 24px;
            box-shadow: 0 15px 35px rgba(0, 50, 0, 0.1);
            overflow: hidden;
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: scale(0.95) translateY(20px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        /* HEADER - GREEN THEME */
        .success-header {
            background: linear-gradient(135deg, var(--primary-green) 0%, var(--light-green) 100%);
            color: white;
            padding: 35px 20px;
            text-align: center;
            position: relative;
        }

        .checkmark {
            width: 70px;
            height: 70px;
            background: white;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .checkmark svg {
            width: 40px;
            height: 40px;
            stroke: var(--primary-green);
            stroke-width: 4;
            fill: none;
            stroke-dasharray: 100;
            stroke-dashoffset: 100;
            animation: draw 0.8s ease-out forwards 0.3s;
        }

        @keyframes draw { to { stroke-dashoffset: 0; } }

        .success-header h1 { font-size: 28px; margin-bottom: 5px; }
        .order-number { font-size: 16px; opacity: 0.9; font-weight: 500; }

        .content { padding: 30px; }

        /* TRACKING & PROGRESS */
        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .current-status { font-weight: 700; color: var(--primary-green); display: flex; align-items: center; gap: 8px; }

        .eta {
            background: #e8f5e9;
            color: var(--primary-green);
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 14px;
        }

        .progress-bar {
            height: 10px;
            background: #eee;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .progress-fill {
            height: 100%;
            background: var(--light-green);
            width: 0%;
            transition: width 0.3s ease;
        }

        /* TIMELINE */
        .timeline { position: relative; padding-left: 35px; margin-bottom: 25px; }
        .timeline::before {
            content: ''; position: absolute; left: 15px; top: 5px; bottom: 5px;
            width: 2px; background: #eee;
        }

        .timeline-item { position: relative; margin-bottom: 20px; opacity: 0.3; transition: 0.5s; }
        .timeline-item.active { opacity: 1; }

        .timeline-dot {
            position: absolute; left: -26px; top: 4px;
            width: 12px; height: 12px; background: #ddd;
            border-radius: 50%; border: 2px solid white;
        }

        .timeline-item.active .timeline-dot { background: var(--primary-green); transform: scale(1.2); }
        .timeline-content h3 { font-size: 15px; }
        .timeline-content p { font-size: 13px; color: #777; }

        /* DETAILS BOX */
        .order-details {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 25px;
            border: 1px solid #eee;
        }

        .order-details h2 { font-size: 16px; margin-bottom: 15px; color: var(--primary-green); }

        .detail-row {
            display: flex; justify-content: space-between;
            padding: 8px 0; font-size: 14px;
        }

        .detail-label { color: #666; }
        .detail-value { font-weight: 600; color: #333; text-align: right; }

        /* BUTTONS */
        .btn-group { display: flex; gap: 12px; }

        .back-btn {
            flex: 1; padding: 14px; text-align: center;
            background: var(--primary-green); color: white;
            text-decoration: none; border-radius: 12px;
            font-weight: 600; transition: 0.3s;
        }

        .cancel-btn {
            flex: 1; padding: 14px; background: white;
            color: #d32f2f; border: 1px solid #ffcdd2;
            border-radius: 12px; font-weight: 600;
            cursor: pointer; transition: 0.3s;
        }

        .cancel-btn.disabled { opacity: 0.4; cursor: not-allowed; }

        /* MODALS */
        .modal {
            display: none; position: fixed; inset: 0;
            background: rgba(0,0,0,0.5); z-index: 1000;
            align-items: center; justify-content: center;
        }
        .modal.show { display: flex; }
        .modal-content {
            background: white; border-radius: 20px; width: 90%; max-width: 400px;
            padding: 30px; text-align: center;
        }
        .modal-header h2 { color: #d32f2f; margin-bottom: 10px; }
        .modal-footer { margin-top: 20px; display: flex; gap: 10px; }
        .modal-btn { flex: 1; padding: 12px; border-radius: 10px; border: none; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-card">
            <div class="success-header">
                <div class="checkmark">
                    <svg viewBox="0 0 52 52">
                        <path d="M14 27l8 8 16-16"/>
                    </svg>
                </div>
                <h1>Order Confirmed!</h1>
                <p class="order-number">Order #<%= orderNumber %></p>
            </div>

            <div class="content">
                <div class="tracking-section">
                    <div class="status-header">
                        <div class="current-status">
                            <span id="statusIcon">📦</span>
                            <span id="statusText">Order Confirmed</span>
                        </div>
                        <div class="eta">
                            <span id="etaTime">25 min</span>
                        </div>
                    </div>

                    <div class="progress-bar">
                        <div class="progress-fill" id="progressFill"></div>
                    </div>

                    <div class="timeline">
                        <div class="timeline-item active" id="step1">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h3>Order Confirmed</h3>
                                <p>We've received your order</p>
                            </div>
                        </div>
                        <div class="timeline-item" id="step2">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h3>Preparing Your Food</h3>
                                <p>Chef is starting the magic</p>
                            </div>
                        </div>
                        <div class="timeline-item" id="step3">
                            <div class="timeline-dot"></div>
                            <div class="timeline-content">
                                <h3>Out for Delivery</h3>
                                <p>Rider is on the way</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="order-details">
                    <h2>📋 Details</h2>
                    <div class="detail-row"><span class="detail-label">Address</span><span class="detail-value"><%= address %></span></div>
                    <div class="detail-row"><span class="detail-label">Phone</span><span class="detail-value"><%= phone %></span></div>
                    <div class="detail-row"><span class="detail-label">Payment</span><span class="detail-value"><%= paymentMethod.toUpperCase() %></span></div>
                </div>

                <div class="btn-group">
                    <a href="home.jsp" class="back-btn">Home</a>
                    <button onclick="cancelOrder()" class="cancel-btn" id="cancelBtn">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <div id="cancelModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Cancel Order?</h2></div>
            <p>Are you sure? We're ready to cook!</p>
            <div class="modal-footer">
                <button onclick="closeModal()" class="modal-btn" style="background:#eee">No</button>
                <button onclick="confirmCancel()" class="modal-btn" style="background:#d32f2f; color:white">Yes, Cancel</button>
            </div>
        </div>
    </div>

    <div id="cancelSuccessModal" class="modal">
        <div class="modal-content">
            <div class="modal-header"><h2>Cancelled</h2></div>
            <p>Your order was successfully cancelled.</p>
            <div class="modal-footer">
                <a href="home.jsp" class="back-btn" style="text-decoration:none">Return Home</a>
            </div>
        </div>
    </div>

    <script>
        // --- Original JS Logic (Do not change) ---
        let progress = 0;
        let timeRemaining = 25;
        let orderCancelled = false;
        let deliveryInterval;
        const statusIcons = ['📦', '👨‍🍳', '🚚', '🎉'];
        const statusTexts = ['Order Confirmed', 'Preparing Your Food', 'Out for Delivery', 'Arriving Soon'];

        function updateDeliveryStatus() {
            if (orderCancelled) return;
            const progressFill = document.getElementById('progressFill');
            const statusIcon = document.getElementById('statusIcon');
            const statusText = document.getElementById('statusText');
            const etaTime = document.getElementById('etaTime');
            const cancelBtn = document.getElementById('cancelBtn');

            if (progress <= 100) {
                progressFill.style.width = progress + '%';
                let currentStep = 0;
                if (progress >= 75) currentStep = 3;
                else if (progress >= 50) currentStep = 2;
                else if (progress >= 25) currentStep = 1;

                statusIcon.textContent = statusIcons[currentStep];
                statusText.textContent = statusTexts[currentStep];

                for (let i = 1; i <= 3; i++) {
                    const step = document.getElementById('step' + i);
                    if (step && i <= currentStep + 1) step.classList.add('active');
                }

                if (timeRemaining > 0) {
                    timeRemaining -= 0.25;
                    etaTime.textContent = Math.ceil(timeRemaining) + ' min';
                } else {
                    etaTime.textContent = 'Delivered!';
                }

                if (progress > 30) {
                    cancelBtn.classList.add('disabled');
                    cancelBtn.textContent = 'Cannot Cancel';
                }
                progress += 1;
            }
        }

        function cancelOrder() {
            if (progress > 30) {
                alert('Sorry, your order is being prepared and cannot be cancelled.');
                return;
            }
            document.getElementById('cancelModal').classList.add('show');
        }

        function closeModal() { document.getElementById('cancelModal').classList.remove('show'); }

        function confirmCancel() {
            orderCancelled = true;
            clearInterval(deliveryInterval);
            document.getElementById('cancelModal').classList.remove('show');
            setTimeout(() => { document.getElementById('cancelSuccessModal').classList.add('show'); }, 300);
        }

        deliveryInterval = setInterval(updateDeliveryStatus, 250);
    </script>
</body>
</html>