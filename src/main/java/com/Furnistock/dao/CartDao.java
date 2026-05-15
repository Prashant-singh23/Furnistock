package com.Furnistock.dao;

import com.Furnistock.config.DBConfig;
import com.Furnistock.model.Cart;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    // Add item to cart
    public boolean addToCart(Cart cart) {
        String query = "INSERT INTO cart (user_id, furniture_id, quantity, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, cart.getUserId());
            pstmt.setInt(2, cart.getFurnitureId());
            pstmt.setInt(3, cart.getQuantity());
            pstmt.setString(4, cart.getStatus());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error adding to cart: " + e.getMessage());
            return false;
        }
    }

    // Get user's cart items
    public List<Cart> getUserCart(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT c.id, c.user_id, c.furniture_id, f.name, f.price, c.quantity, " +
                      "(f.price * c.quantity) as total_price, c.status, c.created_at " +
                      "FROM cart c " +
                      "JOIN furniture f ON c.furniture_id = f.id " +
                      "WHERE c.user_id = ? AND c.status = 'pending' " +
                      "ORDER BY c.created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFurnitureId(rs.getInt("furniture_id"));
                cart.setFurnitureName(rs.getString("name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setTotalPrice(rs.getDouble("total_price"));
                cart.setStatus(rs.getString("status"));
                cart.setCreatedAt(rs.getString("created_at"));

                cartList.add(cart);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching cart: " + e.getMessage());
        }

        return cartList;
    }

    // Remove item from cart
    public boolean removeFromCart(int cartId) {
        String query = "DELETE FROM cart WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, cartId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error removing from cart: " + e.getMessage());
            return false;
        }
    }

    // Update cart quantity
    public boolean updateCartQuantity(int cartId, int quantity) {
        String query = "UPDATE cart SET quantity = ? WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, quantity);
            pstmt.setInt(2, cartId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating cart: " + e.getMessage());
            return false;
        }
    }

    // Get cart total
    public double getCartTotal(int userId) {
        String query = "SELECT SUM(f.price * c.quantity) as total FROM cart c " +
                      "JOIN furniture f ON c.furniture_id = f.id " +
                      "WHERE c.user_id = ? AND c.status = 'pending'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (SQLException e) {
            System.err.println("Error calculating cart total: " + e.getMessage());
        }

        return 0.0;
    }

    // Clear cart (checkout)
    public boolean checkoutCart(int userId) {
        String query = "UPDATE cart SET status = 'ordered' WHERE user_id = ? AND status = 'pending'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error during checkout: " + e.getMessage());
            return false;
        }
    }

    // Get user's order history
    public List<Cart> getUserOrders(int userId) {
        List<Cart> orderList = new ArrayList<>();
        String query = "SELECT c.id, c.user_id, c.furniture_id, f.name, f.price, c.quantity, " +
                      "(f.price * c.quantity) as total_price, c.status, c.created_at " +
                      "FROM cart c " +
                      "JOIN furniture f ON c.furniture_id = f.id " +
                      "WHERE c.user_id = ? AND c.status = 'ordered' " +
                      "ORDER BY c.created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFurnitureId(rs.getInt("furniture_id"));
                cart.setFurnitureName(rs.getString("name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setTotalPrice(rs.getDouble("total_price"));
                cart.setStatus(rs.getString("status"));
                cart.setCreatedAt(rs.getString("created_at"));

                orderList.add(cart);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching orders: " + e.getMessage());
        }

        return orderList;
    }

    // Get cart item count
    public int getCartItemCount(int userId) {
        String query = "SELECT COUNT(*) as count FROM cart WHERE user_id = ? AND status = 'pending'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.err.println("Error getting cart count: " + e.getMessage());
        }

        return 0;
    }

    // Get total number of ordered items across all users
    public int getTotalOrderCount() {
        String query = "SELECT COUNT(*) as count FROM cart WHERE status = 'ordered'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.err.println("Error getting total order count: " + e.getMessage());
        }

        return 0;
    }

    // Get total revenue from ordered items
    public double getTotalRevenue() {
        String query = "SELECT SUM(f.price * c.quantity) as total FROM cart c " +
                       "JOIN furniture f ON c.furniture_id = f.id " +
                       "WHERE c.status = 'ordered'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (SQLException e) {
            System.err.println("Error getting total revenue: " + e.getMessage());
        }

        return 0.0;
    }

    // Get all orders across all users
    public List<Cart> getAllOrders() {
        List<Cart> orderList = new ArrayList<>();
        String query = "SELECT c.id, c.user_id, c.furniture_id, f.name, f.price, c.quantity, " +
                      "(f.price * c.quantity) as total_price, c.status, c.created_at " +
                      "FROM cart c " +
                      "JOIN furniture f ON c.furniture_id = f.id " +
                      "WHERE c.status = 'ordered' " +
                      "ORDER BY c.created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFurnitureId(rs.getInt("furniture_id"));
                cart.setFurnitureName(rs.getString("name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setTotalPrice(rs.getDouble("total_price"));
                cart.setStatus(rs.getString("status"));
                cart.setCreatedAt(rs.getString("created_at"));

                orderList.add(cart);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching all orders: " + e.getMessage());
        }

        return orderList;
    }
}
