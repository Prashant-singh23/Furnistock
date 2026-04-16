<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — FurniStock</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

<%
    /* ── Server-side: read error/success messages ── */
    String errorMsg   = (String) session.getAttribute("registerError");
    String successMsg = (String) session.getAttribute("registerSuccess");
    if (errorMsg   != null) session.removeAttribute("registerError");
    if (successMsg != null) session.removeAttribute("registerSuccess");
%>

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
            <h1>Create Account</h1>
            <p>Join thousands of happy homeowners today</p>
        </div>

        <!-- Body -->
        <div class="card-body">

           

            <!-- Registration Form -->
            <form id="registerForm" action="register" method="post" novalidate>

                <!-- First Name + Last Name -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <div class="input-wrap">
                            <span class="icon">
                                <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                            </span>
                            <input
                                type="text"
                                id="firstName"
                                name="firstName"
                                placeholder="John"
                                autocomplete="given-name"
                                required>
                        </div>
                        <span class="msg-error" id="firstNameErr"></span>
                    </div>

                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <div class="input-wrap">
                            <span class="icon">
                                <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                            </span>
                            <input
                                type="text"
                                id="lastName"
                                name="lastName"
                                placeholder="Doe"
                                autocomplete="family-name"
                                required>
                        </div>
                        <span class="msg-error" id="lastNameErr"></span>
                    </div>
                </div>

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

                <!-- Phone -->
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <div class="input-wrap">
                        <span class="icon">
                            <svg viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.18 2 2 0 0 1 3.59 1h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.57a16 16 0 0 0 6.29 6.29l.95-.95a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                        </span>
                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="+977 98XXXXXXXX"
                            autocomplete="tel">
                    </div>
                    <span class="msg-error" id="phoneErr"></span>
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
                            placeholder="Create a strong password"
                            autocomplete="new-password"
                            oninput="checkStrength(this.value)"
                            required>
                        <button type="button" class="toggle-pass" onclick="togglePass('password', this)" aria-label="Show/hide password">
                            <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                    <!-- Strength bar -->
                    <div class="strength-bar" id="strengthBar">
                        <span id="s1"></span>
                        <span id="s2"></span>
                        <span id="s3"></span>
                        <span id="s4"></span>
                    </div>
                    <p class="strength-label" id="strengthLabel"></p>
                    <span class="msg-error" id="passErr"></span>
                </div>

                <!-- Confirm Password -->
<div class="form-group">
    <label for="confirmPassword">Confirm Password</label>

    <div class="input-wrap">
        <span class="icon">
            <svg viewBox="0 0 24 24">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
            </svg>
        </span>

        <input
            type="password"
            id="confirmPassword"
            name="confirmPassword"
            placeholder="Re-enter your password"
            autocomplete="new-password"
            required>

        <button type="button"
                class="toggle-pass"
                onclick="togglePass('confirmPassword', this)"
                aria-label="Show/hide password">

            <svg viewBox="0 0 24 24"
                 width="16"
                 height="16"
                 stroke="currentColor"
                 fill="none"
                 stroke-width="2"
                 stroke-linecap="round"
                 stroke-linejoin="round">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                <circle cx="12" cy="12" r="3"/>
            </svg>

        </button>
    </div>
</div>
                    
                <!-- Hidden CSRF token -->
                <input type="hidden" name="csrf_token" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>">

                <!-- Submit -->
                <button type="submit" class="btn-submit">Create My Account</button>

            </form>

            <div class="divider">already a member?</div>

            <!-- Footer -->
            <p class="card-footer-text">
                <a href="login">Sign in to your account →</a>
            </p>

        </div>
        <!-- /card-body -->

    </div>
    <!-- /auth-card -->

    <!-- Trust badges -->
    <div class="features">
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
            256-bit SSL
        </span>
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
            Free Returns
        </span>
        <span class="feature-badge">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            Free Delivery
        </span>
    </div>

</div>
<!-- /auth-wrapper -->

