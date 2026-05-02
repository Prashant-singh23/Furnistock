<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Furnistock.model.Furniture" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin-login");
        return;
    }

    Furniture furniture = (Furniture) request.getAttribute("furniture");
    if (furniture == null) {
        response.sendRedirect(request.getContextPath() + "/furniture-list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Furniture — FurniStock Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: #f5f7fa;
            padding: 20px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
            border-radius: 0;
        }

        .nav-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-brand span {
            color: #667eea;
        }

        .nav-right {
            display: flex;
            gap: 1rem;
        }

        .back-link {
            color: white;
            text-decoration: none;
        }

        .back-link:hover {
            color: #667eea;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 5px;
        }

        .header p {
            color: #666;
            font-size: 14px;
        }

        .form-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            font-family: inherit;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .error-msg {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .form-buttons {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-submit {
            background-color: #667eea;
            color: white;
        }

        .btn-submit:hover {
            background-color: #5568d3;
        }

        .btn-cancel {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-cancel:hover {
            background-color: #5a6268;
        }

        .help-text {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        .item-id {
            background-color: #f5f5f5;
            color: #666;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<!-- Navigation -->
<div class="navbar">
    <div class="nav-brand">Furni<span>Stock</span> - Furniture Manager</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/furniture-list" class="back-link">← Back to List</a>
        <a href="${pageContext.request.contextPath}/logout" class="back-link">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>✏️ Edit Furniture Item</h1>
        <p>Update the details of the furniture item below</p>
    </div>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg">⚠️ <%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Edit Furniture Form -->
    <div class="form-card">
        <form action="${pageContext.request.contextPath}/furniture-edit" method="POST" novalidate>
            <!-- Hidden ID -->
            <input type="hidden" name="id" value="<%= furniture.getId() %>">

            <!-- Name -->
            <div class="form-group">
                <label for="name">Furniture Name *</label>
                <input type="text" id="name" name="name" placeholder="e.g., Modern Sofa" value="<%= furniture.getName() %>" required>
                <div class="help-text">Enter the product name</div>
            </div>

            <!-- Category & Price -->
            <div class="form-row">
                <div class="form-group">
                    <label for="category">Category *</label>
                    <select id="category" name="category" required>
                        <option value="Sofa" <%= "Sofa".equals(furniture.getCategory()) ? "selected" : "" %>>Sofa</option>
                        <option value="Chair" <%= "Chair".equals(furniture.getCategory()) ? "selected" : "" %>>Chair</option>
                        <option value="Table" <%= "Table".equals(furniture.getCategory()) ? "selected" : "" %>>Table</option>
                        <option value="Bed" <%= "Bed".equals(furniture.getCategory()) ? "selected" : "" %>>Bed</option>
                        <option value="Cabinet" <%= "Cabinet".equals(furniture.getCategory()) ? "selected" : "" %>>Cabinet</option>
                        <option value="Desk" <%= "Desk".equals(furniture.getCategory()) ? "selected" : "" %>>Desk</option>
                        <option value="Shelf" <%= "Shelf".equals(furniture.getCategory()) ? "selected" : "" %>>Shelf</option>
                        <option value="Bookcase" <%= "Bookcase".equals(furniture.getCategory()) ? "selected" : "" %>>Bookcase</option>
                        <option value="Other" <%= "Other".equals(furniture.getCategory()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="price">Price ($) *</label>
                    <input type="number" id="price" name="price" placeholder="0.00" step="0.01" min="0" value="<%= furniture.getPrice() %>" required>
                </div>
            </div>

            <!-- Stock & Image -->
            <div class="form-row">
                <div class="form-group">
                    <label for="stock">Stock Quantity *</label>
                    <input type="number" id="stock" name="stock" placeholder="0" min="0" value="<%= furniture.getStock() %>" required>
                </div>
                <div class="form-group">
                    <label for="imageUrl">Image URL</label>
                    <input type="text" id="imageUrl" name="imageUrl" placeholder="https://..." value="<%= furniture.getImageUrl() != null ? furniture.getImageUrl() : "" %>">
                    <div class="help-text">Leave empty to keep current image</div>
                </div>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label for="description">Description *</label>
                <textarea id="description" name="description" placeholder="Enter detailed description..." required><%= furniture.getDescription() %></textarea>
                <div class="help-text">Provide details about the furniture</div>
            </div>

            <!-- Item Info -->
            <div class="item-id">
                ID: <%= furniture.getId() %> | Created: <%= furniture.getCreatedAt() != null ? furniture.getCreatedAt() : "N/A" %>
            </div>

            <!-- Buttons -->
            <div class="form-buttons">
                <button type="submit" class="btn btn-submit">✓ Update Item</button>
                <a href="${pageContext.request.contextPath}/furniture-list" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
