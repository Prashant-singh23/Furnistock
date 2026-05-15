<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FurniStock - Premium Furniture</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
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
   </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </div>
        <div class="nav-links">
            <a href="#collection">Collection</a>
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
        </div>
        <div class="nav-auth">
            <a href="${pageContext.request.contextPath}/admin-login" class="btn-login" style="background-color: var(--gold);">Admin</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Sign In</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-register">Get Started</a>
        </div>
    </nav>

    <section class="hero">
        <div class="hero-content">
            <span class="hero-tag">Premium Furniture Destination</span>
            <h1>Craft Your Perfect<br>Living Space</h1>
            <p>Discover curated collections of artisan-crafted furniture that transforms houses into homes.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn-primary">Explore Collection</a>
                <a href="#collection" class="btn-secondary">Browse Products</a>
            </div>
        </div>
        <div class="hero-visual">
            <div class="hero-image-stack">
                <div class="hero-image-container hero-image-primary">
                    <img class="hero-image" src="${pageContext.request.contextPath}/images/furnistock-2.webp">
                </div>
            </div>
        </div>
    </section>

    <section class="collection" id="collection">
        <div class="container">
            <div class="section-header">
                <span class="section-tag">Featured Collection</span>
                <h2>Trending Pieces</h2>
                <p>Explore our most popular furniture selections loved by customers</p>
            </div>
            <div class="collection-grid">
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/modern-lounge-collection.jpg" alt="Modern Sofa">
                    <div class="collection-info">
                        <span class="collection-category">Living Room</span>
                        <h3>Modern Lounge Collection</h3>
                    </div>
                </div>
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/monument-coffee-table.jpg" alt="Coffee Table">
                    <div class="collection-info">
                        <span class="collection-category">Tables</span>
                        <h3>Monument Coffee Table</h3>
                    </div>
                </div>
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/walnut-credenza.jpg" alt="Credenza">
                    <div class="collection-info">
                        <span class="collection-category">Storage</span>
                        <h3>Walnut Credenza</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                        </svg>
                    </div>
                    <h3>Premium Quality</h3>
                    <p>Handcrafted furniture made with the finest materials and attention to detail.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                    </div>
                    <h3>Expert Craftsmanship</h3>
                    <p>Skilled artisans bring decades of experience to every piece we create.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                        </svg>
                    </div>
                    <h3>Fast Delivery</h3>
                    <p>Quick and secure delivery to your doorstep with white-glove service.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 1l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                    </div>
                    <h3>Lifetime Warranty</h3>
                    <p>Comprehensive warranty coverage ensuring your investment is protected.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="cta">
        <div class="container">
            <div class="cta-content">
                <h2>Ready to Transform Your Space?</h2>
                <p>Join thousands of satisfied customers who have found their perfect furniture pieces with FurniStock.</p>
                <a href="${pageContext.request.contextPath}/register" class="btn-cta">Start Shopping Today</a>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <div class="brand-icon"></div>
                    <span class="brand-name">Furni<span>Stock</span></span>
                    <p>Your trusted partner in creating beautiful, functional living spaces. We curate the finest furniture collections from around the world.</p>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <a href="${pageContext.request.contextPath}/about">About Us</a>
                    <a href="#collection">Our Collection</a>
                    <a href="${pageContext.request.contextPath}/contact">Contact</a>
                    <a href="${pageContext.request.contextPath}/user-shop">Shop</a>
                </div>
                <div class="footer-links">
                    <h4>Customer Service</h4>
                    <a href="#">Shipping Info</a>
                    <a href="#">Returns & Exchanges</a>
                    <a href="#">Warranty</a>
                    <a href="#">FAQ</a>
                </div>
                <div class="footer-contact">
                    <h4>Contact Us</h4>
                    <p>📍 Saadobaato, Lalitpur</p>
                    <p><i class="bi bi-telephone"></i> +977 9810613909</p>
                    <p><i class="bi bi-envelope"></i> info@furnistock.com</p>
                    <div class="social-links">
                        <a href="#">FB</a>
                        <a href="#">IG</a>
                        <a href="#">TW</a>
                        <a href="#">LI</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 FurniStock. All rights reserved. | Privacy Policy | Terms of Service</p>
            </div>
        </div>
    </footer>
</body>
</html>
