<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Furniture" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() == null || !"admin".equalsIgnoreCase(user.getRole())) {
%>
    <div style="padding:20px;background:#fee;border:1px solid #f99;">
        Admin check failed.<br/>
        user is null? <%= (user == null) %><br/>
        role = <%= (user == null ? "null" : user.getRole()) %>
    </div>
<%
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
            --success:    #27AE60;
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
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--panel-bg);
            padding: 30px;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 28px;
            font-weight: 700;
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
            background-color: var(--gold);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--gold-light);
        }

        .btn-secondary {
            background-color: var(--text-muted);
            color: white;
        }

        .btn-secondary:hover {
            background-color: var(--brown-dark);
        }

        .btn-danger {
            background-color: var(--error);
            color: white;
        }

        .btn-danger:hover {
            background-color: #9c3a2f;
        }

        .btn-edit {
            background-color: var(--gold);
            color: white;
            padding: 6px 12px;
            font-size: 12px;
        }

        .btn-edit:hover {
            background-color: var(--gold-light);
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: var(--panel-bg);
            padding: 15px;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .search-box input {
            flex: 1;
            padding: 10px 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Jost', sans-serif;
        }

        .search-box button {
            padding: 10px 20px;
            background-color: var(--gold);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
        }

        .success-msg {
            background-color: rgba(39, 174, 96, 0.1);
            color: var(--success);
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid var(--success);
        }

        .error-msg {
            background-color: rgba(192, 57, 43, 0.1);
            color: var(--error);
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid var(--error);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--panel-bg);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--border);
        }

        th {
            background-color: var(--brown-dark);
            color: white;
            padding: 16px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border);
            color: var(--text);
        }

        tr:hover {
            background-color: var(--cream);
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
            background-color: var(--gold);
        }

        .action-edit:hover {
            background-color: var(--gold-light);
        }

        .action-delete {
            background-color: var(--error);
        }

        .action-delete:hover {
            background-color: #9c3a2f;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
            background: var(--panel-bg);
            border-radius: 12px;
            border: 1px solid var(--border);
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
            background-color: var(--panel-bg);
            margin: 10% auto;
            padding: 30px;
            border: 1px solid var(--border);
            width: 400px;
            border-radius: 12px;
        }

        .modal-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
            color: var(--brown-dark);
        }

        .modal-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            justify-content: flex-end;
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
    </style>
</head>
<body>

<div class="main-wrapper">
    <jsp:include page="admin-sidebar.jsp" />
    <main class="main-content">
        <div class="container">
    <!-- Header -->
    <div class="header">
        <h1><i class="bi bi-box"></i> Manage Furniture</h1>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/furniture-add" class="btn btn-primary">+ Add New Item</a>
        </div>
    </div>

    <!-- Success / Error Messages -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg"><i class="bi bi-check-circle"></i> Operation completed successfully!</div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg"><i class="bi bi-exclamation-circle"></i> <%= request.getAttribute("error") %></div>
    <% } %>

    <!-- Search Box -->
    <div class="search-box">
        <form style="display: flex; gap: 10px; width: 100%; flex-wrap: wrap;" action="${pageContext.request.contextPath}/furniture-search" method="get">
            <input type="text" name="search" placeholder="Search by name or description..." value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>" style="flex: 2; min-width: 220px;">
            <select name="sort" style="flex: 1; min-width: 180px; padding: 10px 16px; border: 1px solid var(--border); border-radius: 8px; background: white; color: #1C1208;">
                <option value="" <%= request.getAttribute("sortOption") == null || "".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Sort: Newest</option>
                <option value="price_asc" <%= "price_asc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Price: Low to High</option>
                <option value="price_desc" <%= "price_desc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Price: High to Low</option>
                <option value="name_asc" <%= "name_asc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Name: A to Z</option>
                <option value="name_desc" <%= "name_desc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Name: Z to A</option>
            </select>
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
                <td>NPR <%= String.format("%.2f", furniture.getPrice()) %></td>
                <td><%= furniture.getStock() %></td>
                <%
                    String description = furniture.getDescription() != null ? furniture.getDescription() : "";
                    String shortDescription = description.length() > 50 ? description.substring(0, 50) + "..." : description;
                %>
                <td><%= shortDescription %></td>
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
    </main>
</div>
</body>
</html>
