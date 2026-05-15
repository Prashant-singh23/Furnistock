package com.Furnistock.dao;

import com.Furnistock.config.DBConfig;
import com.Furnistock.model.Furniture;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FurnitureDao {

    // Create furniture item
    public boolean addFurniture(Furniture furniture) {
        String query = "INSERT INTO furniture (name, description, category, price, stock, image_url) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, furniture.getName());
            pstmt.setString(2, furniture.getDescription());
            pstmt.setString(3, furniture.getCategory());
            pstmt.setDouble(4, furniture.getPrice());
            pstmt.setInt(5, furniture.getStock());
            pstmt.setString(6, furniture.getImageUrl());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error adding furniture: " + e.getMessage());
            return false;
        }
    }

    // Read all furniture items
    public List<Furniture> getAllFurniture(String sortOption) {
        List<Furniture> furnitureList = new ArrayList<>();
        String query = "SELECT * FROM furniture ORDER BY " + getSortClause(sortOption);

        try (Connection conn = DBConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Furniture furniture = new Furniture();
                furniture.setId(rs.getInt("id"));
                furniture.setName(rs.getString("name"));
                furniture.setDescription(rs.getString("description"));
                furniture.setCategory(rs.getString("category"));
                furniture.setPrice(rs.getDouble("price"));
                furniture.setStock(rs.getInt("stock"));
                furniture.setImageUrl(rs.getString("image_url"));
                furniture.setCreatedAt(rs.getString("created_at"));

                furnitureList.add(furniture);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching furniture: " + e.getMessage());
        }

        return furnitureList;
    }

    public List<Furniture> getAllFurniture() {
        return getAllFurniture(null);
    }

    public int getFurnitureCount() {
        String query = "SELECT COUNT(*) as count FROM furniture";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.err.println("Error getting furniture count: " + e.getMessage());
        }

        return 0;
    }

    private String getSortClause(String sortOption) {
        if (sortOption == null) {
            return "id DESC";
        }

        return switch (sortOption) {
            case "price_asc" -> "price ASC";
            case "price_desc" -> "price DESC";
            case "name_asc" -> "name ASC";
            case "name_desc" -> "name DESC";
            default -> "id DESC";
        };
    }

    // Read furniture by ID
    public Furniture getFurnitureById(int id) {
        String query = "SELECT * FROM furniture WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Furniture furniture = new Furniture();
                furniture.setId(rs.getInt("id"));
                furniture.setName(rs.getString("name"));
                furniture.setDescription(rs.getString("description"));
                furniture.setCategory(rs.getString("category"));
                furniture.setPrice(rs.getDouble("price"));
                furniture.setStock(rs.getInt("stock"));
                furniture.setImageUrl(rs.getString("image_url"));
                furniture.setCreatedAt(rs.getString("created_at"));

                return furniture;
            }

        } catch (SQLException e) {
            System.err.println("Error fetching furniture by ID: " + e.getMessage());
        }

        return null;
    }

    // Update furniture item
    public boolean updateFurniture(Furniture furniture) {
        String query = "UPDATE furniture SET name = ?, description = ?, category = ?, price = ?, stock = ?, image_url = ? WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, furniture.getName());
            pstmt.setString(2, furniture.getDescription());
            pstmt.setString(3, furniture.getCategory());
            pstmt.setDouble(4, furniture.getPrice());
            pstmt.setInt(5, furniture.getStock());
            pstmt.setString(6, furniture.getImageUrl());
            pstmt.setInt(7, furniture.getId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating furniture: " + e.getMessage());
            return false;
        }
    }

    // Delete furniture item
    public boolean deleteFurniture(int id) {
        String query = "DELETE FROM furniture WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting furniture: " + e.getMessage());
            return false;
        }
    }

    // Search furniture by category
    public List<Furniture> getFurnitureByCategory(String category, String sortOption) {
        List<Furniture> furnitureList = new ArrayList<>();
        String query = "SELECT * FROM furniture WHERE category = ? ORDER BY " + getSortClause(sortOption);

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Furniture furniture = new Furniture();
                furniture.setId(rs.getInt("id"));
                furniture.setName(rs.getString("name"));
                furniture.setDescription(rs.getString("description"));
                furniture.setCategory(rs.getString("category"));
                furniture.setPrice(rs.getDouble("price"));
                furniture.setStock(rs.getInt("stock"));
                furniture.setImageUrl(rs.getString("image_url"));
                furniture.setCreatedAt(rs.getString("created_at"));

                furnitureList.add(furniture);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching furniture by category: " + e.getMessage());
        }

        return furnitureList;
    }

    public List<Furniture> getFurnitureByCategory(String category) {
        return getFurnitureByCategory(category, null);
    }

    // Search furniture by name
    public List<Furniture> searchFurniture(String searchTerm, String sortOption) {
        List<Furniture> furnitureList = new ArrayList<>();
        String query = "SELECT * FROM furniture WHERE name LIKE ? OR description LIKE ? ORDER BY " + getSortClause(sortOption);

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            String term = "%" + searchTerm + "%";
            pstmt.setString(1, term);
            pstmt.setString(2, term);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Furniture furniture = new Furniture();
                furniture.setId(rs.getInt("id"));
                furniture.setName(rs.getString("name"));
                furniture.setDescription(rs.getString("description"));
                furniture.setCategory(rs.getString("category"));
                furniture.setPrice(rs.getDouble("price"));
                furniture.setStock(rs.getInt("stock"));
                furniture.setImageUrl(rs.getString("image_url"));
                furniture.setCreatedAt(rs.getString("created_at"));

                furnitureList.add(furniture);
            }

        } catch (SQLException e) {
            System.err.println("Error searching furniture: " + e.getMessage());
        }

        return furnitureList;
    }

    public List<Furniture> searchFurniture(String searchTerm) {
        return searchFurniture(searchTerm, null);
    }
}
