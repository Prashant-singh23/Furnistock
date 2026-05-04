<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is already logged in
    Object user = session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FurniStock — Premium Furniture</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-brand">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </div>
        <div class="nav-links">
            <a href="#collection">Collection</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </div>
        <div class="nav-auth">
            <a href="${pageContext.request.contextPath}/admin-login" class="btn-login" style="background-color: #e74c3c;">Admin</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Sign In</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-register">Get Started</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <span class="hero-tag">Premium Furniture Destination</span>
            <h1>Craft Your Perfect<br>Living Space</h1>
            <p>Discover curated collections of artisan-crafted furniture that transforms houses into homes. Quality meets elegance in every piece.</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn-primary">Explore Collection</a>
                <a href="#about" class="btn-secondary">Learn More</a>
            </div>
            <div class="hero-stats">
                <div class="stat">
                    <span class="stat-number">10K+</span>
                    <span class="stat-text">Happy Customers</span>
                </div>
                <div class="stat">
                    <span class="stat-number">500+</span>
                    <span class="stat-text">Unique Designs</span>
                </div>
                <div class="stat">
                    <span class="stat-number">50+</span>
                    <span class="stat-text">Artisan Partners</span>
                </div>
            </div>
        </div>
        <div class="hero-visual">
            <div class="hero-image-container">
                <img src="${pageContext.request.contextPath}/images/image1.jfif" alt="Premium Furniture" class="hero-image">
                <div class="floating-card card-1">
                    <span class="card-icon">✓</span>
                    <div>
                        <strong>Free Shipping</strong>
                        <p>On orders over $500</p>
                    </div>
                </div>
                <div class="floating-card card-2">
                    <span class="card-icon">★</span>
                    <div>
                        <strong>4.9 Rating</strong>
                        <p>Customer satisfaction</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path></svg>
                    </div>
                    <h3>Premium Quality</h3>
                    <p>Hand-crafted furniture made from the finest materials for lasting durability.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    </div>
                    <h3>Fast Delivery</h3>
                    <p>Quick and reliable shipping with careful handling of all furniture pieces.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    </div>
                    <h3>Secure Shopping</h3>
                    <p>Safe and secure checkout process with encrypted payment processing.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                    </div>
                    <h3>24/7 Support</h3>
                    <p>Dedicated customer support team ready to assist you at any time.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Collection Preview -->
    <section class="collection" id="collection">
        <div class="container">
            <div class="section-header">
                <span class="section-tag">Featured Collection</span>
                <h2>Trending Pieces</h2>
                <p>Explore our most popular furniture selections loved by customers</p>
            </div>
            <div class="collection-grid">
                <div class="collection-card large">
                    <img src="${pageContext.request.contextPath}/images/image2.jpg" alt="Modern Sofa">
                    <div class="collection-info">
                        <span class="collection-category">Living Room</span>
                        <h3>Modern Lounge Collection</h3>
                        <p>Starting from $1,240</p>
                    </div>
                </div>
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/table.png" alt="Coffee Table">
                    <div class="collection-info">
                        <span class="collection-category">Tables</span>
                        <h3>Monument Coffee Table</h3>
                        <p>$890</p>
                    </div>
                </div>
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/credenza.png" alt="Credenza">
                    <div class="collection-info">
                        <span class="collection-category">Storage</span>
                        <h3>Walnut Credenza</h3>
                        <p>$2,100</p>
                    </div>
                </div>
                <div class="collection-card">
                    <img src="${pageContext.request.contextPath}/images/pendant.png" alt="Pendant Light">
                    <div class="collection-info">
                        <span class="collection-category">Lighting</span>
                        <h3>Glass Pendant</h3>
                        <p>$340</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <div class="cta-content">
                <h2>Ready to Transform Your Home?</h2>
                <p>Join thousands of satisfied customers who have found their perfect furniture pieces.</p>
                <a href="${pageContext.request.contextPath}/register" class="btn-cta">Create Free Account</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <div class="nav-brand">
                        <div class="brand-icon"></div>
                        <span class="brand-name">Furni<span>Stock</span></span>
                    </div>
                    <p>Premium furniture for modern living. Crafting beautiful spaces since 2020.</p>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <a href="#">Catalog</a>
                    <a href="#">About Us</a>
                    <a href="#">Contact</a>
                    <a href="#">FAQ</a>
                </div>
                <div class="footer-links">
                    <h4>Legal</h4>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                </div>
                <div class="footer-contact">
                    <h4>Contact Us</h4>
                    <p>hello@furnistock.com</p>
                    <p>+1 (555) 123-4567</p>
                    <div class="social-links">
                        <a href="#">FB</a>
                        <a href="#">IG</a>
                        <a href="#">TW</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 FurniStock. All rights reserved.</p>
            </div>
        </div>
    </footer>

</body>
</html>