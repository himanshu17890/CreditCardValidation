Credit Card Validation Web Application
Project Overview
A Java-based web application that validates credit card details securely. It verifies card number authenticity using the Luhn algorithm, checks CVV format based on card type, and confirms that the expiry date is valid. It also supports user login and logout, with a MySQL backend.

Features
User authentication (login/logout).

Frontend validation for card number, CVV, and expiry date.

Server-side validation using:

Luhn algorithm for card numbers.

CVV length validation for AMEX and other cards.

Expiry date verification to avoid expired cards.

JSON response for validation status.

MySQL integration for users and logging.

Runs on Apache Tomcat server.

Setup Instructions
Prerequisites
Java JDK 8 or higher

Apache Tomcat server

MySQL database setup

Steps
Clone the repo:

text
git clone https://github.com/himanshu17890/CreditCardValidation.git
Configure MySQL connection settings in DBUtil class.

Build and deploy the project on Apache Tomcat.

Access the application via browser at http://localhost:8080/CreditCardValidation/.

Usage
Register and login through the dashboard.

Enter card details in the form on index.jsp.

Get instant validation feedback on card authenticity and status.

Technologies Used
Java Servlets & JSP

Java Regex & Luhn Algorithm

MySQL with JDBC

Apache Tomcat

HTML/CSS/JavaScript for frontend validation

Contribution Guidelines
Contributions welcome! Fork the repo, create a branch, commit your changes, and submit a pull request.

Contact
Email: himashupawar259@gmail.com

LinkedIn: https://www.linkedin.com/in/himanshu-pawar-a74b732a9/

