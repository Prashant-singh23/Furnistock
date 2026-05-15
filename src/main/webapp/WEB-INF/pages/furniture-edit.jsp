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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&family=Jost:wght@300;400;500;600&display=swap');

        :root {
            --bg:         #F7F2EA;
            --panel-bg:   #FDFAF5;
            --brown-dark: #2E1B0E;
            --brown-mid:  #5C3D2E;
            --gold:       #B8822A;
            --gold-light: #D4A855;
            --cream:      #EDE5D4;
            --text:       #1C1208;
            --text-muted: #7A6652;
            --border:     #D9CEBC;
            --error:      #C0392B;
            --shadow-sm:  0 4px 16px rgba(46, 27, 14, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Jost', sans-serif;
            background: var(--bg);
            padding: 20px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .navbar {
            background-color: var(--panel-bg);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--text);
            border-bottom: 1px solid var(--border);
            margin-bottom: 20px;
            border-radius: 0;
        }

        .nav-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--brown-dark);
        }

        .nav-brand span {
            color: var(--gold);
        }

        .nav-right {
            display: flex;
            gap: 2rem;
        }

        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.25s ease;
        }

        .back-link:hover {
            color: var(--gold);
        }

        .main-wrapper {
            display: flex;
            gap: 30px;
            align-items: flex-start;
            min-height: calc(100vh - 40px);
        }

        .main-content {
            flex: 1;
            min-width: 0;
        }

        .sidebar {
            width: 280px;
            background: var(--panel-bg);
            border-right: 1px solid var(--border);
            padding: 30px;
            position: sticky;
            top: 0;
            height: calc(100vh - 40px);
            overflow-y: auto;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }

        .sidebar-brand .brand-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: var(--gold);
        }

        .sidebar-brand .brand-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--brown-dark);
        }

        .sidebar-brand .brand-name span {
            color: var(--gold);
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 24px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 18px;
            border-radius: 10px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.25s ease;
            border-left: 3px solid transparent;
        }

        .nav-item:hover {
            background-color: var(--cream);
            color: var(--brown-dark);
        }

        .nav-item.active {
            background-color: var(--brown-dark);
            color: white;
            border-left-color: var(--gold);
        }

        .sidebar-footer {
            margin-top: auto;
            padding-top: 24px;
        }

        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background-color: var(--gold);
            color: white;
            padding: 12px 16px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
        }

        .header {
            background: var(--panel-bg);
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 20px;
            border: 1px solid var(--border);
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .header p {
            color: var(--text-muted);
            font-size: 15px;
        }

        .form-card {
            background: var(--panel-bg);
            padding: 40px;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--brown-dark);
            font-weight: 600;
            font-size: 14px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Jost', sans-serif;
            color: var(--text);
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(184, 130, 42, 0.1);
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
            background-color: rgba(192, 57, 43, 0.1);
            color: var(--error);
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid var(--error);
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
            background-color: var(--gold);
            color: white;
        }

        .btn-submit:hover {
            background-color: var(--gold-light);
        }

        .btn-cancel {
            background-color: var(--text-muted);
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-cancel:hover {
            background-color: var(--brown-dark);
        }

        .item-id {
            background-color: var(--cream);
            color: var(--text-muted);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            margin-top: 5px;
        }

        .help-text {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="main-wrapper">
    <jsp:include page="admin-sidebar.jsp" />
    <main class="main-content">
        <div class="container">
    <!-- Header -->
    <div class="header">
        <h1><i class="bi bi-pencil"></i> Edit Furniture Item</h1>
        <p>Update the details of the furniture item below</p>
    </div>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg"><i class="bi bi-exclamation-triangle"></i> <%= request.getAttribute("error") %></div>
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
                    <label for="price">Price (NPR) *</label>
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
                <button type="submit" class="btn btn-submit"><i class="bi bi-check-circle"></i> Update Item</button>
                <a href="${pageContext.request.contextPath}/furniture-list" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
    </div>
    </main>
</div>

</body>
</html>