<script>
/* ── Toggle password visibility ── */
function togglePass(fieldId, btn) {
    const input  = document.getElementById(fieldId);
    const isText = input.type === 'text';
    input.type   = isText ? 'password' : 'text';
    btn.innerHTML = isText
        ? `<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>`
        : `<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/></svg>`;
}

/* ── Password Strength ── */
function checkStrength(val) {
    const bars   = [document.getElementById('s1'), document.getElementById('s2'),
                    document.getElementById('s3'), document.getElementById('s4')];
    const label  = document.getElementById('strengthLabel');
    const levels = ['active-weak', 'active-fair', 'active-good', 'active-strong'];
    const names  = ['Weak', 'Fair', 'Good', 'Strong'];

    let score = 0;
    if (val.length >= 8)          score++;
    if (/[A-Z]/.test(val))        score++;
    if (/[0-9]/.test(val))        score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    bars.forEach((b, i) => {
        b.className = '';
        if (i < score) b.classList.add(levels[score - 1]);
    });

    label.textContent = val.length ? `Strength: ${names[score - 1] || 'Too short'}` : '';
    label.style.color = score === 1 ? '#E74C3C' : score === 2 ? '#F39C12' : score === 3 ? '#2ECC71' : '#B8822A';
}

/* ── Client-side Validation ── */
document.getElementById('registerForm').addEventListener('submit', function(e) {
    let valid = true;

    const fields = {
        firstName:       { el: document.getElementById('firstName'),       err: document.getElementById('firstNameErr') },
        lastName:        { el: document.getElementById('lastName'),        err: document.getElementById('lastNameErr') },
        email:           { el: document.getElementById('email'),           err: document.getElementById('emailErr') },
        phone:           { el: document.getElementById('phone'),           err: document.getElementById('phoneErr') },
        password:        { el: document.getElementById('password'),        err: document.getElementById('passErr') },
        confirmPassword: { el: document.getElementById('confirmPassword'), err: document.getElementById('confirmErr') },
    };

    /* Clear errors */
    Object.values(fields).forEach(f => f.err.textContent = '');

    const nameRx  = /^[A-Za-z\s'-]{2,}$/;
    const emailRx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRx = /^[+\d\s\-()]{7,15}$/;

    if (!fields.firstName.el.value.trim()) {
        fields.firstName.err.textContent = '✕  First name is required.'; valid = false;
    } else if (!nameRx.test(fields.firstName.el.value.trim())) {
        fields.firstName.err.textContent = '✕  Enter a valid first name.'; valid = false;
    }

    if (!fields.lastName.el.value.trim()) {
        fields.lastName.err.textContent = '✕  Last name is required.'; valid = false;
    } else if (!nameRx.test(fields.lastName.el.value.trim())) {
        fields.lastName.err.textContent = '✕  Enter a valid last name.'; valid = false;
    }

    if (!fields.email.el.value.trim()) {
        fields.email.err.textContent = '✕  Email address is required.'; valid = false;
    } else if (!emailRx.test(fields.email.el.value.trim())) {
        fields.email.err.textContent = '✕  Please enter a valid email address.'; valid = false;
    }

    const phoneVal = fields.phone.el.value.trim();
    if (phoneVal && !phoneRx.test(phoneVal)) {
        fields.phone.err.textContent = '✕  Please enter a valid phone number.'; valid = false;
    }

    if (!fields.password.el.value) {
        fields.password.err.textContent = '✕  Password is required.'; valid = false;
    } else if (fields.password.el.value.length < 8) {
        fields.password.err.textContent = '✕  Password must be at least 8 characters.'; valid = false;
    }

    if (!fields.confirmPassword.el.value) {
        fields.confirmPassword.err.textContent = '✕  Please confirm your password.'; valid = false;
    } else if (fields.password.el.value !== fields.confirmPassword.el.value) {
        fields.confirmPassword.err.textContent = '✕  Passwords do not match.'; valid = false;
    }

    if (!document.getElementById('terms').checked) {
        alert('Please accept the Terms & Conditions to continue.');
        valid = false;
    }

    if (!valid) e.preventDefault();
});
</script>

</body>
</html>
