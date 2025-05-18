package com.RadiantDreams.service;

import com.RadiantDreams.config.DBConfig;
import com.RadiantDreams.model.CategoryModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {

    public List<CategoryModel> getAllCategories() {
        List<CategoryModel> categories = new ArrayList<>();
        String query = "SELECT * FROM category";

        try (Connection conn = DBConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoryModel category = new CategoryModel();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
