<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.Furnistock.model.Furniture, com.Furnistock.model.User, com.Furnistock.util.ImagePathResolver" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop — FurniStock</title>
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
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: var(--gold);
        }

        .cart-icon {
            position: relative;
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -12px;
            background-color: var(--error);
            color: var(--panel-bg);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: var(--panel-bg);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: var(--brown-dark);
            font-size: 28px;
        }

        .filters {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            border-radius: 8px;
        }

        .filters select {
            padding: 10px 15px;
            border: 1px solid var(--border);
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }

        .filters button {
            padding: 10px 20px;
            background-color: var(--gold);
            color: var(--panel-bg);
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .success-msg {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .furniture-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .furniture-card {
            background: var(--panel-bg);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .furniture-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .furniture-image {
            width: 100%;
            height: 250px;
            overflow: hidden;
            background: linear-gradient(135deg, var(--gold-accent) 0%, #f0f0f0 100%);
            position: relative;
        }

        .furniture-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .furniture-card:hover .furniture-image img {
            transform: scale(1.05);
        }

        .furniture-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 30%, rgba(255,255,255,0.2), transparent);
            pointer-events: none;
        }

        .furniture-info {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .furniture-name {
            font-size: 18px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .furniture-category {
            display: inline-block;
            background-color: rgba(184, 130, 42, 0.15);
            color: var(--gold);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            margin-bottom: 12px;
            width: fit-content;
            letter-spacing: 0.5px;
        }

        .furniture-description {
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 16px;
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .furniture-footer {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid var(--border);
            gap: 12px;
        }

        .furniture-price-section {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .furniture-price {
            font-size: 22px;
            font-weight: 800;
            color: var(--gold);
            letter-spacing: -0.5px;
        }

        .furniture-stock {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .add-to-cart-form {
            display: flex;
            gap: 10px;
            margin-top: 16px;
        }

        .quantity-input {
            width: 70px;
            padding: 10px 8px;
            border: 1.5px solid var(--border);
            border-radius: 6px;
            text-align: center;
            font-size: 14px;
            font-weight: 600;
            color: var(--brown-dark);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .quantity-input:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(184, 130, 42, 0.1);
        }

        .btn-add {
            flex: 1;
            background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(184, 130, 42, 0.3);
            letter-spacing: 0.5px;
        }

        .btn-add:hover {
            background: linear-gradient(135deg, var(--gold-light) 0%, #e8c650 100%);
            box-shadow: 0 6px 16px rgba(184, 130, 42, 0.4);
            transform: translateY(-2px);
        }

        .btn-add:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(184, 130, 42, 0.2);
        }

        .no-items {
            text-align: center;
            padding: 40px;
            background: var(--panel-bg);
            border-radius: 8px;
            color: #999;
        }

        .low-stock {
            color: var(--error);
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="home-container">
    <jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
<!-- Navigation -->
<div class="navbar">
    <div class="nav-brand">Furni<span>Stock</span></div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/shop">Shop</a>
        <% if (user != null) { %>
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
            <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
                <i class="bi bi-cart"></i> Cart
                <span class="cart-count"><%= request.getAttribute("cartCount") != null ? request.getAttribute("cartCount") : 0 %></span>
            </a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
        <% } %>
    </div>
</div>

<div class="container">
    <!-- Header -->
    <div class="header">
        <h1><i class="bi bi-house"></i> Furniture Shop</h1>
        <p style="color: var(--text-muted);">Welcome, <%= user != null ? user.getFirstName() : "Guest" %>! Browse our collection</p>
        <% if (user == null) { %>
            <p style="color: var(--text-muted); margin-top: 8px; font-size: 0.95rem;">Log in to access your cart and orders.</p>
        <% } %>
    </div>

    <!-- Success Message -->
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg"><i class="bi bi-check-circle"></i> Item added to cart successfully!</div>
    <% } %>

    <!-- Filters -->
    <div class="filters">
        <form method="GET" action="${pageContext.request.contextPath}/shop" style="display: flex; gap: 10px; width: 100%; flex-wrap: wrap;">
            <input type="text" name="search" placeholder="Search furniture..." value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>" style="flex: 2; padding: 10px 15px; border: 1px solid var(--border); border-radius: 6px;">
            <select name="category" style="flex: 1; min-width: 160px; padding: 10px 15px; border: 1px solid var(--border); border-radius: 6px;">
                <option value="" <%= request.getAttribute("selectedCategory") == null || "".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>All Categories</option>
                <option value="Sofa" <%= "Sofa".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Sofa</option>
                <option value="Chair" <%= "Chair".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Chair</option>
                <option value="Table" <%= "Table".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Table</option>
                <option value="Bed" <%= "Bed".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Bed</option>
                <option value="Cabinet" <%= "Cabinet".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Cabinet</option>
                <option value="Desk" <%= "Desk".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Desk</option>
                <option value="Shelf" <%= "Shelf".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Shelf</option>
                <option value="Bookcase" <%= "Bookcase".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Bookcase</option>
                <option value="Other" <%= "Other".equals(request.getAttribute("selectedCategory")) ? "selected" : "" %>>Other</option>
            </select>
            <select name="sort" style="flex: 1; min-width: 200px; padding: 10px 15px; border: 1px solid var(--border); border-radius: 6px;">
                <option value="" <%= request.getAttribute("sortOption") == null || "".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Sort: Newest</option>
                <option value="price_asc" <%= "price_asc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Price: Low to High</option>
                <option value="price_desc" <%= "price_desc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Price: High to Low</option>
                <option value="name_asc" <%= "name_asc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Name: A to Z</option>
                <option value="name_desc" <%= "name_desc".equals(request.getAttribute("sortOption")) ? "selected" : "" %>>Name: Z to A</option>
            </select>
            <button type="submit" style="padding: 10px 20px; background-color: var(--gold); color: var(--panel-bg); border: none; border-radius: 6px;">Apply</button>
            <a href="${pageContext.request.contextPath}/shop" style="padding: 10px 20px; background-color: #6c757d; color: white; border-radius: 6px; text-decoration: none;">Clear</a>
        </form>
    </div>

    <!-- Furniture Grid -->
    <%
        List<Furniture> furnitureList = (List<Furniture>) request.getAttribute("furnitureList");
        if (furnitureList != null && !furnitureList.isEmpty()) {
    %>
    <div class="furniture-grid">
        <% for (Furniture furniture : furnitureList) { %>
        <%
            String imageUrl = ImagePathResolver.resolveImagePath(
                    application,
                    furniture.getImageUrl(),
                    furniture.getName()
            );
            String imageSrc = imageUrl.startsWith("http://") || imageUrl.startsWith("https://")
                    ? imageUrl
                    : request.getContextPath() + imageUrl;
        %>
        <div class="furniture-card">
            <div class="furniture-image">
                <img src="<%= imageSrc %>" alt="<%= furniture.getName() %>">
            </div>
            <div class="furniture-info">
                <div class="furniture-name"><%= furniture.getName() %></div>
                <span class="furniture-category"><%= furniture.getCategory() %></span>
                <div class="furniture-description"><%= furniture.getDescription() %></div>
                <div class="furniture-footer">
                    <div class="furniture-price-section">
                        <div class="furniture-price">NPR <%= String.format("%.2f", furniture.getPrice()) %></div>
                        <div class="furniture-stock">
                            <% if (furniture.getStock() < 5) { %>
                                <span class="low-stock">Only <%= furniture.getStock() %> left!</span>
                            <% } else { %>
                                In Stock
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Add to Cart Form -->
                <form method="POST" action="${pageContext.request.contextPath}/add-to-cart" class="add-to-cart-form">
                    <input type="hidden" name="furnitureId" value="<%= furniture.getId() %>">
                    <input type="number" name="quantity" class="quantity-input" value="1" min="1" max="<%= furniture.getStock() %>" required>
                    <button type="submit" class="btn-add">Add to Cart</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="no-items">
        <p><%= request.getAttribute("searchTerm") != null && !"".equals(request.getAttribute("searchTerm"))
                ? "No furniture items found matching \"" + request.getAttribute("searchTerm") + "\"."
                : "No furniture items found in this category." %></p>
    </div>
    <% } %>

</div>
</div>

</body>
</html>
