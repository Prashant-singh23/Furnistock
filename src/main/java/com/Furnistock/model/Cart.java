package com.Furnistock.model;

public class Cart {
    private int id;
    private int userId;
    private int furnitureId;
    private String furnitureName;
    private double price;
    private int quantity;
    private double totalPrice;
    private String status;
    private String createdAt;
    private String updatedAt;

    public Cart() {
    }

    public Cart(int userId, int furnitureId, int quantity) {
        this.userId = userId;
        this.furnitureId = furnitureId;
        this.quantity = quantity;
        this.status = "pending";
    }

    public Cart(int id, int userId, int furnitureId, String furnitureName, double price, int quantity, double totalPrice, String status) {
        this.id = id;
        this.userId = userId;
        this.furnitureId = furnitureId;
        this.furnitureName = furnitureName;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
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

    public int getFurnitureId() {
        return furnitureId;
    }

    public void setFurnitureId(int furnitureId) {
        this.furnitureId = furnitureId;
    }

    public String getFurnitureName() {
        return furnitureName;
    }

    public void setFurnitureName(String furnitureName) {
        this.furnitureName = furnitureName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}
