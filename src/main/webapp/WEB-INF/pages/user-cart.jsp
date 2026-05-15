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
    String firstName = user.getFirstName();
    String greeting = "";
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
    if (hour < 12) greeting = "Good morning";
    else if (hour < 18) greeting = "Good afternoon";
    else greeting = "Good evening";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart — FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap');
        
        :root {
            --gold: #B8822A;
            --gold-light: #D4A855;
            --gold-accent: #E8D5B7;
            --bg: #F7F2EA;
            --error: #C0392B;
            --brown-dark: #2E1B0E;
            --text-muted: #7A6652;
            --border: #D9CEBC;
            --panel-bg: #FDFAF5;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: var(--bg);
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
            color: var(--gold);
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
            color: var(--brown-dark);
        }

        .main-content {
            color: var(--brown-dark);
        }

        .header {
            background: var(--panel-bg);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            color: var(--brown-dark);
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
            background: var(--panel-bg);
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        th {
            background-color: var(--gold);
            color: var(--panel-bg);
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
        }

        tr:hover {
            background-color: rgba(184, 130, 42, 0.05);
        }

        .btn-remove {
            background-color: var(--error);
            color: var(--panel-bg);
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-remove:hover {
            background-color: #a52a1a;
        }

        .checkout-section {
            background: var(--panel-bg);
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
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 5px;
        }

        .total-price {
            font-size: 32px;
            font-weight: 700;
            color: var(--gold);
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
            background-color: var(--gold);
            color: var(--panel-bg);
        }

        .btn-checkout:hover {
            background-color: var(--gold-light);
        }

        .btn-continue {
            background-color: var(--text-muted);
            color: var(--panel-bg);
        }

        .btn-continue:hover {
            background-color: #5a4a40;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: var(--panel-bg);
            border-radius: 8px;
        }

        .empty-cart p {
            color: var(--text-muted);
            font-size: 16px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="home-container">
    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Dashboard Header -->
            <header class="header">
                <div class="header-greeting">
                    <h1><%= greeting %>, <%= firstName %>.</h1>
                    <p>Manage your cart and checkout with ease</p>
                </div>
                <div class="header-search">
                    <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="text" placeholder="Search furniture...">
                </div>
                <div class="header-user">
                    <div class="user-avatar"><%= firstName != null && firstName.length() > 0 ? firstName.charAt(0) : 'U' %></div>
                </div>
            </header>

            <!-- Page Title -->
            <div class="header" style="margin-top: 20px;">
                <h1><i class="bi bi-cart"></i> Shopping Cart</h1>
            </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg"><i class="bi bi-check-circle"></i> Checkout successful! Your order has been placed.</div>
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
                <td>NPR <%= String.format("%.2f", cart.getPrice()) %></td>
                <td><%= cart.getQuantity() %></td>
                <td>NPR <%= String.format("%.2f", cart.getTotalPrice()) %></td>
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
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-continue"><i class="bi bi-arrow-left"></i> Continue Shopping</a>
        </div>
        <div class="total-box">
            <div class="total-label">Subtotal:</div>
            <div class="total-price">NPR <%= String.format("%.2f", cartTotal != null ? cartTotal : 0.0) %></div>
            <form method="POST" action="${pageContext.request.contextPath}/checkout" style="margin-top: 15px;">
                <button type="submit" class="btn btn-checkout">Proceed to Checkout <i class="bi bi-arrow-right"></i></button>
            </form>
        </div>
    </div>

    <% } else { %>

    <!-- Empty Cart -->
    <div class="empty-cart">
        <p style="font-size: 48px; margin-bottom: 10px;"><i class="bi bi-cart" style="font-size: 48px;"></i></p>
        <p>Your cart is empty</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-checkout">Start Shopping</a>
    </div>

    <% } %>

</div>

    </main>
</div>

</body>
</html>
