<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password — FurniStock</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/index" class="brand-logo">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </a>
        <p class="brand-tagline">Enter your email to receive a verification code.</p>
    </div>

    <div class="auth-card">
        <div class="card-header">
            <h1>Forgot Password</h1>
            <p>We will send an OTP code to your Gmail address to reset your password.</p>
        </div>

        <div class="card-body">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error" style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; background: #fee2e2; color: #991b1b; font-size: 14px;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <% if (request.getAttribute("info") != null) { %>
                <div class="alert alert-success" style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; background: #dcfce7; color: #166534; font-size: 14px;">
                    <%= request.getAttribute("info") %>
                </div>
            <% } %>

            <form id="forgotForm" action="${pageContext.request.contextPath}/forgot-password" method="post" novalidate>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,4 12,13 22,4"/></svg>
                        </span>
                        <input type="email" id="email" name="email" placeholder="you@example.com" autocomplete="email" required>
                    </div>
                    <span class="msg-error" id="emailErr"></span>
                </div>

                <button type="submit" class="btn-submit">Send Reset Code</button>
            </form>

            <div class="divider">or</div>

            <p class="card-footer-text">
                Remembered your password?&nbsp;
                <a href="${pageContext.request.contextPath}/login">Sign in instead</a>
            </p>
        </div>
    </div>
</div>

<script>
    document.getElementById('forgotForm').addEventListener('submit', function(e) {
        let valid = true;

        const email = document.getElementById('email');
        const emailErr = document.getElementById('emailErr');

        emailErr.textContent = '';

        const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email.value.trim()) {
            emailErr.textContent = '✕  Email address is required.';
            valid = false;
        } else if (!emailRx.test(email.value.trim())) {
            emailErr.textContent = '✕  Please enter a valid email address.';
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
</script>

</body>
</html>
