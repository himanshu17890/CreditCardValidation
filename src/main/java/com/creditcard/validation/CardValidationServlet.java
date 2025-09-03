package com.creditcard.validation;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CardValidationServlet")
public class CardValidationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CardValidationServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cardNumber = request.getParameter("cardNumber");
        boolean isValid = false;
        String message;

        if (cardNumber == null || cardNumber.isEmpty()) {
            message = "Card number is required.";
        } else if (!cardNumber.matches("\\d{13,16}")) { // Properly escaped regex
            message = "Card number must be 13 to 16 digits.";
        } else {
            isValid = luhnCheck(cardNumber);
            message = isValid ? "Card is valid." : "Card is invalid.";
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print("{\"valid\": " + isValid + ", \"message\": \"" + message + "\"}");
        response.getWriter().flush();
    }

    // Luhn algorithm to validate credit card number
    private boolean luhnCheck(String cardNumber) {
        int sum = 0;
        boolean alternate = false;

        for (int i = cardNumber.length() - 1; i >= 0; i--) {
            int n = Integer.parseInt(cardNumber.substring(i, i + 1));
            if (alternate) {
                n *= 2;
                if (n > 9) n -= 9;
            }
            sum += n;
            alternate = !alternate;
        }

        return (sum % 10 == 0);
    }
}
