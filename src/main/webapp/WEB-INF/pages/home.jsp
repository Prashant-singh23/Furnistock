<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Home — FurniStock</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<div class="home-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </div>
        
        <nav class="sidebar-nav">
            <a href="#" class="nav-item active">
                <svg viewBox="0 0 24 24"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                <span>Dashboard</span>
            </a>
            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                <span>Catalog</span>
            </a>
            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                <span>New Arrivals</span>
            </a>
            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                <span>My Orders</span>
            </a>
            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
                <span>Favorites</span>
            </a>
            <a href="#" class="nav-item">
                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                <span>Settings</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                <svg viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
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
                <button class="explore-btn">Explore Collection</button>
            </div>
            <div class="banner-decoration"></div>
        </section>

        <!-- Products -->
        <section class="products-section">
            <div class="section-header">
                <h3>Shop the Collection</h3>
                <a href="#" class="view-all">View All</a>
            </div>
            
            <div class="product-grid">
                <!-- Product 1 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/images/image2.jpg" alt="Oslo Mid-Century Lounge">
                    </div>
                    <div class="product-info">
                        <h4>Oslo Mid-Century Lounge</h4>
                        <p class="product-desc">Premium comfort with Scandinavian design</p>
                        <div class="product-footer">
                            <span class="price">$1,240</span>
                            <button class="add-btn">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/images/table.png" alt="Monument Coffee Table">
                    </div>
                    <div class="product-info">
                        <h4>Monument Coffee Table</h4>
                        <p class="product-desc">Minimalist design with solid oak</p>
                        <div class="product-footer">
                            <span class="price">$890</span>
                            <button class="add-btn">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/images/credenza.png" alt="Fluted Walnut Credenza">
                    </div>
                    <div class="product-info">
                        <h4>Fluted Walnut Credenza</h4>
                        <p class="product-desc">Hand-crafted storage solution</p>
                        <div class="product-footer">
                            <span class="price">$2,100</span>
                            <button class="add-btn">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/images/pendant.png" alt="Eclipse Glass Pendant">
                    </div>
                    <div class="product-info">
                        <h4>Eclipse Glass Pendant</h4>
                        <p class="product-desc">Modern lighting with ambient glow</p>
                        <div class="product-footer">
                            <span class="price">$340</span>
                            <button class="add-btn">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Quick Stats -->
        <section class="stats-section">
            <div class="stat-card">
                <div class="stat-icon orders">
                    <svg viewBox="0 0 24 24"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value">12</span>
                    <span class="stat-label">Total Orders</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon favorites">
                    <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value">8</span>
                    <span class="stat-label">Favorites</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon cart">
                    <svg viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </div>
                <div class="stat-info">
                    <span class="stat-value">3</span>
                    <span class="stat-label">Cart Items</span>
                </div>
            </div>
        </section>
    </main>
</div>

</body>
</html>
        <h4>Eclipse Glass Pendant</h4>
        <p class="price">$345</p>
        <button class="add-btn">Add to Cart</button>
    </div>

    <!-- Product 5 -->
    <div class="card">
        <img src="${pageContext.request.contextPath}/images/sofa.png" alt="Velvet Sculpt Sofa">
        <h4>Velvet Sculpt Sofa</h4>
        <p class="price">$1,850</p>
        <button class="add-btn">Add to Cart</button>
    </div>

    <!-- Product 6 -->
    <div class="card">
        <img src="${pageContext.request.contextPath}/images/dining.png" alt="Oslo Dining Set">
        <h4>Oslo Dining Set</h4>
        <p class="price">$2,450</p>
        <button class="add-btn">Add to Cart</button>
    </div>
</div>
        <!-- Features -->
        <section class="features">
            <div>White Glove Delivery</div>
            <div>10 Year Warranty</div>
            <div>Sustainably Sourced</div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-column">
                    <h4>FurniStock</h4>
                    <p>Your trusted partner for modern furniture inventory management.</p>
                </div>
                <div class="footer-column">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#">Catalog</a></li>
                        <li><a href="#">New Arrivals</a></li>
                        <li><a href="#">Best Sellers</a></li>
                        <li><a href="#">My Orders</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Company</h4>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Support</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Legal</h4>
                    <ul>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Return Policy</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Follow Us</h4>
                    <div class="social-icons">
                        <a href="#">📘</a>
                        <a href="#">🐦</a>
                        <a href="#">📷</a>
                        <a href="#">▶️</a>
                    </div>
                    <p class="newsletter">Subscribe to our newsletter</p>
                    <input type="email" placeholder="Your email" class="newsletter-input">
                    <button class="subscribe-btn">Subscribe</button>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 FurniStock. All Rights Reserved. | Designed for efficient furniture retail operations.</p>
            </div>
        </footer>
    </main>
</div>

</body>
</html>