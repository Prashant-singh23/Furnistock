<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Cart" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Reports — FurniStock</title>
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

        .container {
            max-width: 1020px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        .sidebar {
            width: 280px;
            background: var(--panel-bg);
            border-right: 1px solid var(--border);
            padding: 30px 0;
            position: sticky;
            top: 0;
            height: calc(100vh - 40px);
            overflow-y: auto;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 0 24px 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }

        .sidebar-brand .brand-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--brown-dark);
        }

        .sidebar-brand .brand-name span {
            color: var(--gold);
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 0 0 24px;
            margin: 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 24px;
            border-radius: 10px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.25s ease;
            border-left: 3px solid transparent;
        }

        .nav-item i,
        .nav-item svg {
            font-size: 18px;
            width: 20px;
            display: inline-flex;
        }

        .nav-item:hover {
            background-color: var(--cream);
            color: var(--brown-dark);
        }

        .nav-item.active {
            background-color: var(--brown-dark);
            border-left-color: var(--gold);
            color: var(--panel-bg);
            font-weight: 600;
        }

        .main-wrapper {
            display: flex;
            min-height: calc(100vh - 20px);
        }

        .main-content {
            flex: 1;
            overflow-y: auto;
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
            color: var(--text-muted);
        }

        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 28px;
        }

        .report-card {
            background: var(--panel-bg);
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            border-top: 3px solid var(--gold);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .report-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .report-card-icon {
            font-size: 32px;
            color: var(--gold);
            margin-bottom: 12px;
        }

        .report-card-title {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 8px;
        }

        .report-card-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 4px;
        }

        .report-card-label {
            font-size: 13px;
            color: var(--text-muted);
            letter-spacing: 0.04em;
        }

        .report-section {
            background: var(--panel-bg);
            padding: 28px 32px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
        }

        .report-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 16px;
            border-bottom: 2px solid var(--border);
            padding-bottom: 12px;
        }

        .report-list {
            list-style: none;
        }

        .report-list li {
            padding: 12px 0;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
        }

        .report-list li:last-child {
            border-bottom: none;
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

        .btn-secondary {
            background-color: var(--text-muted);
        }

        .btn-secondary:hover {
            background-color: var(--brown-dark);
        }
    </style>
</head>
<body>
<div class="main-wrapper">
    <jsp:include page="admin-sidebar.jsp" />
    <div class="main-content">
        <div class="container">
            <!-- Main Content -->
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1><i class="bi bi-graph-up"></i> My Reports</h1>
                <p style="color: var(--text-muted);">Track your purchasing behavior and preferences</p>
            </div>

            <!-- Report Cards -->
            <div class="report-grid">
                <div class="report-card">
                    <div class="report-card-icon"><i class="bi bi-bag-check"></i></div>
                    <div class="report-card-title">Total Orders</div>
                    <div class="report-card-value">
                        <%
                            List<Cart> orderList = (List<Cart>) request.getAttribute("orderList");
                            int totalOrders = (orderList != null) ? orderList.size() : 0;
                        %>
                        <%= totalOrders %>
                    </div>
                    <div class="report-card-label">ALL TIME</div>
                </div>

                <div class="report-card">
                    <div class="report-card-icon"><i class="bi bi-currency-dollar"></i></div>
                    <div class="report-card-title">Total Spent</div>
                    <div class="report-card-value">
                        <%
                            double totalSpent = 0.0;
                            if (orderList != null) {
                                for (Cart cart : orderList) {
                                    totalSpent += cart.getTotalPrice();
                                }
                            }
                        %>
                        NPR <%= String.format("%.0f", totalSpent) %>
                    </div>
                    <div class="report-card-label">ALL TIME</div>
                </div>

                <div class="report-card">
                    <div class="report-card-icon"><i class="bi bi-box-seam"></i></div>
                    <div class="report-card-title">Avg Order Value</div>
                    <div class="report-card-value">
                        <%
                            double avgValue = (totalOrders > 0) ? (totalSpent / totalOrders) : 0;
                        %>
                        NPR <%= String.format("%.0f", avgValue) %>
                    </div>
                    <div class="report-card-label">PER ORDER</div>
                </div>
            </div>

            <!-- Detailed Reports -->
            <div class="report-section">
                <h2><i class="bi bi-list-ul"></i> Order Summary</h2>
                <% if (orderList != null && !orderList.isEmpty()) { %>
                    <ul class="report-list">
                        <% for (Cart cart : orderList) { %>
                        <li>
                            <span><strong><%= cart.getFurnitureName() %></strong></span>
                            <span>NPR <%= String.format("%.2f", cart.getTotalPrice()) %></span>
                        </li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <p style="color: var(--text-muted); text-align: center; padding: 24px 0;">No orders yet. <a href="${pageContext.request.contextPath}/shop">Start shopping</a></p>
                <% } %>
            </div>

            <!-- Action Buttons -->
            <div style="text-align: center; margin-top: 28px;">
                <% if ("admin".equals(user.getRole())) { %>
                    <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary"><i class="bi bi-house"></i> Back to Dashboard</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/shop" class="btn"><i class="bi bi-shop"></i> Continue Shopping</a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary"><i class="bi bi-house"></i> Back to Dashboard</a>
                <% } %>
            </div>
        </div>
    </div>
</div>

</body>
</html>
