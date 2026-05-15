<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    boolean isAdmin = "admin".equals(user.getRole());
    boolean isAdminRoute = request.getServletPath().startsWith("/admin");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support — FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600&display=swap');
        
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
            font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg);
            font-size: 15px;
            line-height: 1.6;
            letter-spacing: 0.01em;
        }

        .container {
            max-width: 1020px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        .header {
            background: var(--panel-bg);
            padding: 28px 32px;
            border-radius: 12px;
            margin-bottom: 28px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            border-left: 4px solid var(--gold);
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: 0.01em;
            line-height: 1.3;
        }

        .header p {
            font-size: 14px;
            letter-spacing: 0.02em;
            color: var(--text-muted);
        }

        .support-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 28px;
        }

        .support-card {
            background: var(--panel-bg);
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            border-top: 3px solid var(--gold);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .support-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .support-card-icon {
            font-size: 40px;
            color: var(--gold);
            margin-bottom: 16px;
        }

        .support-card-title {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 8px;
        }

        .support-card-desc {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.6;
            margin-bottom: 16px;
        }

        .support-card-link {
            color: var(--gold);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s ease;
        }

        .support-card-link:hover {
            color: var(--gold-light);
        }

        .faq-section {
            background: var(--panel-bg);
            padding: 28px 32px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
        }

        .faq-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--border);
            padding-bottom: 12px;
        }

        .faq-item {
            margin-bottom: 16px;
        }

        .faq-question {
            background: var(--bg);
            padding: 14px 16px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.2s ease;
            font-weight: 600;
            color: var(--brown-dark);
        }

        .faq-question:hover {
            background-color: var(--gold-accent);
        }

        .faq-question svg {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
            transition: transform 0.2s ease;
        }

        .faq-question.active svg {
            transform: rotate(180deg);
        }

        .faq-answer {
            display: none;
            padding: 14px 16px;
            background: var(--bg);
            border-left: 3px solid var(--gold);
            margin-top: 4px;
            border-radius: 0 8px 8px 0;
            color: var(--text-muted);
            line-height: 1.7;
        }

        .faq-answer.active {
            display: block;
        }

        .contact-form {
            background: var(--panel-bg);
            padding: 28px 32px;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
        }

        .contact-form h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--border);
            padding-bottom: 12px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: var(--brown-dark);
            margin-bottom: 6px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            color: var(--brown-dark);
            transition: border-color 0.2s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(184, 130, 42, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }

        .btn {
            padding: 11px 26px;
            background-color: var(--gold);
            color: var(--panel-bg);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 0.03em;
            transition: background-color 0.2s ease;
        }

        .btn:hover {
            background-color: var(--gold-light);
        }
    </style>
</head>
<body>

<div class="home-container">
    <jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1><i class="bi bi-chat-left-quote"></i> Support Center</h1>
                <p style="color: var(--text-muted);">We're here to help. Find answers or contact us</p>
            </div>

            <!-- Support Cards -->
            <div class="support-grid">
                <div class="support-card">
                    <div class="support-card-icon"><i class="bi bi-telephone"></i></div>
                    <div class="support-card-title">Phone Support</div>
                    <div class="support-card-desc">Call our customer service team available Monday-Friday, 9AM-6PM</div>
                    <a href="tel:+977-1-4500000" class="support-card-link">+977-1-4500000 →</a>
                </div>

                <div class="support-card">
                    <div class="support-card-icon"><i class="bi bi-envelope"></i></div>
                    <div class="support-card-title">Email Support</div>
                    <div class="support-card-desc">Send us an email and we'll respond within 24 hours</div>
                    <a href="mailto:support@furnistock.com" class="support-card-link">support@furnistock.com →</a>
                </div>

                <div class="support-card">
                    <div class="support-card-icon"><i class="bi bi-chat-dots"></i></div>
                    <div class="support-card-title">Live Chat</div>
                    <div class="support-card-desc">Chat with our support team in real-time</div>
                    <a href="#chat" class="support-card-link">Start Chat →</a>
                </div>
            </div>

            <!-- FAQ Section -->
            <div class="faq-section">
                <h2><i class="bi bi-question-circle"></i> Frequently Asked Questions</h2>
                
                <div class="faq-item">
                    <div class="faq-question" onclick="this.classList.toggle('active'); this.nextElementSibling.classList.toggle('active');">
                        <span>How do I track my order?</span>
                        <svg viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </div>
                    <div class="faq-answer">
                        You can track your order from the "My Orders" section in your dashboard. We'll also send you email updates with tracking information at each stage of delivery.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question" onclick="this.classList.toggle('active'); this.nextElementSibling.classList.toggle('active');">
                        <span>What is your return policy?</span>
                        <svg viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </div>
                    <div class="faq-answer">
                        We offer a 30-day return policy on most items. If you're not satisfied with your purchase, contact us and we'll arrange for a return or exchange at no additional cost.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question" onclick="this.classList.toggle('active'); this.nextElementSibling.classList.toggle('active');">
                        <span>Do you offer international shipping?</span>
                        <svg viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </div>
                    <div class="faq-answer">
                        Currently, we deliver within Nepal. We're working on expanding internationally and will announce our expansion soon. Stay tuned for updates!
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question" onclick="this.classList.toggle('active'); this.nextElementSibling.classList.toggle('active');">
                        <span>How long does delivery take?</span>
                        <svg viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </div>
                    <div class="faq-answer">
                        Standard delivery typically takes 3-5 business days within Kathmandu Valley. For areas outside the valley, delivery may take 5-7 business days. Express delivery options are also available.
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question" onclick="this.classList.toggle('active'); this.nextElementSibling.classList.toggle('active');">
                        <span>What payment methods do you accept?</span>
                        <svg viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </div>
                    <div class="faq-answer">
                        We accept credit/debit cards (Visa, MasterCard), online banking, and cash on delivery. All transactions are secure and encrypted.
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="contact-form">
                <h2><i class="bi bi-envelope-open"></i> Send us a Message</h2>
                <form method="POST" action="${pageContext.request.contextPath}/support">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="<%= user.getFirstName() %> <%= user.getLastName() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <select id="subject" name="subject" required>
                            <option value="">Select a subject</option>
                            <option value="order">Order Issue</option>
                            <option value="delivery">Delivery Problem</option>
                            <option value="product">Product Quality</option>
                            <option value="payment">Payment Issue</option>
                            <option value="return">Return/Exchange</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" placeholder="Please describe your issue in detail..." required></textarea>
                    </div>
                    <button type="submit" class="btn"><i class="bi bi-send"></i> Send Message</button>
                </form>
            </div>
        </div>
    </main>
</div>

</body>
</html>
