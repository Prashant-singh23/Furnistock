<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Furniture" %>
<%@ page import="com.Furnistock.model.User" %>
<%@ page import="com.Furnistock.util.ImagePathResolver" %>
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
    <title>Home — FurniStock</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<div class="home-container">
    <jsp:include page="sidebar.jsp" />

    <main class="main-content">
        <!-- Header -->
        <header class="header">
            <div class="header-greeting">
                <h1><%= greeting %>, <%= firstName %>.</h1>
                <p>Welcome back to your furniture dashboard</p>
            </div>
            <div class="header-search">
                <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="text" placeholder="Search furniture...">
            </div>
            <div class="header-user">
                <div class="user-avatar">
                    <%= firstName != null && firstName.length() > 0 ? firstName.charAt(0) : 'U' %>
                </div>
            </div>
        </header>

        <!-- Banner -->
        <section class="banner">
            <div class="banner-content">
                <span class="banner-tag">NEW ARRIVAL</span>
                <h2>The Velvet Sculpt Series</h2>
                <p>Artisan-crafted textures meet structural ergonomics. Discover our latest collection.</p>
                <a href="${pageContext.request.contextPath}/shop" class="explore-btn">Explore Collection</a>
            </div>
            <div class="banner-decoration" style="position: absolute; right: 60px; top: 50%; transform: translateY(-50%); width: 250px; height: 250px; overflow: hidden; border-radius: 8px;">
                <img src="${pageContext.request.contextPath}/images/velvet.avif" alt="Velvet Sculpt Series" style="width: 100%; height: 100%; object-fit: cover;">
            </div>
        </section>

        <%
            List<Furniture> homeFurnitureList = (List<Furniture>) request.getAttribute("homeFurnitureList");
        %>

        <!-- Products -->
        <section class="products-section">
            <div class="section-header">
                <h3>Shop the Collection</h3>
                <a href="${pageContext.request.contextPath}/shop" class="view-all">View All</a>
            </div>
            <% if (homeFurnitureList != null && !homeFurnitureList.isEmpty()) { %>
            <div class="product-grid">
                <% for (Furniture furniture : homeFurnitureList) {
                    String imageUrl = ImagePathResolver.resolveImagePath(
                            application,
                            furniture.getImageUrl(),
                            furniture.getName()
                    );
                    String imageSrc = imageUrl.startsWith("http://") || imageUrl.startsWith("https://")
                            ? imageUrl
                            : request.getContextPath() + imageUrl;
                %>
                <div class="product-card">
                    <div class="product-image">
                        <img src="<%= imageSrc %>" alt="<%= furniture.getName() %>">
                    </div>
                    <div class="product-info">
                        <h4><%= furniture.getName() %></h4>
                        <p class="product-desc"><%= furniture.getDescription() %></p>
                        <div class="product-footer">
                            <span class="price">NPR <%= String.format("%.2f", furniture.getPrice()) %></span>
                            <button class="add-btn">Add to Cart</button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="product-grid">
                <div class="product-card">
                    <div class="product-info">
                        <h4>No catalog items available</h4>
                        <p class="product-desc">Please add furniture items to the catalog and refresh.</p>
                    </div>
                </div>
            </div>
            <% } %>
        </section>

        <!-- Quick Stats -->
        <section class="stats-section">
            <div class="stat-card">
                <div class="stat-icon orders">
                    <svg viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><%= request.getAttribute("orderCount") != null ? request.getAttribute("orderCount") : 0 %></span>
                    <span class="stat-label">Your Orders</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon favorites">
                    <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><%= request.getAttribute("productCount") != null ? request.getAttribute("productCount") : 0 %></span>
                    <span class="stat-label">Products</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon cart">
                    <svg viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value"><%= request.getAttribute("cartCount") != null ? request.getAttribute("cartCount") : 0 %></span>
                    <span class="stat-label">Cart Items</span>
                </div>
            </div>
        </section>
    </main>
</div>

</body>
</html>
