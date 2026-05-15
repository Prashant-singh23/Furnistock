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
    <title>My Orders — FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap');
        
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
            font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg);
            font-size: 15px;
            line-height: 1.6;
            letter-spacing: 0.01em;
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
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: 0.02em;
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
            font-size: 14px;
            font-weight: 500;
            letter-spacing: 0.03em;
        }

        .container {
            max-width: 1020px;
            margin: 0 auto;
            padding: 32px 24px;
            color: var(--brown-dark);
        }

        .main-content {
            color: var(--brown-dark);
        }

        .header {
            background: var(--panel-bg);
            padding: 28px 32px;
            border-radius: 12px;
            margin-bottom: 28px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            border-left: 4px solid var(--gold);
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: 0.01em;
            line-height: 1.3;
        }

        .header p {
            font-size: 14px;
            letter-spacing: 0.02em;
        }

        .success-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: 0.02em;
        }

        table {
            width: 100%;
            background: var(--panel-bg);
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            margin-bottom: 24px;
        }

        th {
            background-color: var(--gold);
            color: var(--panel-bg);
            padding: 14px 18px;
            text-align: left;
            font-family: 'DM Sans', sans-serif;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid var(--border);
            font-size: 14px;
            color: var(--brown-dark);
            line-height: 1.5;
        }

        td strong {
            font-weight: 600;
            font-size: 14px;
            color: var(--brown-dark);
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: rgba(184, 130, 42, 0.04);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.04em;
            background-color: #d4edda;
            color: #155724;
        }

        .empty-orders {
            text-align: center;
            padding: 72px 24px;
            background: var(--panel-bg);
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
        }

        .empty-orders p {
            color: var(--text-muted);
            font-size: 15px;
            margin-bottom: 24px;
            line-height: 1.7;
            letter-spacing: 0.02em;
        }

        .btn {
            padding: 11px 26px;
            background-color: var(--gold);
            color: var(--panel-bg);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 0.03em;
            transition: background-color 0.2s ease;
        }

        .btn:hover {
            background-color: var(--gold-light);
        }

        .order-summary {
            background: var(--panel-bg);
            padding: 24px 32px;
            border-radius: 12px;
            margin-top: 24px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            font-size: 15px;
            color: var(--brown-dark);
            letter-spacing: 0.01em;
        }

        .summary-total {
            border-top: 2px solid var(--border);
            padding-top: 14px;
            margin-top: 4px;
            font-size: 20px;
            font-weight: 700;
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            letter-spacing: 0.01em;
        }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Dashboard Header -->
            <header class="header">
                <div class="header-greeting">
                    <h1><%= greeting %>, <%= firstName %>.</h1>
                    <p>Review your recent orders and order history</p>
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
                <h1><i class="bi bi-box"></i> My Orders</h1>
                <p style="color: var(--text-muted);">View your order history</p>
            </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg"><i class="bi bi-check-circle"></i> Checkout successful! Your order has been placed.</div>
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
                <td>NPR <%= String.format("%.2f", cart.getPrice()) %></td>
                <td><%= cart.getQuantity() %></td>
                <td>NPR <%= String.format("%.2f", cart.getTotalPrice()) %></td>
                <td><%= cart.getCreatedAt() %></td>
                <td><span class="status-badge"><i class="bi bi-check-circle"></i> <%= cart.getStatus() %></span></td>
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
            <strong>NPR <%= String.format("%.2f", totalSpent) %></strong>
        </div>
    </div>

    <div style="text-align: center; margin-top: 28px;">
        <a href="${pageContext.request.contextPath}/shop" class="btn"><i class="bi bi-arrow-left"></i> Continue Shopping</a>
    </div>

    <% } else { %>

    <!-- Empty Orders -->
    <div class="empty-orders">
        <p style="font-size: 48px; margin-bottom: 16px;"><i class="bi bi-box" style="font-size: 48px;"></i></p>
        <p>You haven't placed any orders yet</p>
        <a href="${pageContext.request.contextPath}/shop" class="btn">Start Shopping</a>
    </div>

    <% } %>

</div>

    </main>
</div>

</body>
</html>
