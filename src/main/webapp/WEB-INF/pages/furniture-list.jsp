<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Furniture" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin-login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Furniture — FurniStock Admin</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            color: #333;
            font-size: 24px;
        }

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background-color: #5568d3;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-edit {
            background-color: #3498db;
            color: white;
            padding: 6px 12px;
            font-size: 12px;
        }

        .btn-edit:hover {
            background-color: #2980b9;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .search-box input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .search-box button {
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

        .error-msg {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #667eea;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .table-actions {
            display: flex;
            gap: 8px;
        }

        .action-link {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            color: white;
            cursor: pointer;
            border: none;
        }

        .action-edit {
            background-color: #3498db;
        }

        .action-edit:hover {
            background-color: #2980b9;
        }

        .action-delete {
            background-color: #e74c3c;
        }

        .action-delete:hover {
            background-color: #c0392b;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            background: white;
            border-radius: 8px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            border-radius: 8px;
        }

        .modal-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .modal-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            justify-content: flex-end;
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
    </style>
</head>
<body>

<!-- Navigation -->
<div class="navbar">
    <div class="nav-brand">Furni<span>Stock</span> - Furniture Manager</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/admin" class="back-link">← Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="back-link">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>📦 Manage Furniture</h1>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/furniture-add" class="btn btn-primary">+ Add New Item</a>
        </div>
    </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg">✓ Operation completed successfully!</div>
    <% } %>

    <!-- Search Box -->
    <div class="search-box">
        <form style="display: flex; gap: 10px; width: 100%;" action="${pageContext.request.contextPath}/furniture-search" method="get">
            <input type="text" name="search" placeholder="Search by name or description..." value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>">
            <button type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/furniture-list" class="btn btn-secondary">Clear</a>
        </form>
    </div>

    <!-- Furniture Table -->
    <%
        List<Furniture> furnitureList = (List<Furniture>) request.getAttribute("furnitureList");
        if (furnitureList != null && !furnitureList.isEmpty()) {
    %>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Furniture furniture : furnitureList) { %>
            <tr>
                <td><%= furniture.getId() %></td>
                <td><strong><%= furniture.getName() %></strong></td>
                <td><%= furniture.getCategory() %></td>
                <td>$<%= String.format("%.2f", furniture.getPrice()) %></td>
                <td><%= furniture.getStock() %></td>
                <td><%= furniture.getDescription().length() > 50 ? furniture.getDescription().substring(0, 50) + "..." : furniture.getDescription() %></td>
                <td>
                    <div class="table-actions">
                        <a href="${pageContext.request.contextPath}/furniture-edit?id=<%= furniture.getId() %>" class="action-link action-edit">Edit</a>
                        <form method="POST" action="${pageContext.request.contextPath}/furniture-delete" style="display: inline;">
                            <input type="hidden" name="id" value="<%= furniture.getId() %>">
                            <button type="submit" class="action-link action-delete" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-data">
        <p>No furniture items found. <a href="${pageContext.request.contextPath}/furniture-add" style="color: #667eea; text-decoration: none;">Add one now</a></p>
    </div>
    <% } %>
</div>

</body>
</html>
