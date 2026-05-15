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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
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
            --shadow:     0 20px 60px rgba(46, 27, 14, 0.12);
            --shadow-sm:  0 4px 16px rgba(46, 27, 14, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Jost', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: var(--panel-bg);
            padding: 20px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--text);
            border-bottom: 1px solid var(--border);
        }

        .nav-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 600;
            gap: 12px;
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
        }

        .nav-brand span {
            color: var(--brown-dark);
        }

        .nav-brand span:last-child {
            color: var(--gold);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .sidebar {
            width: 280px;
            background: var(--panel-bg);
            border-right: 1px solid var(--border);
            padding: 30px 0;
            position: sticky;
            top: 0;
            height: calc(100vh - 80px);
            overflow-y: auto;
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
            flex: 1;
        }

        .main-content {
            flex: 1;
            overflow-y: auto;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.95rem;
            color: var(--text);
        }

        .admin-badge {
            background-color: var(--gold);
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .logout-btn {
            background-color: var(--gold);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.25s ease;
            font-weight: 600;
        }

        .logout-btn:hover {
            background-color: var(--gold-light);
            transform: translateY(-2px);
        }

        .container {
            flex: 1;
            padding: 60px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .dashboard-header {
            background: var(--panel-bg);
            padding: 40px;
            border-radius: 16px;
            margin-bottom: 60px;
            border: 1px solid var(--border);
        }

        .dashboard-header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .dashboard-header p {
            color: var(--text-muted);
            font-size: 16px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 60px;
        }

        .stat-card {
            background: var(--panel-bg);
            padding: 32px;
            border-radius: 16px;
            border: 1px solid var(--border);
            border-left: 4px solid var(--gold);
            transition: all 0.25s ease;
        }

        .stat-card:hover {
            box-shadow: var(--shadow-sm);
            transform: translateY(-4px);
        }

        .stat-card h3 {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 12px;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .stat-number {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            color: var(--brown-dark);
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
        }

        .feature-card {
            background: var(--panel-bg);
            padding: 32px;
            border-radius: 16px;
            border: 1px solid var(--border);
            text-align: center;
            transition: all 0.25s ease;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-sm);
            border-color: var(--gold);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .feature-card p {
            color: var(--text-muted);
            font-size: 15px;
            line-height: 1.7;
        }

        .feature-card a {
            display: inline-block;
            margin-top: 16px;
            background-color: var(--gold);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.25s ease;
        }

        .feature-card a:hover {
            background-color: var(--gold-light);
            transform: translateY(-2px);
        }

        .footer {
            background: var(--panel-bg);
            color: var(--text-muted);
            text-align: center;
            padding: 24px 60px;
            margin-top: auto;
            border-top: 1px solid var(--border);
            font-size: 14px;
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
    <div class="main-wrapper">
        <!-- Sidebar -->
        <jsp:include page="admin-sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="container">
                <!-- Header -->
                <div class="dashboard-header">
            <h1><i class="bi bi-hand-thumbs-up"></i> Welcome to Admin Dashboard</h1>
            <p>Manage your FurniStock furniture store from here</p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Customers</h3>
                <div id="admin-total-users" class="stat-number"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div id="admin-total-orders" class="stat-number"><%= request.getAttribute("totalOrders") != null ? request.getAttribute("totalOrders") : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>Product Listings</h3>
                <div id="admin-total-products" class="stat-number"><%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <div id="admin-total-revenue" class="stat-number">NPR <%= String.format("%.2f", request.getAttribute("totalRevenue") != null ? request.getAttribute("totalRevenue") : 0.0) %></div>
            </div>
        </div>

        <!-- Features Grid -->
        <div class="feature-grid">
            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-box"></i></div>
                <h3>Manage Products</h3>
                <p>Add, edit, or remove products from your inventory. Update prices and descriptions easily.</p>
                <a href="${pageContext.request.contextPath}/furniture-list">View Products</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-people"></i></div>
                <h3>Manage Customers</h3>
                <p>View and manage customer accounts, contact information, and account details.</p>
                <a href="${pageContext.request.contextPath}/customer-list">View Customers</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-graph-up"></i></div>
                <h3>View Reports</h3>
                <p>Analyze sales data, revenue trends, and generate comprehensive business reports.</p>
                <a href="${pageContext.request.contextPath}/admin-report">View Reports</a>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="bi bi-chat-dots"></i></div>
                <h3>Customer Feedback</h3>
                <p>View all customer messages and feedback submissions. Manage customer inquiries and support requests.</p>
                <a href="${pageContext.request.contextPath}/admin-feedback">View Feedback</a>
            </div>
        </div>
    </div>

                <!-- Footer -->
                <footer class="footer">
                    <p>&copy; 2025 FurniStock. All rights reserved. Admin Dashboard v1.0</p>
                </footer>
            </div>
        </div>
    </div>

    <script>
        function updateAdminMetrics() {
            fetch('<%= request.getContextPath() %>/admin-stats')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('admin-total-users').textContent = data.totalUsers;
                    document.getElementById('admin-total-orders').textContent = data.totalOrders;
                    document.getElementById('admin-total-products').textContent = data.totalProducts;
                    document.getElementById('admin-total-revenue').textContent = 'NPR ' + Number(data.totalRevenue).toFixed(2);
                })
                .catch(error => console.error('Failed to refresh admin metrics:', error));
        }

        document.addEventListener('DOMContentLoaded', () => {
            updateAdminMetrics();
            setInterval(updateAdminMetrics, 10000);
        });
    </script>
</body>
</html>
