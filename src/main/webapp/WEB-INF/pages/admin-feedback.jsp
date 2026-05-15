<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Furnistock.model.Feedback" %>
<%@ page import="com.Furnistock.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin-login");
        return;
    }
    List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
    Integer feedbackCount = (Integer) request.getAttribute("feedbackCount");
    if (feedbackCount == null) {
        feedbackCount = 0;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Customer Feedback — FurniStock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&family=Jost:wght@300;400;500;600&display=swap');

        :root {
            --bg:         #F7F2EA;
            --panel-bg:   #FDFAF5;
            --brown-dark: #2E1B0E;
            --brown-mid:  #5C3D2E;
            --gold:       #B8822A;
            --gold-light: #D4A855;
            --cream:      #EDE5D4;
            --text:       #1C1208;
            --text-muted: #7A6652;
            --border:     #D9CEBC;
            --shadow:     0 20px 60px rgba(46, 27, 14, 0.12);
            --shadow-sm:  0 4px 16px rgba(46, 27, 14, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Jost', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: var(--panel-bg);
            padding: 20px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--text);
            border-bottom: 1px solid var(--border);
        }

        .nav-brand {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: 600;
            gap: 12px;
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
        }

        .nav-brand span:last-child {
            color: var(--gold);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.95rem;
            color: var(--text);
        }

        .admin-badge {
            background-color: var(--gold);
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .logout-btn {
            background-color: var(--gold);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.25s ease;
            font-weight: 600;
        }

        .logout-btn:hover {
            background-color: var(--gold-light);
            transform: translateY(-2px);
        }

        .sidebar {
            width: 280px;
            background: var(--panel-bg);
            border-right: 1px solid var(--border);
            padding: 30px 0;
            position: sticky;
            top: 0;
            height: calc(100vh - 80px);
            overflow-y: auto;
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 0 0 24px;
            margin: 0;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 24px;
            border-radius: 10px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.25s ease;
            border-left: 3px solid transparent;
        }

        .nav-item svg {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            stroke-width: 1.5;
            fill: none;
        }

        .nav-item:hover {
            background-color: var(--cream);
            color: var(--brown-dark);
        }

        .nav-item.active {
            background-color: var(--brown-dark);
            border-left-color: var(--gold);
            color: var(--panel-bg);
            font-weight: 600;
        }

        .nav-item.active svg {
            stroke: var(--gold-light);
        }

        .main-wrapper {
            display: flex;
            flex: 1;
        }

        .main-content {
            flex: 1;
            overflow-y: auto;
        }

        .container {
            flex: 1;
            padding: 60px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 30px;
            color: var(--gold);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.25s ease;
        }

        .back-link:hover {
            color: var(--gold-light);
        }

        .page-header {
            background: var(--panel-bg);
            padding: 40px;
            border-radius: 16px;
            margin-bottom: 40px;
            border: 1px solid var(--border);
        }

        .page-header h1 {
            font-family: 'Playfair Display', serif;
            color: var(--brown-dark);
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 16px;
        }

        .stats-box {
            background: var(--panel-bg);
            padding: 24px;
            border-radius: 12px;
            border: 1px solid var(--border);
            border-left: 4px solid var(--gold);
            margin-bottom: 40px;
        }

        .stats-box p {
            color: var(--text-muted);
            font-size: 13px;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .stats-box .stat-number {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--brown-dark);
        }

        .feedback-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--panel-bg);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
        }

        .feedback-table thead {
            background: var(--brown-dark);
            color: white;
        }

        .feedback-table th {
            padding: 18px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .feedback-table tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background-color 0.25s ease;
        }

        .feedback-table tbody tr:last-child {
            border-bottom: none;
        }

        .feedback-table tbody tr:hover {
            background-color: var(--cream);
        }

        .feedback-table td {
            padding: 16px 20px;
            color: var(--text);
        }

        .user-name {
            font-weight: 600;
            color: var(--brown-dark);
        }

        .user-email {
            color: var(--gold);
            text-decoration: none;
        }

        .user-email:hover {
            text-decoration: underline;
        }

        .subject {
            font-weight: 500;
            color: var(--brown-mid);
        }

        .message {
            color: var(--text-muted);
            max-width: 350px;
            word-wrap: break-word;
            white-space: pre-wrap;
            font-size: 0.95em;
        }

        .date {
            color: var(--text-muted);
            font-size: 0.9em;
        }

        .empty-state {
            text-align: center;
            padding: 80px 40px;
            background: var(--panel-bg);
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .empty-state-icon {
            font-size: 48px;
            color: var(--text-muted);
            margin-bottom: 20px;
            opacity: 0.6;
        }

        .empty-state p {
            color: var(--text-muted);
            font-size: 16px;
        }

        .footer {
            background: var(--panel-bg);
            color: var(--text-muted);
            text-align: center;
            padding: 24px 60px;
            margin-top: auto;
            border-top: 1px solid var(--border);
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 15px 30px;
            }

            .container {
                padding: 30px;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .feedback-table {
                font-size: 0.9em;
            }

            .feedback-table th,
            .feedback-table td {
                padding: 12px 10px;
            }

            .message {
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <jsp:include page="admin-sidebar.jsp" />
        <div class="main-content">
            <div class="container">
        <a href="${pageContext.request.contextPath}/admin" class="back-link"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>

        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-chat-dots"></i> Customer Feedback</h1>
            <p>View all customer messages and support requests</p>
        </div>

        <!-- Stats Box -->
        <div class="stats-box">
            <p>Total Messages</p>
            <div class="stat-number"><%= feedbackCount %></div>
        </div>

        <!-- Feedback Table -->
        <%
            if (feedbackList != null && !feedbackList.isEmpty()) {
        %>
            <table class="feedback-table">
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Date Submitted</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Feedback feedback : feedbackList) {
                    %>
                        <tr>
                            <td class="user-name"><%= feedback.getUserName() %></td>
                            <td><a href="mailto:<%= feedback.getUserEmail() %>" class="user-email"><%= feedback.getUserEmail() %></a></td>
                            <td class="subject"><%= feedback.getSubject() %></td>
                            <td class="message"><%= feedback.getMessage() %></td>
                            <td class="date"><%= feedback.getCreatedAt() != null ? feedback.getCreatedAt() : "N/A" %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <div class="empty-state">
                <div class="empty-state-icon"><i class="bi bi-inbox"></i></div>
                <p>No customer feedback yet. Feedback messages will appear here when customers submit support requests.</p>
            </div>
        <%
            }
        %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 FurniStock. All rights reserved. Admin Dashboard v1.0</p>
    </footer>

</body>
</html>
