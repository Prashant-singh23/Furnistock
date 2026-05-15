<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <style>
        .about-hero {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            padding: 160px 60px 100px;
            min-height: 90vh;
        }

        .about-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 56px;
            font-weight: 700;
            color: var(--brown-dark);
            line-height: 1.15;
            margin-bottom: 24px;
        }

        .about-hero p {
            font-size: 18px;
            color: var(--text-muted);
            margin-bottom: 20px;
            line-height: 1.8;
        }

        .about-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
            margin-top: 60px;
            padding: 60px 0;
        }

        .about-stat {
            text-align: center;
        }

        .about-stat-number {
            font-family: 'Playfair Display', serif;
            font-size: 48px;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 12px;
        }

        .about-stat-label {
            font-size: 16px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .about-mission {
            padding: 100px 60px;
            background: var(--panel-bg);
        }

        .about-mission h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 30px;
            text-align: center;
        }

        .mission-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
            margin-top: 60px;
        }

        .mission-card {
            padding: 40px 30px;
            background: white;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
        }

        .mission-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 16px;
        }

        .mission-card p {
            font-size: 16px;
            color: var(--text-muted);
            line-height: 1.7;
        }

        .about-team {
            padding: 100px 60px;
        }

        .about-team h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 60px;
            text-align: center;
        }

        @media (max-width: 1024px) {
            .about-hero {
                grid-template-columns: 1fr;
                padding: 120px 40px 80px;
            }

            .mission-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .about-hero {
                padding: 100px 20px 60px;
            }

            .about-hero h1 {
                font-size: 40px;
            }

            .about-mission {
                padding: 60px 20px;
            }

            .mission-grid {
                grid-template-columns: 1fr;
            }

            .about-stats {
                grid-template-columns: 1fr;
            }
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
            <a href="${pageContext.request.contextPath}/index">Home</a>
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
        </div>
    </nav>

    <section class="about-hero">
        <div class="about-content">
            <h1>Our Story</h1>
            <p>Founded in 2020, FurniStock emerged from a simple vision: to make premium, artisan-crafted furniture accessible to everyone. What started as a small workshop has blossomed into a thriving community of designers, craftspeople, and furniture enthusiasts.</p>
            <p>We believe that furniture is more than just functional—it's a reflection of your personality and lifestyle. Every piece we curate tells a story and is crafted with meticulous attention to detail.</p>
            <p>Our mission is to connect you with furniture that transforms houses into homes, combining timeless design with sustainable craftsmanship.</p>
        </div>
        <div class="about-stats">
            <div class="about-stat">
                <div class="about-stat-number">15K+</div>
                <div class="about-stat-label">Happy Customers</div>
            </div>
            <div class="about-stat">
                <div class="about-stat-number">75+</div>
                <div class="about-stat-label">Partner Artisans</div>
            </div>
            <div class="about-stat">
                <div class="about-stat-number">500+</div>
                <div class="about-stat-label">Unique Designs</div>
            </div>
        </div>
    </section>

    <section class="about-mission">
        <div class="container">
            <h2>Our Values</h2>
            <div class="mission-grid">
                <div class="mission-card">
                    <h3>Quality Craftsmanship</h3>
                    <p>We partner only with artisans who share our commitment to excellence. Every piece is inspected and tested to ensure it meets our rigorous standards.</p>
                </div>
                <div class="mission-card">
                    <h3>Sustainable Design</h3>
                    <p>We prioritize eco-friendly materials and ethical production practices. Our furniture is built to last generations, reducing waste and environmental impact.</p>
                </div>
                <div class="mission-card">
                    <h3>Customer First</h3>
                    <p>Your satisfaction is our priority. We offer hassle-free returns, lifetime warranties, and dedicated support to ensure your complete happiness.</p>
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
                    <p>Handcrafted furniture made with the finest materials.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                    </div>
                    <h3>Expert Design</h3>
                    <p>Curated by industry experts and designers.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                        </svg>
                    </div>
                    <h3>Fast Shipping</h3>
                    <p>Quick delivery with white-glove service.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg viewBox="0 0 24 24">
                            <path d="M12 1l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                    </div>
                    <h3>Lifetime Support</h3>
                    <p>Comprehensive warranty and dedicated support.</p>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <div class="brand-icon"></div>
                    <span class="brand-name">Furni<span>Stock</span></span>
                    <p>Your trusted partner in creating beautiful, functional living spaces.</p>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <a href="${pageContext.request.contextPath}/index">Home</a>
                    <a href="${pageContext.request.contextPath}/about">About</a>
                    <a href="${pageContext.request.contextPath}/contact">Contact</a>
                </div>
                <div class="footer-links">
                    <h4>Support</h4>
                    <a href="#">Shipping Info</a>
                    <a href="#">Returns</a>
                    <a href="#">Warranty</a>
                </div>
                <div class="footer-contact">
                    <h4>Contact</h4>
                    <p><i class="bi bi-telephone"></i> +977 9810613909</p>
                    <p><i class="bi bi-geo-alt"></i> Saadobaato, Lalitpur</p>
                    <p><i class="bi bi-envelope"></i> info@furnistock.com</p>
                    <div class="social-links">
                        <a href="#">FB</a>
                        <a href="#">IG</a>
                        <a href="#">TW</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 FurniStock. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
