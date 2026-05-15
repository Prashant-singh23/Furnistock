package com.Furnistock.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
    private static final String URL = getConfig("FURNISTOCK_DB_URL", "db.url", "jdbc:mysql://localhost:3306/furnistock");
    private static final String USER = getConfig("FURNISTOCK_DB_USER", "db.user", "root");
    private static final String PASSWORD = getConfig("FURNISTOCK_DB_PASSWORD", "db.password", "");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String getConfig(String envName, String propertyName, String defaultValue) {
        String value = System.getProperty(propertyName);
        if (value == null || value.isBlank()) {
            value = System.getenv(envName);
        }
        return value == null ? defaultValue : value;
    }
}
