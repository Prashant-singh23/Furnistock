<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Admin Dashboard — FurniStock</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
                'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: bold;
            gap: 0.5rem;
        }

        .nav-brand span {
            color: #667eea;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .admin-badge {
            background-color: #e74c3c;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .container {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .dashboard-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .dashboard-header h1 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .dashboard-header p {
            color: #666;
            font-size: 0.95rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #667eea;
        }

        .stat-card h3 {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .feature-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .feature-card p {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .feature-card a {
            display: inline-block;
            margin-top: 1rem;
            background-color: #667eea;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .feature-card a:hover {
            background-color: #764ba2;
        }

        .footer {
            background: rgba(0, 0, 0, 0.8);
            color: white;
            text-align: center;
            padding: 1.5rem;
            margin-top: auto;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-brand">
            <span>Furni</span>
            <strong>Stock</strong>
        </div>
        <div class="nav-right">
            <div class="admin-info">
                <span>Welcome, <%= user.getFirstName() %></span>
                <span class="admin-badge">Admin</span>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Header -->
        <div class="dashboard-header">
            <h1>👋 Welcome to Admin Dashboard</h1>
            <p>Manage your FurniStock furniture store from here</p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Customers</h3>
                <div class="stat-number">150+</div>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div class="stat-number">320+</div>
            </div>
            <div class="stat-card">
                <h3>Product Listings</h3>
                <div class="stat-number">500+</div>
            </div>
            <div class="stat-card">
                <h3>Monthly Revenue</h3>
                <div class="stat-number">$45K+</div>
            </div>
        </div>

        <!-- Features Grid -->
        <div class="feature-grid">
            <div class="feature-card">
                <div class="feature-icon">📦</div>
                <h3>Manage Products</h3>
                <p>Add, edit, or remove products from your inventory. Update prices and descriptions easily.</p>
                <a href="${pageContext.request.contextPath}/furniture-list">View Products</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">👥</div>
                <h3>Manage Customers</h3>
                <p>View customer details, order history, and manage customer accounts and subscriptions.</p>
                <a href="#">View Customers</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📋</div>
                <h3>View Orders</h3>
                <p>Monitor all orders, track shipments, and manage order statuses and fulfillment.</p>
                <a href="#">View Orders</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3>View Reports</h3>
                <p>Analyze sales data, revenue trends, and generate comprehensive business reports.</p>
                <a href="#">View Reports</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">⚙️</div>
                <h3>Settings</h3>
                <p>Configure store settings, update business information, and manage preferences.</p>
                <a href="#">Go to Settings</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📞</div>
                <h3>Support</h3>
                <p>View customer inquiries, manage support tickets, and respond to customer messages.</p>
                <a href="#">View Support</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 FurniStock. All rights reserved. Admin Dashboard v1.0</p>
    </footer>

</body>
</html>
