<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login - Credit Card Validator</title>
  <style>
    /* Solid dark background for the full page */
    body {
      margin: 0;
      padding: 0;
      min-height: 100vh;
      background-color: #181a20;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #eee;
    }

    /* Centered login container with semi-transparent background */
    .login-container {
      background: rgba(24, 26, 32, 0.88);
      padding: 40px 48px 45px 48px;
      width: 360px;
      margin: 0 auto;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(31, 38, 135, 0.4);
      text-align: center;
      box-sizing: border-box;
    }

    h2 {
      color: #ffa502;
      margin-bottom: 30px;
      font-weight: 700;
      font-size: 2rem;
      letter-spacing: 1.2px;
      text-transform: uppercase;
      text-shadow: 0 1px 3px rgba(255, 165, 2, 0.8);
    }

    /* Input fields style */
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 16px 18px;
      margin-bottom: 24px;
      border-radius: 12px;
      border: none;
      background: #191b1f;
      color: #fff;
      font-size: 1.15rem;
      outline: none;
      box-shadow: inset 0 0 8px #000000a0;
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    input[type="text"]:focus, input[type="password"]:focus {
      background: #23232b;
      box-shadow: 0 0 8px 3px #ffa502cc;
      border-color: #ffa502;
      color: #fff;
    }

    /* Submit button style */
    button {
      width: 100%;
      padding: 16px 0;
      border: none;
      border-radius: 12px;
      font-size: 1.25rem;
      font-weight: 700;
      background: linear-gradient(90deg, #ffa502 0%, #ffac33 100%);
      color: #1b1b1b;
      cursor: pointer;
      box-shadow: 0 6px 18px rgba(255, 165, 2, 0.5);
      transition: background 0.3s ease, box-shadow 0.3s ease;
    }

    button:hover {
      background: linear-gradient(90deg, #ffb833 0%, #ffdd77 100%);
      box-shadow: 0 8px 24px rgba(255, 180, 0, 0.7);
    }

    /* Error message style */
    .error {
      background: #f9d6d5;
      color: #c53030;
      padding: 12px 16px;
      border-radius: 10px;
      margin-bottom: 24px;
      font-weight: 600;
      font-size: 0.95rem;
      box-shadow: 0 1px 4px rgba(197, 70, 70, 0.4);
      text-align: left;
    }

    /* Responsive tweaks */
    @media (max-width: 400px) {
      .login-container {
        width: 90vw;
        padding: 30px 20px 35px 20px;
      }
      h2 {
        font-size: 1.6rem;
        margin-bottom: 24px;
      }
      input[type="text"], input[type="password"], button {
        font-size: 1rem;
        padding: 14px 16px;
      }
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>SIGN IN TO VALIDATOR</h2>
    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>
    <form action="LoginServlet" method="post" novalidate>
      <input type="text" name="username" placeholder="Username" required autofocus />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">Log In</button>
    </form>
  </div>
</body>
</html>
