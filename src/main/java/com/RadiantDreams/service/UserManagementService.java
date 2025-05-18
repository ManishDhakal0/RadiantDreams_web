package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.CustomerModel;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserManagementService {

    // Get all users
    public List<CustomerModel> getAllUsers() {
        List<CustomerModel> users = new ArrayList<>();
        String query = "SELECT * FROM customer";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(extractUser(rs)); // Reuse method for mapping
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // Delete user by ID
    public boolean deleteUser(int id) {
        String query = "DELETE FROM customer WHERE id = ?";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Helper to map ResultSet to CustomerModel
    private CustomerModel extractUser(ResultSet rs) throws SQLException {
        return new CustomerModel(
            rs.getInt("id"),
            rs.getString("first_name"),
            rs.getString("last_name"),
            rs.getString("username"),
            rs.getDate("dob").toLocalDate(),
            rs.getString("gender"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("password"),
            rs.getString("address"),
            rs.getString("image")
        );
    }
}
