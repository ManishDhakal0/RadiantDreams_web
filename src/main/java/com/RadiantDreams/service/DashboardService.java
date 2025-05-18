package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.*;

import java.sql.*;
import java.util.*;

public class DashboardService {

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        return DBConfig.getDbConnection();
    }

    public int getTotalCustomers() {
        String query = "SELECT COUNT(*) FROM customer";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalOrders() {
        String query = "SELECT COUNT(*) FROM orders";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue() {
        String query = "SELECT SUM(p.price * od.quantity) " +
                       "FROM order_details od JOIN product p ON od.product_id = p.id";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public List<OrderModel> getRecentOrders() {
        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY order_date DESC LIMIT 5";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setId(rs.getInt("id"));
                order.setCustomerUsername(rs.getString("customer_username"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return orders;
    }


    public List<CustomerModel> getLatestCustomers() {
        List<CustomerModel> customers = new ArrayList<>();
        String query = "SELECT * FROM customer ORDER BY id DESC LIMIT 5";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CustomerModel customer = new CustomerModel();
                customer.setId(rs.getInt("id"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setUsername(rs.getString("username"));
                customer.setDob(rs.getDate("dob").toLocalDate());
                customer.setGender(rs.getString("gender"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setPassword(rs.getString("password"));
                customer.setAddress(rs.getString("address"));
                customer.setImage(rs.getString("image"));
                customers.add(customer);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return customers;
    }
    public List<ProductModel> getTopSellingProducts() {
        List<ProductModel> topProducts = new ArrayList<>();
        String query = "SELECT p.id, p.name, SUM(od.quantity) AS total_sold " +
                       "FROM order_details od " +
                       "JOIN product p ON od.product_id = p.id " +
                       "GROUP BY p.id, p.name " +
                       "ORDER BY total_sold DESC LIMIT 5";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setQuantity(rs.getInt("total_sold")); // Reusing `quantity` field to hold total sold
                topProducts.add(product);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return topProducts;
    }
    // Get order counts per status
    public Map<String, Integer> getOrderStatusCounts() {
        Map<String, Integer> statusMap = new LinkedHashMap<>();
        String query = "SELECT status, COUNT(*) AS count FROM order_details GROUP BY status";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                statusMap.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return statusMap;
    }



}
