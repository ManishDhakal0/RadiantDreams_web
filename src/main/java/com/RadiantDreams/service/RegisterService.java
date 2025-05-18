package com.RadiantDreams.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.CustomerModel;
import com.RadiantDreams.util.PasswordUtil;

/**
 * RegisterService handles the registration of new customers.
 */
public class RegisterService {

    private Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public RegisterService() {
        try {
            this.dbConn = DBConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Registers a new customer in the database.
     *
     * @param customer the customer details to be registered
     * @return Boolean indicating the success of the operation
     */
    public Boolean addCustomer(CustomerModel customer) {
        String sql = "INSERT INTO customer (first_name, last_name, username, password, gender, email, phone, address, dob, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {

            stmt.setString(1, customer.getFirstName());
            stmt.setString(2, customer.getLastName());
            stmt.setString(3, customer.getUsername());

            // Encrypt the password here
            String encryptedPassword = PasswordUtil.encrypt(customer.getUsername(), customer.getPassword());
            stmt.setString(4, encryptedPassword);

            stmt.setString(5, customer.getGender());
            stmt.setString(6, customer.getEmail());
            stmt.setString(7, customer.getPhone());
            stmt.setString(8, customer.getAddress());
            stmt.setDate(9, java.sql.Date.valueOf(customer.getDob()));
            stmt.setString(10, customer.getImage());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}