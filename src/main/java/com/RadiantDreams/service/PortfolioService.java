package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.CustomerModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class PortfolioService {

    // Fetch customer profile by username
    public CustomerModel getCustomerProfile(String username) {
        String query = "SELECT * FROM customer WHERE username = ?";
        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username); // Bind the username
            ResultSet rs = stmt.executeQuery(); // Execute the query

            if (rs.next()) {
                CustomerModel customer = new CustomerModel();
                customer.setId(rs.getInt("id"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setGender(rs.getString("gender"));
                customer.setDob(rs.getDate("dob").toLocalDate()); // Convert SQL date to LocalDate
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setImage(rs.getString("image"));
                return customer; // Return populated customer
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log any errors
        }
        return null; // Return null if not found
    }

    // Update customer profile with only non-null fields
    public boolean updateCustomerProfile(CustomerModel customer) {
        StringBuilder queryBuilder = new StringBuilder("UPDATE customer SET ");
        List<String> updates = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        // Dynamically build query based on non-null fields
        if (customer.getFirstName() != null) {
            updates.add("first_name = ?");
            params.add(customer.getFirstName());
        }
        if (customer.getLastName() != null) {
            updates.add("last_name = ?");
            params.add(customer.getLastName());
        }
        if (customer.getEmail() != null) {
            updates.add("email = ?");
            params.add(customer.getEmail());
        }
        if (customer.getPhone() != null) {
            updates.add("phone = ?");
            params.add(customer.getPhone());
        }
        if (customer.getAddress() != null) {
            updates.add("address = ?");
            params.add(customer.getAddress());
        }
        if (customer.getGender() != null) {
            updates.add("gender = ?");
            params.add(customer.getGender());
        }
        if (customer.getDob() != null) {
            updates.add("dob = ?");
            params.add(java.sql.Date.valueOf(customer.getDob()));
        }
        if (customer.getPassword() != null && !customer.getPassword().isBlank()) {
            updates.add("password = ?");
            params.add(customer.getPassword()); // Ideally hashed
        }
        if (customer.getImage() != null && !customer.getImage().isBlank()) {
            updates.add("image = ?");
            params.add(customer.getImage());
        }

        if (updates.isEmpty()) return false; // Nothing to update

        queryBuilder.append(String.join(", ", updates));
        queryBuilder.append(" WHERE username = ?"); // Match by username
        params.add(customer.getUsername());

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(queryBuilder.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i)); // Bind values
            }

            int rows = stmt.executeUpdate();
            return rows > 0; // Return success flag
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

