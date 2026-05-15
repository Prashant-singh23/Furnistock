package com.Furnistock.dao;

import com.Furnistock.config.DBConfig;
import com.Furnistock.model.Feedback;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDao {

    public boolean saveFeedback(Feedback feedback) {
        String query = "INSERT INTO feedback (user_id, user_email, user_name, subject, message, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, feedback.getUserId());
            pstmt.setString(2, feedback.getUserEmail());
            pstmt.setString(3, feedback.getUserName());
            pstmt.setString(4, feedback.getSubject());
            pstmt.setString(5, feedback.getMessage());
            pstmt.setTimestamp(6, Timestamp.valueOf(feedback.getCreatedAt()));

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error saving feedback: " + e.getMessage());
            return false;
        }
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT id, user_id, user_email, user_name, subject, message, created_at FROM feedback ORDER BY created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setId(rs.getInt("id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setUserEmail(rs.getString("user_email"));
                fb.setUserName(rs.getString("user_name"));
                fb.setSubject(rs.getString("subject"));
                fb.setMessage(rs.getString("message"));
                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    fb.setCreatedAt(ts.toLocalDateTime());
                }
                feedbackList.add(fb);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching feedback: " + e.getMessage());
        }

        return feedbackList;
    }

    public int getFeedbackCount() {
        String query = "SELECT COUNT(*) as count FROM feedback";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.err.println("Error getting feedback count: " + e.getMessage());
        }

        return 0;
    }
}
