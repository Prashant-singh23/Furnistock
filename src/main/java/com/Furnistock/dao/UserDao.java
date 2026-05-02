package com.Furnistock.dao;

import com.Furnistock.config.dbconfig;
import com.Furnistock.model.User;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDao {

    // Register user
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (first_name, last_name, email, phone_number, password_hash) VALUES (?, ?, ?, ?, ?)";

        // Hash password
        String hashedPassword = BCrypt.hashpw(user.getPasswordHash(), BCrypt.gensalt());

        try (Connection conn = dbconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhoneNumber());
            pstmt.setString(5, hashedPassword);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error during registration: " + e.getMessage());
            return false;
        }
    }

    // Validate user (login using email)
    public User validateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = dbconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");

                // Fallback: If storedHash is not a BCrypt hash, check plain text
                boolean valid = false;
                if (storedHash != null && storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$") || storedHash.startsWith("$2y$")) {
                    valid = org.mindrot.jbcrypt.BCrypt.checkpw(password, storedHash);
                } else {
                    valid = password.equals(storedHash);
                }

                if (valid) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setPasswordHash(storedHash);
                    return user;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error during validation: " + e.getMessage());
        }

        return null;
    }

    // Admin login with hardcoded credentials
    public User validateAdmin(String username, String password) {
        // Hardcoded admin credentials
        String adminUsername = "admin";
        String adminPassword = "Admin@123";

        if (username.equals(adminUsername) && password.equals(adminPassword)) {
            User admin = new User();
            admin.setId(0);
            admin.setFirstName("Admin");
            admin.setLastName("User");
            admin.setEmail("admin@furnistock.com");
            admin.setPhoneNumber("9999999999");
            admin.setPasswordHash(adminPassword);
            admin.setRole("admin");
            return admin;
        }

        return null;
    }
}