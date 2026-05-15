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
    <title><%= isAdminRoute ? "Admin Settings — FurniStock" : "Settings — FurniStock" %></title>
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

        .settings-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 24px;
            margin-bottom: 28px;
        }

        @media (max-width: 768px) {
            .settings-grid {
                grid-template-columns: 1fr;
            }
        }

        .settings-sidebar {
            background: var(--panel-bg);
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            overflow: hidden;
        }

        .settings-menu {
            list-style: none;
        }

        .settings-menu li {
            border-bottom: 1px solid var(--border);
        }

        .settings-menu li:last-child {
            border-bottom: none;
        }

        .settings-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 20px;
            color: var(--brown-dark);
            text-decoration: none;
            transition: background-color 0.2s ease;
            font-size: 14px;
            font-weight: 500;
        }

        .settings-menu a:hover,
        .settings-menu a.active {
            background-color: var(--gold-accent);
            color: var(--brown-dark);
        }

        .settings-menu svg {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .settings-content {
            background: var(--panel-bg);
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
            padding: 28px 32px;
        }

        .settings-section {
            margin-bottom: 28px;
        }

        .settings-section:last-child {
            margin-bottom: 0;
        }

        .settings-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: var(--brown-dark);
            margin-bottom: 16px;
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

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"],
        .form-group select,
        .form-group textarea {
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
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(184, 130, 42, 0.1);
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

        .toggle-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--border);
        }

        .toggle-group:last-child {
            border-bottom: none;
        }

        .toggle-switch {
            position: relative;
            width: 50px;
            height: 28px;
            background-color: #ccc;
            border-radius: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .toggle-switch.active {
            background-color: var(--gold);
        }

        .toggle-switch::after {
            content: '';
            position: absolute;
            top: 2px;
            left: 2px;
            width: 24px;
            height: 24px;
            background-color: white;
            border-radius: 50%;
            transition: left 0.2s ease;
        }

        .toggle-switch.active::after {
            left: 24px;
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

        .btn-secondary {
            background-color: var(--text-muted);
        }

        .btn-secondary:hover {
            background-color: var(--brown-dark);
        }

        .info-box {
            background-color: #e7f5f0;
            border-left: 4px solid #16a085;
            padding: 12px 16px;
            border-radius: 6px;
            font-size: 13px;
            color: #155838;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1><i class="bi bi-gear"></i> <%= isAdminRoute ? "Admin Settings" : "Settings" %></h1>
                <p style="color: var(--text-muted);"><%= isAdminRoute ? "Manage admin account preferences and system settings." : "Manage your account preferences and security settings." %></p>
                <% if (isAdminRoute) { %>
                    <div style="margin-top: 18px;">
                        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back to Admin Dashboard</a>
                    </div>
                <% } %>
            </div>

            <!-- Settings Grid -->
            <div class="settings-grid">
                <!-- Settings Menu -->
                <div class="settings-sidebar">
                    <ul class="settings-menu">
                        <li><a href="#account" class="active"><svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>Account</a></li>
                        <li><a href="#notifications"><svg viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>Notifications</a></li>
                        <li><a href="#privacy"><svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>Privacy</a></li>
                        <li><a href="#security"><svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>Security</a></li>
                    </ul>
                </div>

                <!-- Settings Content -->
                <div class="settings-content">
                    <!-- Account Settings -->
                    <div id="account" class="settings-section">
                        <h2>Account Information</h2>
                        <div class="info-box">
                            <i class="bi bi-info-circle"></i> Your account details are securely stored and encrypted.
                        </div>
                        <form method="POST" action="<%= request.getContextPath() + (isAdminRoute ? "/admin-settings" : "/settings") %>">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() %>" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                            </div>
                            <button type="submit" class="btn"><i class="bi bi-check-circle"></i> Save Changes</button>
                        </form>
                    </div>

                    <!-- Notification Settings -->
                    <div id="notifications" class="settings-section">
                        <h2>Notification Preferences</h2>
                        <div class="toggle-group">
                            <div>
                                <strong>Email Notifications</strong>
                                <p style="font-size: 13px; color: var(--text-muted); margin-top: 2px;">Receive updates about your orders</p>
                            </div>
                            <div class="toggle-switch active" onclick="this.classList.toggle('active')"></div>
                        </div>
                        <div class="toggle-group">
                            <div>
                                <strong>Promotional Offers</strong>
                                <p style="font-size: 13px; color: var(--text-muted); margin-top: 2px;">Get notified about sales and new collections</p>
                            </div>
                            <div class="toggle-switch" onclick="this.classList.toggle('active')"></div>
                        </div>
                        <div class="toggle-group">
                            <div>
                                <strong>Weekly Newsletter</strong>
                                <p style="font-size: 13px; color: var(--text-muted); margin-top: 2px;">Curated furniture recommendations</p>
                            </div>
                            <div class="toggle-switch" onclick="this.classList.toggle('active')"></div>
                        </div>
                    </div>

                    <!-- Privacy Settings -->
                    <div id="privacy" class="settings-section">
                        <h2>Privacy & Data</h2>
                        <div class="form-group">
                            <label>
                                <input type="checkbox" checked> Allow FurniStock to use my purchase history for recommendations
                            </label>
                        </div>
                        <div class="form-group">
                            <label>
                                <input type="checkbox" checked> Share my preferences with trusted partners
                            </label>
                        </div>
                        <button type="button" class="btn btn-secondary" style="margin-top: 16px;"><i class="bi bi-download"></i> Download My Data</button>
                    </div>

                    <!-- Security Settings -->
                    <div id="security" class="settings-section">
                        <h2>Security</h2>
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" placeholder="Enter current password">
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" placeholder="Enter new password">
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" placeholder="Confirm new password">
                        </div>
                        <button type="button" class="btn"><i class="bi bi-lock"></i> Update Password</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

</body>
</html>
