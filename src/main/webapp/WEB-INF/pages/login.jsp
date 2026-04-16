<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — FurniStock</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
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
        <div class="card-header">
            <h1>Welcome Back</h1>
            <p>Sign in to explore our curated collections</p>
        </div>

        <!-- Body -->
        <div class="card-body">

           

            <!-- Login Form -->
            <form id="loginForm" action="login" method="post" novalidate>

                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,4 12,13 22,4"/></svg>
                        </span>
                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="you@example.com"
                            autocomplete="email"
                            required>
                    </div>
                    <span class="msg-error" id="emailErr"></span>
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

                <!-- Remember me + Forgot -->
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:22px; margin-top:-8px;">
                    <div class="check-group" style="margin-bottom:0;">
                        <input type="checkbox" id="remember" name="remember" value="true">
                        <label for="remember" style="margin-bottom:0; font-size:12.5px;">Remember me</label>
                    </div>
                    <a href="ForgotPassword.jsp" class="forgot-link" style="margin:0;">Forgot password?</a>
                </div>

                <!-- Hidden CSRF token (implement on server side) -->
                <input type="hidden" name="csrf_token" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>">

                <!-- Submit -->
                <button type="submit" class="btn-submit">Sign In</button>

            </form>

            <div class="divider">or</div>

            <!-- Footer -->
            <p class="card-footer-text">
                Don't have an account?&nbsp;
                <a href="Register">Create one — it's free</a>
            </p>

        </div>
        <!-- /card-body -->

    </div>
    <!-- /auth-card -->

    <!-- Trust badges -->
    <div class="features">
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
            Secure Login
        </span>
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            Quick Access
        </span>
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            Trusted Since 2018
        </span>
    </div>

</div>
<!-- /auth-wrapper -->

<script>
/* ── Toggle password visibility ── */
function togglePass(fieldId, btn) {
    const input = document.getElementById(fieldId);
    const isText = input.type === 'text';
    input.type = isText ? 'password' : 'text';
    btn.innerHTML = isText
        ? `<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>`
        : `<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/></svg>`;
}

/* ── Client-side validation ── */
document.getElementById('loginForm').addEventListener('submit', function(e) {
    let valid = true;

    const email    = document.getElementById('email');
    const password = document.getElementById('password');
    const emailErr = document.getElementById('emailErr');
    const passErr  = document.getElementById('passErr');

    emailErr.textContent = '';
    passErr.textContent  = '';

    /* Email */
    const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.value.trim()) {
        emailErr.textContent = '✕  Email address is required.';
        valid = false;
    } else if (!emailRx.test(email.value.trim())) {
        emailErr.textContent = '✕  Please enter a valid email address.';
        valid = false;
    }

    /* Password */
    if (!password.value) {
        passErr.textContent = '✕  Password is required.';
        valid = false;
    }

    if (!valid) e.preventDefault();
});
</script>

</body>
</html>
