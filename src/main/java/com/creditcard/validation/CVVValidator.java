package com.creditcard.validation;

public class CVVValidator {

    // Validate CVV given card type or general to 3 or 4 digits
    public static boolean isValidCVV(String cvv, String cardType) {
        if (cvv == null || !cvv.matches("\\d+")) {
            return false;  // Non-numeric CVV or null
        }

        int length = cvv.length();

        if ("AMEX".equalsIgnoreCase(cardType)) {
            // Amex CVV is 4 digits
            return length == 4;
        } else {
            // Most other cards have 3-digit CVV
            return length == 3;
        }
    }

    // Overloaded method for CVV only validation (3 or 4 digits)
    public static boolean isValidCVV(String cvv) {
        return cvv != null && cvv.matches("\\d{3,4}");
    }
}
