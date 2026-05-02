<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Furniture" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop — FurniStock</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: #f5f7fa;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .nav-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-brand span {
            color: #667eea;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .cart-icon {
            position: relative;
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -12px;
            background-color: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #333;
            font-size: 28px;
        }

        .filters {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            border-radius: 8px;
        }

        .filters select {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }

        .filters button {
            padding: 10px 20px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .success-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .furniture-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .furniture-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .furniture-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .furniture-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            text-align: center;
            padding: 10px;
        }

        .furniture-info {
            padding: 15px;
        }

        .furniture-name {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .furniture-category {
            display: inline-block;
            background-color: #e8eef7;
            color: #667eea;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            margin-bottom: 10px;
        }

        .furniture-description {
            color: #666;
            font-size: 13px;
            line-height: 1.4;
            margin-bottom: 12px;
            height: 50px;
            overflow: hidden;
        }

        .furniture-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid #eee;
        }

        .furniture-price {
            font-size: 18px;
            font-weight: 700;
            color: #667eea;
        }

        .furniture-stock {
            font-size: 12px;
            color: #999;
        }

        .add-to-cart-form {
            display: flex;
            gap: 8px;
            margin-top: 10px;
        }

        .quantity-input {
            width: 60px;
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }

        .btn-add {
            flex: 1;
            background-color: #667eea;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .btn-add:hover {
            background-color: #5568d3;
        }

        .no-items {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 8px;
            color: #999;
        }

        .low-stock {
            color: #e74c3c;
            font-weight: 600;
        }
    </style>
</head>
<body>

<!-- Navigation -->
<div class="navbar">
    <div class="nav-brand">Furni<span>Stock</span></div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/shop">Shop</a>
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
            🛒 Cart
            <span class="cart-count"><%= request.getAttribute("cartCount") != null ? request.getAttribute("cartCount") : 0 %></span>
        </a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>🛋️ Furniture Shop</h1>
        <p style="color: #666;">Welcome, <%= user.getFirstName() %>! Browse our collection</p>
    </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg">✓ Item added to cart successfully!</div>
    <% } %>

    <!-- Filters -->
    <div class="filters">
        <form method="GET" action="${pageContext.request.contextPath}/shop" style="display: flex; gap: 10px; width: 100%;">
            <select name="category" style="flex: 1;">
                <option value="">All Categories</option>
                <option value="Sofa" <%= "Sofa".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Sofa</option>
                <option value="Chair" <%= "Chair".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Chair</option>
                <option value="Table" <%= "Table".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Table</option>
                <option value="Bed" <%= "Bed".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Bed</option>
                <option value="Cabinet" <%= "Cabinet".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Cabinet</option>
                <option value="Desk" <%= "Desk".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Desk</option>
                <option value="Shelf" <%= "Shelf".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Shelf</option>
                <option value="Bookcase" <%= "Bookcase".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Bookcase</option>
                <option value="Other" <%= "Other".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Other</option>
            </select>
            <button type="submit">Filter</button>
            <a href="${pageContext.request.contextPath}/shop" style="padding: 10px 20px; background-color: #6c757d; color: white; border-radius: 6px; text-decoration: none;">Clear</a>
        </form>
    </div>

    <!-- Furniture Grid -->
    <%
        List<Furniture> furnitureList = (List<Furniture>) request.getAttribute("furnitureList");
        if (furnitureList != null && !furnitureList.isEmpty()) {
    %>
    <div class="furniture-grid">
        <% for (Furniture furniture : furnitureList) { %>
        <div class="furniture-card">
            <div class="furniture-image">
                📦 <%= furniture.getCategory() %>
            </div>
            <div class="furniture-info">
                <div class="furniture-name"><%= furniture.getName() %></div>
                <span class="furniture-category"><%= furniture.getCategory() %></span>
                <div class="furniture-description"><%= furniture.getDescription() %></div>
                <div class="furniture-footer">
                    <div>
                        <div class="furniture-price">$<%= String.format("%.2f", furniture.getPrice()) %></div>
                        <div class="furniture-stock">
                            <% if (furniture.getStock() < 5) { %>
                                <span class="low-stock">Only <%= furniture.getStock() %> left!</span>
                            <% } else { %>
                                Stock: <%= furniture.getStock() %>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Add to Cart Form -->
                <form method="POST" action="${pageContext.request.contextPath}/add-to-cart" class="add-to-cart-form">
                    <input type="hidden" name="furnitureId" value="<%= furniture.getId() %>">
                    <input type="number" name="quantity" class="quantity-input" value="1" min="1" max="<%= furniture.getStock() %>" required>
                    <button type="submit" class="btn-add">Add to Cart</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="no-items">
        <p>No furniture items found in this category.</p>
    </div>
    <% } %>

</div>

</body>
</html>
