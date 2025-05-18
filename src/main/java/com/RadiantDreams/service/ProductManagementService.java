package com.RadiantDreams.service;

import com.RadiantDreams.model.ProductModel;
import com.RadiantDreams.config.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductManagementService {

    public List<ProductModel> getAllProducts() {
        List<ProductModel> productList = new ArrayList<>();
        String query = "SELECT * FROM product";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setAvailability(rs.getBoolean("availability"));
                p.setImageUrl(rs.getString("image_url"));
                p.setQuantity(rs.getInt("quantity"));
                productList.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    public boolean addProduct(ProductModel product) {
        String query = "INSERT INTO product (name, description, price, category, availability, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getCategory());
            stmt.setBoolean(5, product.isAvailability());
            stmt.setString(6, product.getImageUrl());
            stmt.setInt(7, product.getQuantity());

            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteProduct(int id) {
        String query = "DELETE FROM product WHERE id = ?";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }
    public ProductModel getProductById(int id) {
        String query = "SELECT * FROM product WHERE id = ?";
        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setAvailability(rs.getBoolean("availability"));
                p.setImageUrl(rs.getString("image_url"));
                p.setQuantity(rs.getInt("quantity"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateProduct(ProductModel product) {
        String query = "UPDATE product SET name=?, description=?, price=?, category=?, availability=?, quantity=?" +
                (product.getImageUrl() != null ? ", image_url=?" : "") + " WHERE id=?";
        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getCategory());
            stmt.setBoolean(5, product.isAvailability());
            stmt.setInt(6, product.getQuantity());

            if (product.getImageUrl() != null) {
                stmt.setString(7, product.getImageUrl());
                stmt.setInt(8, product.getId());
            } else {
                stmt.setInt(7, product.getId());
            }
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public List<ProductModel> searchProducts(String search) {
        List<ProductModel> productList = new ArrayList<>();
        String query = "SELECT * FROM product WHERE name LIKE ? OR description LIKE ? OR category LIKE ?";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            String likeSearch = "%" + search + "%";
            stmt.setString(1, likeSearch);
            stmt.setString(2, likeSearch);
            stmt.setString(3, likeSearch);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductModel p = new ProductModel();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setAvailability(rs.getBoolean("availability"));
                p.setImageUrl(rs.getString("image_url"));
                p.setQuantity(rs.getInt("quantity"));
                productList.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }


}
