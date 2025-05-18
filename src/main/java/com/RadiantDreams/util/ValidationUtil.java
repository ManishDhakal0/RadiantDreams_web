package com.RadiantDreams.util;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;
import jakarta.servlet.http.Part;

/**
 * Utility class for validating input fields.
 */
public class ValidationUtil {

    /**
     * Checks if a string contains only alphabetic characters (A-Z, a-z).
     *
     * @param value input string to validate
     * @return true if only letters, false otherwise
     */
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z]+$");
    }

    /**
     * Validates Nepali phone number format starting with 98 followed by 8 digits.
     *
     * @param number phone number string
     * @return true if valid, false otherwise
     */
    public static boolean isValidPhone(String number) {
        return number != null && number.matches("^98\\d{8}$");
    }

    /**
     * Validates email format using regex.
     *
     * @param email email string
     * @return true if valid email format, false otherwise
     */
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    /**
     * Validates password strength:
     * At least 8 characters, one uppercase, one digit, one special character.
     *
     * @param password password string
     * @return true if password meets criteria, false otherwise
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    /**
     * Checks if the date of birth corresponds to age >= 18 years.
     *
     * @param dob LocalDate of birth
     * @return true if age >= 18, false otherwise
     */
    public static boolean isAgeAtLeast18(LocalDate dob) {
        if (dob == null) return false;
        return Period.between(dob, LocalDate.now()).getYears() >= 18;
    }

    /**
     * Checks if password and confirm password fields match.
     *
     * @param password        first password
     * @param confirmPassword second password to match
     * @return true if both equal, false otherwise
     */
    public static boolean doPasswordsMatch(String password, String confirmPassword) {
        return password != null && password.equals(confirmPassword);
    }
}
