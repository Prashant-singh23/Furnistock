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

                if (BCrypt.checkpw(password, storedHash)) {
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
}