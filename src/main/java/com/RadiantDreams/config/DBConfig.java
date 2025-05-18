package com.RadiantDreams.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DbConfig manages the connection setup for the RadiantDreams MySQL database.
 */
public class DBConfig {

    // Database connection settings
    private static final String DB_NAME = "RadiantDreams1";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME;
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // Replace with actual password if needed

    /**
     * Provides a Connection object to the database.
     *
     * @return Connection instance to the database
     * @throws SQLException           if a DB access error occurs
     * @throws ClassNotFoundException if JDBC driver class is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}