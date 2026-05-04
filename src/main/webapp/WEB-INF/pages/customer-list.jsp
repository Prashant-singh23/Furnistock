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

        .action-view {
            background-color: #3498db;
        }

        .action-view:hover {
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
    <div class="nav-brand">Furni<span>Stock</span> - Customer Manager</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/admin" class="back-link">← Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="back-link">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>👥 Manage Customers</h1>
        <div class="header-actions">
            <span style="color: #666; font-size: 14px;">Total Customers: <%= request.getAttribute("customerList") != null ? ((List<User>) request.getAttribute("customerList")).size() : 0 %></span>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <% if (request.getParameter("deleted") != null) { %>
        <div class="success-msg">✓ Customer deleted successfully!</div>
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