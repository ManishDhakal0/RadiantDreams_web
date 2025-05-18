package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.OrderModel;
import com.RadiantDreams.model.OrderDetailModel;
import com.RadiantDreams.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    public void placeOrder(String username, int productId, int quantity) {
        String orderQuery = "INSERT INTO orders (customer_username) VALUES (?)";
        String detailQuery = "INSERT INTO order_details (order_id, product_id, quantity, status) VALUES (?, ?, ?, 'Pending')";
        String updateStockQuery = "UPDATE product SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";

        try (Connection conn = DBConfig.getDbConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement orderStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setString(1, username);
                orderStmt.executeUpdate();

                ResultSet rs = orderStmt.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);

                    try (PreparedStatement detailStmt = conn.prepareStatement(detailQuery);
                         PreparedStatement updateStockStmt = conn.prepareStatement(updateStockQuery)) {

                        detailStmt.setInt(1, orderId);
                        detailStmt.setInt(2, productId);
                        detailStmt.setInt(3, quantity);
                        detailStmt.executeUpdate();

                        updateStockStmt.setInt(1, quantity);
                        updateStockStmt.setInt(2, productId);
                        updateStockStmt.setInt(3, quantity);
                        int affected = updateStockStmt.executeUpdate();

                        if (affected == 0) {
                            conn.rollback();
                            throw new SQLException("Not enough stock or invalid product.");
                        }

                        conn.commit();
                    }
                }
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<OrderModel> getAllOrdersWithDetails() {
        List<OrderModel> orders = new ArrayList<>();
        String orderQuery = "SELECT * FROM orders ORDER BY order_date DESC";
        String detailsQuery = "SELECT od.*, p.name, p.price, p.image_url FROM order_details od JOIN product p ON od.product_id = p.id WHERE od.order_id = ?";
        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
             ResultSet orderRs = orderStmt.executeQuery()) {

            while (orderRs.next()) {
                OrderModel order = new OrderModel();
                order.setId(orderRs.getInt("id"));
                order.setCustomerUsername(orderRs.getString("customer_username"));
                order.setOrderDate(orderRs.getTimestamp("order_date"));

                try (PreparedStatement detailsStmt = conn.prepareStatement(detailsQuery)) {
                    detailsStmt.setInt(1, order.getId());
                    ResultSet detailsRs = detailsStmt.executeQuery();

                    List<OrderDetailModel> details = new ArrayList<>();

                    while (detailsRs.next()) {
                        OrderDetailModel detail = new OrderDetailModel();
                        detail.setId(detailsRs.getInt("id"));
                        detail.setOrderId(detailsRs.getInt("order_id"));
                        detail.setProductId(detailsRs.getInt("product_id"));
                        detail.setQuantity(detailsRs.getInt("quantity"));
                        detail.setStatus(detailsRs.getString("status")); // ← correct placement

                        ProductModel product = new ProductModel();
                        product.setId(detailsRs.getInt("product_id"));
                        product.setName(detailsRs.getString("name"));
                        product.setPrice(detailsRs.getDouble("price"));
                        product.setImageUrl(detailsRs.getString("image_url")); // optional

                        detail.setProduct(product);
                        details.add(detail);
                    }

                    order.setOrderDetails(details);
                }

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error loading orders: " + e.getMessage());
        }

        return orders;
    }
    public void updateOrderDetailStatus(int orderDetailId, String newStatus) {
        String sql = "UPDATE order_details SET status = ? WHERE id = ?";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, orderDetailId);
            int updated = stmt.executeUpdate();

            if (updated == 0) {
                throw new SQLException("No order detail found to update.");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
