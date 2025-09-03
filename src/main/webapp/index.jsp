<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String username = null;
  if (session != null) {
    username = (String) session.getAttribute("username");
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Credit Card Validator</title>
  <style>
    /* Background and general styles as in your original code */
    body {
      font-family: 'Roboto', Arial, sans-serif;
      background-image: url('images/background.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      min-height: 100vh;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    /* CARD CONTAINER - used for card validator and login container */
    .card-container, .login-container {
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(18px) saturate(120%);
      -webkit-backdrop-filter: blur(18px) saturate(120%);
      border-radius: 24px;
      border: 1px solid rgba(255, 255, 255, 0.22);
      padding: 36px 32px 32px 32px;
      width: 360px;
      text-align: center;
      transition: box-shadow 0.3s, background 0.4s;
      box-shadow: none;
      box-sizing: border-box;
      color: black;
    }
    /* Login form colors and layout */
    .login-container h2 {
      font-size: 1.6rem;
      font-weight: 700;
      margin-bottom: 24px;
      color: #B22222;
      text-shadow: 0 1px 2px rgba(200, 200, 255, 0.13);
    }
    .login-container input[type="text"],
    .login-container input[type="password"],
    input[type="text"] {
      width: 100%;
      padding: 14px 18px;
      padding-right: 100px;
      font-size: 1.1rem;
      border-radius: 12px;
      background: rgba(255, 255, 255, 0.85);
      color: black;
      outline: none;
      box-sizing: border-box;
      border: none;
      transition: background 0.3s, color 0.3s;
      box-shadow: none;
      margin-bottom: 18px;
    }
    input[type="text"]:focus,
    .login-container input[type="text"]:focus,
    .login-container input[type="password"]:focus {
      background: rgba(255, 255, 255, 1);
      color: #000000;
      opacity: 1; 
    }
    input[type="text"]::placeholder,
    .login-container input::placeholder {
      color: #888888;
      opacity: 1;
    }
    /* Card validator heading */
    h2 {
      font-size: 1.6rem;
      font-weight: 700;
      margin-bottom: 24px;
      color: #B22222;
      text-shadow: 0 1px 2px rgba(200, 200, 255, 0.13);
    }
    /* Card validator input wrapper and card type display */
    .input-wrapper {
      position: relative;
      width: 100%;
    }
    #cardType {
      position: absolute;
      top: 50%;
      right: 15px;
      transform: translateY(-50%);
      font-weight: 600;
      color: #444;
      user-select: none;
      pointer-events: none;
      font-size: 0.95rem;
      font-family: Arial, sans-serif;
    }
    /* Buttons styling */
    button.validate-btn, .login-container button {
      background: linear-gradient(90deg, #4f8cff 25%, #7d4fff 75%);
      color: #fff;
      padding: 14px 0;
      width: 100%;
      border-radius: 12px;
      font-size: 1.07rem;
      cursor: pointer;
      font-weight: 600;
      margin-bottom: 14px;
      opacity: 0.97;
      border: none;
      box-shadow: none;
      transition: background 0.3s;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      user-select: none;
    }
    button.validate-btn:hover:not(:disabled),
    .login-container button:hover {
      background: linear-gradient(90deg, #3e7eed 25%, #6846d3 75%);
    }
    button.validate-btn:disabled, .login-container button:disabled {
      opacity: 0.6;
      cursor: not-allowed;
    }
    /* Spinner */
    .spinner {
      border: 3px solid rgba(255, 255, 255, 0.3);
      border-top: 3px solid #fff;
      border-radius: 50%;
      width: 18px;
      height: 18px;
      animation: spin 1s linear infinite;
      margin-left: 10px;
      display: inline-block;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
    /* Message styles */
    .message {
      font-size: 15px;
      margin-top: 8px;
      min-height: 24px;
      letter-spacing: 0.03em;
      transition: color 0.3s, opacity 0.3s;
      opacity: 1;
    }
    .valid {
      color: #28a745;
    }
    .invalid {
      color: #dc3545;
    }
    /* Shake input animation */
    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      20%, 60% { transform: translateX(-10px); }
      40%, 80% { transform: translateX(10px); }
    }
    .shake {
      animation: shake 0.4s;
    }
    /* Fade in animation */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .fade-in {
      animation: fadeIn 0.3s forwards;
    }
    /* Responsive */
    @media (max-width: 500px) {
      .card-container, .login-container {
        width: 96vw;
        padding: 18px 8vw;
      }
      h2 {
        font-size: 1.18rem;
      }
      input[type="text"], input[type="password"], button.validate-btn, .login-container button {
        font-size: 1rem;
        padding: 12px 14px;
      }
      #cardType {
        right: 10px;
        font-size: 0.85rem;
      }
    }
    /* Login error message */
    .error {
      background: #fad7d7a8;
      color: #e54033;
      padding: 10px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-weight: 600;
      text-align: left;
    }
  </style>
</head>
<body>
<%
  if (username == null) {
%>
  <div class="login-container">
    <h2>Sign In to Validator</h2>
    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>
    <form action="LoginServlet" method="post" novalidate>
      <input type="text" name="username" placeholder="Username" required autofocus />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">Log In</button>
    </form>
  </div>
<%
  } else {
%>
  <div class="card-container">
    <h2>Credit Card Validator</h2>
    <div class="input-wrapper">
      <input
        type="text"
        id="cardNumber"
        placeholder="Enter your credit card number"
        maxlength="19"
        autocomplete="cc-number"
        aria-label="Credit card number"
      />
      <div id="cardType">Unknown</div>
    </div>
    <button class="validate-btn" id="validateBtn" onclick="validateCard()">
      Validate
      <span class="spinner" id="spinner" style="display:none;"></span>
    </button>
    <div id="resultMessage" class="message" role="alert" aria-live="polite"></div>
  </div>

  <script>
    // Card type detection and Luhn check patterns
    const cardPatterns = [
      { type: 'Visa', pattern: /^4/ },
      { type: 'MasterCard', pattern: /^5[1-5]/ },
      { type: 'American Express', pattern: /^3[47]/ },
      { type: 'Discover', pattern: /^6(?:011|5)/ },
      { type: 'JCB', pattern: /^(?:2131|1800|35)/ },
      { type: 'Diners Club', pattern: /^3(?:0[0-5]|[68])/ }
    ];
    const cardTypeDisplay = document.getElementById('cardType');
    const cardInput = document.getElementById('cardNumber');
    const validateBtn = document.getElementById('validateBtn');
    const spinner = document.getElementById('spinner');
    const resultMessage = document.getElementById('resultMessage');

    function detectCardType(number) {
      for (const card of cardPatterns) {
        if (card.pattern.test(number)) {
          return card.type;
        }
      }
      return 'Unknown';
    }

    function luhnCheck(cardNumber) {
      let sum = 0;
      let shouldDouble = false;
      for (let i = cardNumber.length - 1; i >= 0; i--) {
        let digit = parseInt(cardNumber.charAt(i), 10);
        if (shouldDouble) {
          digit *= 2;
          if (digit > 9) digit -= 9;
        }
        sum += digit;
        shouldDouble = !shouldDouble;
      }
      return sum % 10 === 0;
    }

    cardInput.addEventListener('input', (e) => {
      const number = e.target.value.replace(/\D/g, '');
      const detectedType = detectCardType(number);
      cardTypeDisplay.textContent = detectedType;

      let value = number.substring(0, 16);
      let formatted = value.match(/.{1,4}/g);
      e.target.value = formatted ? formatted.join(' ') : '';
    });

    function shakeInput() {
      cardInput.classList.add('shake');
      cardInput.addEventListener('animationend', () => {
        cardInput.classList.remove('shake');
      }, { once: true });
    }

    function showMessage(message, isValid) {
      resultMessage.textContent = message;
      resultMessage.classList.remove('fade-in');
      void resultMessage.offsetWidth; // trigger reflow to restart animation
      resultMessage.classList.add('fade-in');
      if (isValid === true) {
        resultMessage.classList.add('valid');
        resultMessage.classList.remove('invalid');
      } else if (isValid === false) {
        resultMessage.classList.add('invalid');
        resultMessage.classList.remove('valid');
        shakeInput();
      } else {
        resultMessage.classList.remove('valid');
        resultMessage.classList.remove('invalid');
      }
    }

    function validateCard() {
      const cardNumber = cardInput.value.replace(/\s/g, '');
      if (cardNumber.length < 13 || cardNumber.length > 16) {
        showMessage('Card number must be between 13 and 16 digits.', false);
        return;
      }
      if (!luhnCheck(cardNumber)) {
        showMessage('Invalid card number (failed Luhn check).', false);
        return;
      }
      showMessage('Validating...', null);
      spinner.style.display = 'inline-block';
      validateBtn.disabled = true;

      fetch('<%=request.getContextPath()%>/CardValidationServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'cardNumber=' + encodeURIComponent(cardNumber),
      })
      .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
      })
      .then(data => {
        if (data.valid) {
          showMessage(data.message, true);
        } else {
          showMessage(data.message, false);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        showMessage('Server error. Please try again later.', false);
      })
      .finally(() => {
        spinner.style.display = 'none';
        validateBtn.disabled = false;
      });
    }
  </script>
<% } // end logged-in else %>
</body>
</html>
