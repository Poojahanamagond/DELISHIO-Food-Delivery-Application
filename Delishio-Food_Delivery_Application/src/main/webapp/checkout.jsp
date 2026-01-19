<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Delishio</title>
    <style>
        :root{
            /* Green Palette */
            --green-primary: #2e7d32;
            --green-light: #4caf50;
            --green-glow: rgba(76, 175, 80, 0.2);
            --text-dark: #1a1a1a;
            --text-gray: #666;
            --border: rgba(0, 128, 0, 0.1);
        }

        body {
            font-family: 'Segoe UI', system-ui;
            min-height: 100vh;
            background: #f4f7f4;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }

        .checkout-container {
            background: white;
            border-radius: 30px;
            box-shadow: 0 20px 60px rgba(0, 100, 0, 0.1);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
            border: 1px solid var(--border);
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* HEADER - Green Gradient */
        .checkout-header {
            background: linear-gradient(135deg, var(--green-primary), var(--green-light));
            color: white;
            padding: 40px;
            text-align: center;
        }

        .checkout-header h1 {
            font-size: 32px;
            margin: 0;
            font-weight: 800;
        }

        .checkout-header p {
            opacity: 0.9;
            font-size: 14px;
            margin-top: 5px;
        }

        .checkout-form {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--green-primary);
            font-weight: 700;
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 14px;
            border: 2px solid #eee;
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        /* Focus state in Green */
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--green-light);
            box-shadow: 0 0 0 4px var(--green-glow);
        }

        .error-message {
            color: #d32f2f;
            font-size: 12px;
            margin-top: 5px;
            display: none;
            font-weight: 600;
        }

        .error-message.show { display: block; }
        .input-error { border-color: #d32f2f !important; }

        /* PAYMENT OPTIONS */
        .payment-method {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-top: 10px;
        }

        .payment-option label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border: 2px solid #eee;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            font-size: 14px;
        }

        .payment-option input[type="radio"] { display: none; }

        .payment-option input[type="radio"]:checked + label {
            border-color: var(--green-primary);
            background: #e8f5e9;
            color: var(--green-primary);
        }

        .payment-details {
            margin-top: 15px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 12px;
            border: 1px solid #eee;
        }

        /* SUBMIT BUTTON - Green Gradient */
        .submit-btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, var(--green-primary), var(--green-light));
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
            box-shadow: 0 8px 20px rgba(46, 125, 50, 0.2);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(46, 125, 50, 0.3);
        }

        .required { color: #d32f2f; }
        .hidden { display: none; }
    </style>
</head>
<body>
    <div class="checkout-container">
        <div class="checkout-header">
            <h1>🍽️ Checkout</h1>
            <p>Complete your order with Delishio</p>
        </div>

        <form class="checkout-form" id="checkoutForm" action="checkout" method="POST" onsubmit="return validateForm()">
            
            <div class="form-group">
                <label for="userName">Full Name <span class="required">*</span></label>
                <input type="text" id="userName" name="userName" placeholder="Enter your full name">
                <div class="error-message" id="nameError">Please enter your name</div>
            </div>

            <div class="form-group">
                <label for="address">Delivery Address <span class="required">*</span></label>
                <input type="text" id="address" name="address" placeholder="Flat No, Street, Landmark">
                <div class="error-message" id="addressError">Please enter your delivery address</div>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>
                <input type="tel" id="phone" name="phone" placeholder="10-digit mobile number">
                <div class="error-message" id="phoneError">Please enter a valid 10-digit phone number</div>
            </div>

            <div class="form-group">
                <label for="instructions">Instructions (Optional)</label>
                <textarea id="instructions" name="instructions" rows="2" placeholder="e.g. Leave at the gate"></textarea>
            </div>

            <div class="form-group">
                <label>Payment Method <span class="required">*</span></label>
                <div class="payment-method">
                    <div class="payment-option">
                        <input type="radio" id="card" name="paymentMethod" value="card" onchange="showPaymentDetails('card')">
                        <label for="card">💳 Card</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="cash" name="paymentMethod" value="cash" onchange="showPaymentDetails('cash')">
                        <label for="cash">💵 Cash</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="upi" name="paymentMethod" value="upi" onchange="showPaymentDetails('upi')">
                        <label for="upi">📱 UPI</label>
                    </div>
                </div>
                <div class="error-message" id="paymentError">Select a payment method</div>

                <div id="cardBox" class="payment-details hidden">
                    <input type="text" id="cardNumber" style="margin-bottom:10px;" placeholder="Card Number (16 digits)" maxlength="16">
                    <div style="display:flex; gap:10px;">
                        <input type="text" id="expiry" placeholder="MM/YY" maxlength="5">
                        <input type="password" id="cvv" placeholder="CVV" maxlength="3">
                    </div>
                </div>

                <div id="upiBox" class="payment-details hidden">
                    <input type="text" id="upiId" placeholder="user@okaxis">
                </div>

                <div id="cashBox" class="payment-details hidden">
                    <p style="color: var(--green-primary); font-size: 13px; margin: 0; font-weight:600;">
                        Pay cash upon delivery.
                    </p>
                </div>
            </div>

            <button type="submit" class="submit-btn">Place Order</button>
        </form>
    </div>

    <script>
        function showPaymentDetails(method) {
            document.getElementById('cardBox').classList.add('hidden');
            document.getElementById('upiBox').classList.add('hidden');
            document.getElementById('cashBox').classList.add('hidden');
            document.getElementById('paymentError').classList.remove('show');

            if (method === 'card') document.getElementById('cardBox').classList.remove('hidden');
            else if (method === 'upi') document.getElementById('upiBox').classList.remove('hidden');
            else if (method === 'cash') document.getElementById('cashBox').classList.remove('hidden');
        }

        function validateForm() {
            let isValid = true;
            
            // Validate Name
            const name = document.getElementById('userName');
            if (!name.value.trim()) {
                document.getElementById('nameError').classList.add('show');
                name.classList.add('input-error');
                isValid = false;
            } else {
                document.getElementById('nameError').classList.remove('show');
                name.classList.remove('input-error');
            }

            // Validate Address
            const address = document.getElementById('address');
            if (!address.value.trim()) {
                document.getElementById('addressError').classList.add('show');
                address.classList.add('input-error');
                isValid = false;
            } else {
                document.getElementById('addressError').classList.remove('show');
                address.classList.remove('input-error');
            }

            // Validate Phone
            const phone = document.getElementById('phone');
            const phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(phone.value)) {
                document.getElementById('phoneError').classList.add('show');
                phone.classList.add('input-error');
                isValid = false;
            } else {
                document.getElementById('phoneError').classList.remove('show');
                phone.classList.remove('input-error');
            }

            // Validate Payment
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            if (!paymentMethod) {
                document.getElementById('paymentError').classList.add('show');
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>