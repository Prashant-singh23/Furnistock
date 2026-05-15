<%-- Shared admin sidebar for all admin pages --%>
<%
    String currentPath = request.getRequestURI().replace(request.getContextPath(), "");
%>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"></div>
        <span class="brand-name">Furni<span>Stock</span></span>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin" class="nav-item<%= "/admin".equals(currentPath) ? " active" : "" %>"><i class="bi bi-speedometer2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/furniture-list" class="nav-item<%= "/furniture-list".equals(currentPath) ? " active" : "" %>"><i class="bi bi-box"></i> Products</a>
        <a href="${pageContext.request.contextPath}/customer-list" class="nav-item<%= "/customer-list".equals(currentPath) ? " active" : "" %>"><i class="bi bi-people"></i> Customers</a>
        <a href="${pageContext.request.contextPath}/admin-report" class="nav-item<%= "/admin-report".equals(currentPath) ? " active" : "" %>"><i class="bi bi-graph-up"></i> Reports</a>
        <a href="${pageContext.request.contextPath}/admin-feedback" class="nav-item<%= "/admin-feedback".equals(currentPath) ? " active" : "" %>"><i class="bi bi-chat-dots"></i> Feedback</a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-item<%= "/logout".equals(currentPath) ? " active" : "" %>"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>
        </a>
    </div>
</aside>
