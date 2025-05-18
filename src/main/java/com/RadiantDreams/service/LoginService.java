package com.RadiantDreams.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.util.PasswordUtil;

public class LoginService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    // Constructor attempts DB connection
    public LoginService() {
        try {
            dbConn = DBConfig.getDbConnection();
            System.out.println("LoginService: Connected to DB");
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("LoginService: Failed to connect to DB");
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    // Authenticates user based on role (admin vs customer)
    public Boolean loginUser(String username, String password, String role) {
        if ("admin".equalsIgnoreCase(role)) {
            return "admin".equals(username) && "admin123".equals(password);
        }

        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT username, password FROM customer WHERE username = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                String dbUsername = result.getString("username");
                String dbEncryptedPassword = result.getString("password");

                // Decrypt the password using utility
                String decryptedPassword = PasswordUtil.decrypt(dbEncryptedPassword, dbUsername);

                return dbUsername.equals(username) && decryptedPassword.equals(password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return false;
    }
}
