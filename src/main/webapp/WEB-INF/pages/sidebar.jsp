<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPath = request.getRequestURI().substring(request.getContextPath().length());
    boolean isAdminRoute = "/admin".equals(currentPath) || "/admin-report".equals(currentPath)
        || "/admin-feedback".equals(currentPath) || "/furniture".equals(currentPath)
        || "/furniture-list".equals(currentPath) || "/furniture-add".equals(currentPath)
        || "/furniture-edit".equals(currentPath) || "/furniture-search".equals(currentPath)
        || "/customer-list".equals(currentPath);
    boolean activeHome = "/home".equals(currentPath);
    boolean activeShop = "/shop".equals(currentPath);
    boolean activeOrders = "/orders".equals(currentPath);
    boolean activeCart = "/cart".equals(currentPath);
    boolean activeSettings = "/settings".equals(currentPath);
    boolean activeSupport = "/support".equals(currentPath);
    boolean activeDashboard = "/admin".equals(currentPath);
    boolean activeProducts = "/furniture".equals(currentPath) || "/furniture-list".equals(currentPath)
        || "/furniture-add".equals(currentPath) || "/furniture-edit".equals(currentPath)
        || "/furniture-search".equals(currentPath);
    boolean activeCustomers = "/customer-list".equals(currentPath);
    boolean activeReport = "/admin-report".equals(currentPath);
    boolean activeFeedback = "/admin-feedback".equals(currentPath);
%>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"></div>
        <span class="brand-name">Furni<span>Stock</span></span>
    </div>
    <nav class="sidebar-nav">
        <% if (isAdminRoute) { %>
            <a href="${pageContext.request.contextPath}/admin" class="nav-item<%= activeDashboard ? " active" : "" %>"><i class="bi bi-speedometer2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/furniture-list" class="nav-item<%= activeProducts ? " active" : "" %>"><i class="bi bi-box"></i> Products</a>
            <a href="${pageContext.request.contextPath}/customer-list" class="nav-item<%= activeCustomers ? " active" : "" %>"><i class="bi bi-people"></i> Customers</a>
            <a href="${pageContext.request.contextPath}/admin-report" class="nav-item<%= activeReport ? " active" : "" %>"><i class="bi bi-graph-up"></i> Reports</a>
            <a href="${pageContext.request.contextPath}/admin-feedback" class="nav-item<%= activeFeedback ? " active" : "" %>"><i class="bi bi-chat-dots"></i> Feedback</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item"><i class="bi bi-box-arrow-right"></i> Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/home" class="nav-item<%= activeHome ? " active" : "" %>"><i class="bi bi-speedometer2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/shop" class="nav-item<%= activeShop ? " active" : "" %>"><i class="bi bi-grid"></i> Catalog</a>
            <a href="${pageContext.request.contextPath}/shop" class="nav-item<%= activeShop ? " active" : "" %>"><i class="bi bi-star"></i> New Arrivals</a>
            <a href="${pageContext.request.contextPath}/orders" class="nav-item<%= activeOrders ? " active" : "" %>"><i class="bi bi-box"></i> My Orders</a>
            <a href="${pageContext.request.contextPath}/cart" class="nav-item<%= activeCart ? " active" : "" %>"><i class="bi bi-cart"></i> Cart</a>
            <a href="${pageContext.request.contextPath}/settings" class="nav-item<%= activeSettings ? " active" : "" %>"><i class="bi bi-gear"></i> Settings</a>
            <a href="${pageContext.request.contextPath}/support" class="nav-item<%= activeSupport ? " active" : "" %>"><i class="bi bi-chat-dots"></i> Support</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item"><i class="bi bi-box-arrow-right"></i> Logout</a>
        <% } %>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <svg viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
            <span>Logout</span>
        </a>
    </div>
</aside>
