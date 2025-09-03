package com.creditcard.validation;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class ExpirationDateValidator {

    // Validate expiration date format MM/YY or MM/YYYY and check not expired
    public static boolean isValidExpirationDate(String expiryDate) {
        if (expiryDate == null) {
            return false;
        }

        // Try parsing in MM/YY format first
        DateTimeFormatter formatterShort = DateTimeFormatter.ofPattern("MM/yy");
        // Try parsing in MM/YYYY format as backup
        DateTimeFormatter formatterLong = DateTimeFormatter.ofPattern("MM/yyyy");

        YearMonth currentYearMonth = YearMonth.now();
        YearMonth cardExpiry = null;

        try {
            cardExpiry = YearMonth.parse(expiryDate, formatterShort);
        } catch (DateTimeParseException e) {
            try {
                cardExpiry = YearMonth.parse(expiryDate, formatterLong);
            } catch (DateTimeParseException ex) {
                return false;  // Invalid format
            }
        }

        // Check expiration: cardExpiry must be current or future month/year
        return !cardExpiry.isBefore(currentYearMonth);
    }
}
