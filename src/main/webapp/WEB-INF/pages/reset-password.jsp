<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Reset Code — FurniStock</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

<%
    String resetEmail = (String) session.getAttribute("resetEmail");
    if (resetEmail == null || resetEmail.isBlank()) {
        response.sendRedirect(request.getContextPath() + "/forgot-password");
        return;
    }
%>

<div class="auth-wrapper">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/index" class="brand-logo">
            <div class="brand-icon"></div>
            <span class="brand-name">Furni<span>Stock</span></span>
        </a>
        <p class="brand-tagline">Enter the code sent to your email to continue.</p>
    </div>

    <div class="auth-card">
        <div class="card-header">
            <h1>Verify OTP Code</h1>
            <p>Enter the OTP code from your email and set a new password.</p>
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

            <% if (request.getAttribute("otpNotice") != null) { %>
                <div class="alert alert-success" style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; background: #f0f9ff; color: #0f172a; font-size: 14px;">
                    <strong>Local OTP:</strong> <%= request.getAttribute("otpNotice") %>
                </div>
            <% } %>

            <form id="resetForm" action="${pageContext.request.contextPath}/reset-password" method="post" novalidate>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,4 12,13 22,4"/></svg>
                        </span>
                        <input type="email" id="email" name="email" value="<%= resetEmail %>" readonly>
                    </div>
                </div>

                <div class="form-group">
                    <label for="code">OTP Code</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><path d="M4 4h16v16H4z"/></svg>
                        </span>
                        <input type="text" id="code" name="code" placeholder="Enter OTP code" required>
                    </div>
                    <span class="msg-error" id="codeErr"></span>
                </div>

                <div class="form-group">
                    <label for="password">New Password</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        </span>
                        <input type="password" id="password" name="password" placeholder="Enter new password" autocomplete="new-password" required>
                    </div>
                    <span class="msg-error" id="passErr"></span>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        </span>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" autocomplete="new-password" required>
                    </div>
                    <span class="msg-error" id="confirmErr"></span>
                </div>

                <button type="submit" class="btn-submit">Reset Password</button>
            </form>

            <div class="divider">or</div>

            <p class="card-footer-text">
                Didn’t receive the code?&nbsp;
                <a href="${pageContext.request.contextPath}/forgot-password">Send a new code</a>
            </p>
        </div>
    </div>
</div>

<script>
    document.getElementById('resetForm').addEventListener('submit', function(e) {
        let valid = true;

        const code = document.getElementById('code');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const codeErr = document.getElementById('codeErr');
        const passErr = document.getElementById('passErr');
        const confirmErr = document.getElementById('confirmErr');

        codeErr.textContent = '';
        passErr.textContent = '';
        confirmErr.textContent = '';

        if (!code.value.trim()) {
            codeErr.textContent = '✕  Verification code is required.';
            valid = false;
        }

        if (!password.value) {
            passErr.textContent = '✕  New password is required.';
            valid = false;
        } else if (password.value.length < 8) {
            passErr.textContent = '✕  Password must be at least 8 characters.';
            valid = false;
        }

        if (!confirmPassword.value) {
            confirmErr.textContent = '✕  Please confirm your password.';
            valid = false;
        } else if (password.value !== confirmPassword.value) {
            confirmErr.textContent = '✕  Passwords do not match.';
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
</script>

</body>
</html>
