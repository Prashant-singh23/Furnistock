<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login — FurniStock</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
    <style>
        .admin-badge {
            display: inline-block;
            background-color: #e74c3c;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        .card-header.admin {
            border-bottom: 3px solid #e74c3c;
        }
    </style>
</head>
<body>

<div class="auth-wrapper">

    <!-- ── Brand ── -->
    <div class="brand">
        <a href="index.jsp" class="brand-logo">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </a>
        <p class="brand-tagline">Premium Furniture Destination</p>
    </div>

    <!-- ── Card ── -->
    <div class="auth-card">

        <!-- Header -->
        <div class="card-header admin">
            <span class="admin-badge">Admin Panel</span>
            <h1>Admin Login</h1>
            <p>Access your admin dashboard</p>
        </div>

        <!-- Body -->
        <div class="card-body">

            <!-- Error Message -->
            <% if (request.getAttribute("error") != null) { %>
                <div style="background-color: #fee; color: #c33; padding: 12px; border-radius: 6px; margin-bottom: 16px; font-size: 14px;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Admin Login Form -->
            <form id="adminLoginForm" action="admin-login" method="post" novalidate>

                <!-- Username -->
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        </span>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Enter admin username"
                            autocomplete="username"
                            required>
                    </div>
                    <span class="msg-error" id="usernameErr"></span>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        </span>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required>
                        <button type="button" class="toggle-pass" onclick="togglePass('password', this)" aria-label="Show/hide password">
                            <svg id="eyeIcon" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                    <span class="msg-error" id="passErr"></span>
                </div>

                <!-- Credentials Info -->
                <div style="background-color: #f5f5f5; padding: 12px; border-radius: 6px; margin-bottom: 20px; font-size: 12px; border-left: 3px solid #e74c3c;">
                    <strong>Demo Credentials:</strong><br>
                    Username: <code>admin</code><br>
                    Password: <code>Admin@123</code>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn-submit">Admin Login</button>

            </form>

            <div class="divider">or</div>

            <!-- Back to Login -->
            <div style="text-align: center; margin-top: 16px;">
                <a href="${pageContext.request.contextPath}/login" style="color: #666; text-decoration: none; font-size: 14px;">
                    ← Back to User Login
                </a>
            </div>

        </div>

    </div>

</div>

<script>
    function togglePass(fieldId, btn) {
        const field = document.getElementById(fieldId);
        const isPassword = field.type === 'password';
        field.type = isPassword ? 'text' : 'password';
        btn.classList.toggle('visible', !isPassword);
    }
</script>

</body>
</html>
