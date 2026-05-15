<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin-login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers — FurniStock Admin</title>
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

        .action-view {
            background-color: var(--gold);
        }

        .action-view:hover {
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
    </style>
</head>
<body>

<!-- Navigation -->
<div class="navbar">
    <div class="nav-brand">Furni<span>Stock</span> - Customer Manager</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/admin" class="back-link"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="back-link">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1><i class="bi bi-people"></i> Manage Customers</h1>
        <div class="header-actions">
            <span style="color: #666; font-size: 14px;">Total Customers: <%= request.getAttribute("customerList") != null ? ((List<User>) request.getAttribute("customerList")).size() : 0 %></span>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <% if (request.getParameter("deleted") != null) { %>
        <div class="success-msg"><i class="bi bi-check-circle"></i> Customer deleted successfully!</div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <div class="error-msg">✗ Error: <%= request.getParameter("error").equals("invalid_id") ? "Invalid customer ID" : request.getParameter("error").equals("delete_failed") ? "Failed to delete customer" : "Missing customer ID" %></div>
    <% } %>

    <!-- Customer Table -->
    <%
        List<User> customerList = (List<User>) request.getAttribute("customerList");
        if (customerList != null && !customerList.isEmpty()) {
    %>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Registration Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (User customer : customerList) { %>
            <tr>
                <td><%= customer.getId() %></td>
                <td><strong><%= customer.getFirstName() %> <%= customer.getLastName() %></strong></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getPhoneNumber() != null ? customer.getPhoneNumber() : "N/A" %></td>
                <td>Registered</td>
                <td>
                    <div class="table-actions">
                        <a href="#" class="action-link action-view" onclick="alert('Customer Details:\\n\\nName: <%= customer.getFirstName() %> <%= customer.getLastName() %>\\nEmail: <%= customer.getEmail() %>\\nPhone: <%= customer.getPhoneNumber() != null ? customer.getPhoneNumber() : "N/A" %>'); return false;">View</a>
                        <form method="POST" action="${pageContext.request.contextPath}/customer-delete" style="display: inline;">
                            <input type="hidden" name="id" value="<%= customer.getId() %>">
                            <button type="submit" class="action-link action-delete" onclick="return confirm('Are you sure you want to delete this customer? This action cannot be undone.');">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
    <div class="no-data">
        <p>No customers found.</p>
    </div>
    <% } %>
</div>

</body>
</html>