package com.Furnistock.controller;

import com.Furnistock.dao.CartDao;
import com.Furnistock.dao.FeedbackDao;
import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.dao.UserDao;
import com.Furnistock.model.Feedback;
import com.Furnistock.model.Furniture;
import com.Furnistock.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet({"/", "/index", "/home", "/about", "/contact", "/admin", "/admin-stats", "/admin-report", "/admin-settings", "/admin-support", "/admin-feedback"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/index":
            case "":
            case "/":
                request.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(request, response);
                break;
            case "/home":
                FurnitureDao furnitureDao = new FurnitureDao();
                List<Furniture> furnitureList = furnitureDao.getAllFurniture();
                if (furnitureList.size() > 4) {
                    furnitureList = furnitureList.subList(0, 4);
                }
                request.setAttribute("homeFurnitureList", furnitureList);
                request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
                break;
            case "/about":
                request.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(request, response);
                break;
            case "/contact":
                request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
                break;
            case "/admin":
                populateAdminStats(request);
                request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
                break;
            case "/admin-stats":
                handleAdminStats(request, response);
                break;
            case "/admin-report":
                CartDao cartDao = new CartDao();
                List<Cart> orderList = cartDao.getAllOrders();
                request.setAttribute("orderList", orderList);
                request.getRequestDispatcher("/WEB-INF/pages/report.jsp").forward(request, response);
                break;
            case "/admin-settings":
                request.getRequestDispatcher("/WEB-INF/pages/settings.jsp").forward(request, response);
                break;
            case "/admin-support":
                request.getRequestDispatcher("/WEB-INF/pages/support.jsp").forward(request, response);
                break;
            case "/admin-feedback":
                handleAdminFeedback(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void populateAdminStats(HttpServletRequest request) {
        UserDao userDao = new UserDao();
        CartDao cartDao = new CartDao();
        FurnitureDao furnitureDao = new FurnitureDao();

        request.setAttribute("totalUsers", userDao.getUserCount());
        request.setAttribute("totalOrders", cartDao.getTotalOrderCount());
        request.setAttribute("totalProducts", furnitureDao.getFurnitureCount());
        request.setAttribute("totalRevenue", cartDao.getTotalRevenue());
    }

    private void handleAdminStats(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        UserDao userDao = new UserDao();
        CartDao cartDao = new CartDao();
        FurnitureDao furnitureDao = new FurnitureDao();

        int totalUsers = userDao.getUserCount();
        int totalOrders = cartDao.getTotalOrderCount();
        int totalProducts = furnitureDao.getFurnitureCount();
        double totalRevenue = cartDao.getTotalRevenue();

        String json = "{"
                + "\"totalUsers\":" + totalUsers + ","
                + "\"totalOrders\":" + totalOrders + ","
                + "\"totalProducts\":" + totalProducts + ","
                + "\"totalRevenue\":" + totalRevenue
                + "}";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/admin-settings":
                handleAdminSettingsPost(request, response);
                break;
            case "/admin-support":
                handleAdminSupportPost(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void handleAdminSettingsPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle settings form submission
        response.sendRedirect(request.getContextPath() + "/admin-settings");
    }

    private void handleAdminFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDao feedbackDao = new FeedbackDao();
        List<Feedback> feedbackList = feedbackDao.getAllFeedback();
        int feedbackCount = feedbackDao.getFeedbackCount();

        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("feedbackCount", feedbackCount);
        request.getRequestDispatcher("/WEB-INF/pages/admin-feedback.jsp").forward(request, response);
    }

    private void handleAdminSupportPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Log or save support message
        System.out.println("Support Message - From: " + email + ", Subject: " + subject);

        response.sendRedirect(request.getContextPath() + "/admin-support?submitted=true");
    }
}
