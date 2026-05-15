<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <style>
        .contact-hero {
            padding: 160px 60px 100px;
            text-align: center;
            min-height: 60vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .contact-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 56px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 24px;
        }

        .contact-hero p {
            font-size: 18px;
            color: var(--text-muted);
            max-width: 600px;
            margin: 0 auto 60px;
            line-height: 1.8;
        }

        .contact-section {
            padding: 80px 60px;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
            margin-bottom: 80px;
        }

        .contact-card {
            padding: 50px 40px;
            background: var(--panel-bg);
            border-radius: 16px;
            text-align: center;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .contact-card:hover {
            box-shadow: var(--shadow-sm);
            transform: translateY(-4px);
        }

        .contact-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .contact-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 12px;
        }

        .contact-card p {
            font-size: 16px;
            color: var(--text-muted);
            line-height: 1.7;
        }

        .contact-card a {
            display: inline-block;
            margin-top: 16px;
            color: var(--gold);
            font-weight: 600;
            transition: color 0.25s ease;
        }

        .contact-card a:hover {
            color: var(--gold-light);
        }

        .contact-form-section {
            background: var(--panel-bg);
            padding: 80px 60px;
            border-radius: 20px;
            margin-top: 80px;
        }

        .contact-form-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 50px;
            text-align: center;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: 'Jost', sans-serif;
            font-size: 16px;
            color: var(--text);
            transition: border-color 0.25s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--gold);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }

        .form-submit {
            width: 100%;
            padding: 16px 32px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            background: var(--gold);
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .form-submit:hover {
            background: var(--gold-light);
            transform: translateY(-2px);
        }

        .faq-section {
            padding: 100px 60px;
        }

        .faq-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 700;
            color: var(--brown-dark);
            margin-bottom: 60px;
            text-align: center;
        }

        .faq-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
            max-width: 900px;
            margin: 0 auto;
        }

        .faq-item {
            padding: 30px;
            background: var(--panel-bg);
            border-radius: 12px;
            border-left: 4px solid var(--gold);
        }

        .faq-item h4 {
            font-size: 18px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 12px;
        }

        .faq-item p {
            font-size: 15px;
            color: var(--text-muted);
            line-height: 1.7;
        }

        @media (max-width: 1024px) {
            .contact-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .faq-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .contact-hero {
                padding: 100px 20px 60px;
            }

            .contact-hero h1 {
                font-size: 40px;
            }

            .contact-section {
                padding: 60px 20px;
            }

            .contact-grid {
                grid-template-columns: 1fr;
            }

            .contact-form-section {
                padding: 60px 20px;
            }

            .faq-section {
                padding: 60px 20px;
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

    <section class="contact-hero">
        <h1>Get in Touch</h1>
        <p>Have questions about our furniture or need assistance? We'd love to hear from you. Our team is here to help!</p>
    </section>

    <section class="contact-section">
        <div class="container">
            <div class="contact-grid">
                <div class="contact-card">
                    <div class="contact-icon"><i class="bi bi-telephone"></i></div>
                    <h3>Call Us</h3>
                    <p>Reach us by phone during business hours</p>
                    <a href="tel:+15551234567">+977 9810613909</a>
                </div>
                <div class="contact-card">
                    <div class="contact-icon"><i class="bi bi-envelope"></i></div>
                    <h3>Email Us</h3>
                    <p>Send us an email and we'll respond within 24 hours</p>
                    <a href="mailto:support@furnistock.com">support@furnistock.com</a>
                </div>
                <div class="contact-card">
                    <div class="contact-icon"><i class="bi bi-geo-alt"></i></div>
                    <h3>Visit Us</h3>
                    <p>Stop by our showroom and see our collection</p>
                    <p style="color: var(--text-muted); font-size: 14px; margin-top: 12px;">Furnistock<br>Saadobaato, Lalitpur</p>
                </div>
            </div>
        </div>
    </section>

    <section class="contact-form-section">
        <div class="container">
            <h2>Send us a Message</h2>
            <div class="form-container">
                <form method="POST" action="#">
                    <div class="form-group">
                        <label for="name">Full Name *</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone">
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject *</label>
                        <input type="text" id="subject" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message *</label>
                        <textarea id="message" name="message" required></textarea>
                    </div>
                    <button type="submit" class="form-submit">Send Message</button>
                </form>
            </div>
        </div>
    </section>

    <section class="faq-section">
        <div class="container">
            <h2>Frequently Asked Questions</h2>
            <div class="faq-grid">
                <div class="faq-item">
                    <h4>What is your return policy?</h4>
                    <p>We offer 30-day returns on all furniture. If you're not completely satisfied, contact us for a hassle-free return process.</p>
                </div>
                <div class="faq-item">
                    <h4>How long does shipping take?</h4>
                    <p>Standard delivery is 5-7 business days. Expedited shipping options are available at checkout.</p>
                </div>
                <div class="faq-item">
                    <h4>Do you offer international shipping?</h4>
                    <p>Currently, we ship within the continental United States. Contact us for information about international delivery.</p>
                </div>
                <div class="faq-item">
                    <h4>What warranty do you provide?</h4>
                    <p>All FurniStock furniture comes with a lifetime structural warranty covering manufacturing defects.</p>
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
                    <p>📞 +977 9810613909</p>
                    <p>📍 Saadobaato, Lalitpur</p>
                    <p>✉️ info@furnistock.com</p>
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
