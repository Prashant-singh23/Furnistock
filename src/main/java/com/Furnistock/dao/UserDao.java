package com.Furnistock.dao;

import com.Furnistock.config.DBConfig;
import com.Furnistock.model.User;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    // Register user
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (first_name, last_name, email, phone_number, password_hash, role) VALUES (?, ?, ?, ?, ?, ?)";

        // Hash password
        String hashedPassword = BCrypt.hashpw(user.getPasswordHash(), BCrypt.gensalt());

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhoneNumber());
            pstmt.setString(5, hashedPassword);
            pstmt.setString(6, User.ROLE_USER);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error during registration: " + e.getMessage());
            return false;
        }
    }

    // Validate user (login using email)
    public User validateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");

                // Fallback: If storedHash is not a BCrypt hash, check plain text.
                boolean isBcryptHash = storedHash != null
                        && (storedHash.startsWith("$2a$")
                        || storedHash.startsWith("$2b$")
                        || storedHash.startsWith("$2y$"));
                boolean valid;
                if (isBcryptHash) {
                    try {
                        valid = BCrypt.checkpw(password, storedHash);
                    } catch (IllegalArgumentException e) {
                        valid = false;
                    }
                } else {
                    valid = password != null && password.equals(storedHash);
                }

                if (valid) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setPasswordHash(storedHash);
                    String role = rs.getString("role");
                    user.setRole(role == null || role.isBlank() ? User.ROLE_USER : role);
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

        if (adminUsername.equals(username) && adminPassword.equals(password)) {
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

    // Get total number of registered users
    public int getUserCount() {
        String query = "SELECT COUNT(*) as count FROM users";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.err.println("Error getting user count: " + e.getMessage());
        }

        return 0;
    }

    // Get all customers/users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT id, first_name, last_name, email, phone_number FROM users ORDER BY id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                users.add(user);
            }

        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
        }

        return users;
    }

    // Delete user by ID
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }

    // Get user by email
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setPasswordHash(rs.getString("password_hash"));
                return user;
            }

        } catch (SQLException e) {
            System.err.println("Error getting user by email: " + e.getMessage());
        }

        return null;
    }

    public boolean updatePasswordByEmail(String email, String plainPassword) {
        String query = "UPDATE users SET password_hash = ? WHERE LOWER(email) = LOWER(?)";
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating password for email: " + e.getMessage());
            return false;
        }
    }
}
