package com.Furnistock.model;

import java.time.LocalDateTime;

public class Feedback {
    private int id;
    private int userId;
    private String userEmail;
    private String userName;
    private String subject;
    private String message;
    private LocalDateTime createdAt;

    public Feedback() {
    }

    public Feedback(int id, int userId, String userEmail, String userName, String subject, String message, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.userEmail = userEmail;
        this.userName = userName;
        this.subject = subject;
        this.message = message;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
