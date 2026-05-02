<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Cart" %>
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
    <title>My Orders — FurniStock</title>
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
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
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
            font-size: 28px;
            margin-bottom: 5px;
        }

        .success-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        th {
            background-color: #667eea;
            color: white;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background-color: #d4edda;
            color: #155724;
        }

        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 8px;
        }

        .empty-orders p {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #667eea;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #5568d3;
        }

        .order-summary {
            background: white;
            padding: 20px;
            border-radius: 8px;
            text-align: right;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .summary-total {
            border-top: 2px solid #eee;
            padding-top: 10px;
            font-size: 20px;
            font-weight: 700;
            color: #667eea;
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
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>📦 My Orders</h1>
        <p style="color: #666;">View your order history</p>
    </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg">✓ Checkout successful! Your order has been placed.</div>
    <% } %>

    <%
        List<Cart> orderList = (List<Cart>) request.getAttribute("orderList");
        
        if (orderList != null && !orderList.isEmpty()) {
    %>

    <!-- Orders Table -->
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Order Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                double totalSpent = 0.0;
                for (Cart cart : orderList) {
                    totalSpent += cart.getTotalPrice();
            %>
            <tr>
                <td><strong>#<%= cart.getId() %></strong></td>
                <td><%= cart.getFurnitureName() %></td>
                <td>$<%= String.format("%.2f", cart.getPrice()) %></td>
                <td><%= cart.getQuantity() %></td>
                <td>$<%= String.format("%.2f", cart.getTotalPrice()) %></td>
                <td><%= cart.getCreatedAt() %></td>
                <td><span class="status-badge">✓ <%= cart.getStatus() %></span></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Order Summary -->
    <div class="order-summary">
        <div class="summary-row">
            <span>Total Items Ordered:</span>
            <strong><%= orderList.size() %></strong>
        </div>
        <div class="summary-row summary-total">
            <span>Total Amount Spent:</span>
            <strong>$<%= String.format("%.2f", totalSpent) %></strong>
        </div>
    </div>

    <div style="text-align: center; margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/shop" class="btn">← Continue Shopping</a>
    </div>

    <% } else { %>

    <!-- Empty Orders -->
    <div class="empty-orders">
        <p style="font-size: 48px; margin-bottom: 10px;">📦</p>
        <p>You haven't placed any orders yet</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn">Start Shopping</a>
    </div>

    <% } %>

</div>

</body>
</html>
