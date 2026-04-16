<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FurniStock Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<div class="container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <h2 class="logo">FurniStock</h2>
        
        <ul class="menu">
            <li class="active">Catalog</li>
            <li>New Arrivals</li>
            <li>Best Sellers</li>
            <li>My Orders</li>
            <li>Favorites</li>
            <li>Settings</li>
        </ul>

        <button class="track-btn">Track Delivery</button>

        <div class="bottom-links">
            <p class="highlight">Support</p>
            <p class="highlight">Logout</p>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main">
        <header class="header">
            <h1>Morning, Julian.</h1>
            <input type="text" placeholder="Search furniture..." class="search">
        </header>

        <!-- Banner -->
        <section class="banner">
            <span class="tag">NEW ARRIVAL</span>
            <h2>The Velvet Sculpt Series</h2>
            <p>Artisan-crafted textures meet structural ergonomics.</p>
            <button class="explore-btn">Explore Collection</button>
        </section>

        <!-- Products -->
        <section class="products">
            <h3>Shop the Collection</h3>
            
            <div class="product-grid">
                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/chair.png" alt="Oslo Mid-Century Lounge">
                    <h4>Oslo Mid-Century Lounge</h4>
                    <p class="price">$1,240</p>
                    <button class="add-btn">Add to Cart</button>
                </div>

                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/table.png" alt="Monument Coffee Table">
                    <h4>Monument Coffee Table</h4>
                    <p class="price">$890</p>
                    <button class="add-btn">Add to Cart</button>
                </div>

                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/credenza.png" alt="Fluted Walnut Credenza">
                    <h4>Fluted Walnut Credenza</h4>
                    <p class="price">$2,100</p>
                    <button class="add-btn">Add to Cart</button>
                </div>

                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/pendant.png" alt="Eclipse Glass Pendant">
                    <h4>Eclipse Glass Pendant</h4>
                    <p class="price">$345</p>
                    <button class="add-btn">Add to Cart</button>
                </div>

                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/sofa.png" alt="Velvet Sculpt Sofa">
                    <h4>Velvet Sculpt Sofa</h4>
                    <p class="price">$1,850</p>
                    <button class="add-btn">Add to Cart</button>
                </div>

                <div class="card">
                    <img src="${pageContext.request.contextPath}/images/dining.png" alt="Oslo Dining Set">
                    <h4>Oslo Dining Set</h4>
                    <p class="price">$2,450</p>
                    <button class="add-btn">Add to Cart</button>
                </div>
            </div>
        </section>

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