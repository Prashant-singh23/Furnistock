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
    <title>Shopping Cart — FurniStock</title>
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

        .btn-remove {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-remove:hover {
            background-color: #c0392b;
        }

        .checkout-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-box {
            text-align: right;
        }

        .total-label {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .total-price {
            font-size: 32px;
            font-weight: 700;
            color: #667eea;
        }

        .checkout-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
        }

        .btn-checkout {
            background-color: #667eea;
            color: white;
        }

        .btn-checkout:hover {
            background-color: #5568d3;
        }

        .btn-continue {
            background-color: #6c757d;
            color: white;
        }

        .btn-continue:hover {
            background-color: #5a6268;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 8px;
        }

        .empty-cart p {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
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
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>🛒 Shopping Cart</h1>
    </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg">✓ Checkout successful! Your order has been placed.</div>
    <% } %>

    <%
        List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");
        Double cartTotal = (Double) request.getAttribute("cartTotal");
        
        if (cartList != null && !cartList.isEmpty()) {
    %>

    <!-- Cart Items Table -->
    <table>
        <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Cart cart : cartList) { %>
            <tr>
                <td><strong><%= cart.getFurnitureName() %></strong></td>
                <td>$<%= String.format("%.2f", cart.getPrice()) %></td>
                <td><%= cart.getQuantity() %></td>
                <td>$<%= String.format("%.2f", cart.getTotalPrice()) %></td>
                <td>
                    <form method="POST" action="${pageContext.request.contextPath}/remove-from-cart" style="display: inline;">
                        <input type="hidden" name="cartId" value="<%= cart.getId() %>">
                        <button type="submit" class="btn-remove">Remove</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Checkout Section -->
    <div class="checkout-section">
        <div class="checkout-buttons">
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-continue">← Continue Shopping</a>
        </div>
        <div class="total-box">
            <div class="total-label">Subtotal:</div>
            <div class="total-price">$<%= String.format("%.2f", cartTotal != null ? cartTotal : 0.0) %></div>
            <form method="POST" action="${pageContext.request.contextPath}/checkout" style="margin-top: 15px;">
                <button type="submit" class="btn btn-checkout">Proceed to Checkout →</button>
            </form>
        </div>
    </div>

    <% } else { %>

    <!-- Empty Cart -->
    <div class="empty-cart">
        <p style="font-size: 48px; margin-bottom: 10px;">🛒</p>
        <p>Your cart is empty</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-checkout">Start Shopping</a>
    </div>

    <% } %>

</div>

</body>
</html>
