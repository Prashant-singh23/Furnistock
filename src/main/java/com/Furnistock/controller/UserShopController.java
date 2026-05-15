package com.Furnistock.controller;

import com.Furnistock.dao.CartDao;
import com.Furnistock.dao.FeedbackDao;
import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.model.Cart;
import com.Furnistock.model.Feedback;
import com.Furnistock.model.Furniture;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet({"/shop", "/cart", "/add-to-cart", "/remove-from-cart", "/checkout", "/orders", "/report", "/settings", "/support"})
public class UserShopController extends HttpServlet {
    private final FurnitureDao furnitureDao = new FurnitureDao();
    private final CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);
        String path = request.getServletPath();

        if ("/shop".equals(path)) {
            handleShop(request, response, user);
        } else if ("/cart".equals(path)) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            handleViewCart(request, response, user);
        } else if ("/orders".equals(path)) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            handleViewOrders(request, response, user);
        } else if ("/report".equals(path)) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            handleViewReport(request, response, user);
        } else if ("/settings".equals(path)) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            handleSettings(request, response, user);
        } else if ("/support".equals(path)) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            handleSupport(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/add-to-cart".equals(path)) {
            handleAddToCart(request, response, user);
        } else if ("/remove-from-cart".equals(path)) {
            handleRemoveFromCart(request, response, user);
        } else if ("/checkout".equals(path)) {
            handleCheckout(request, response, user);
        } else if ("/settings".equals(path)) {
            handleSettingsPost(request, response, user);
        } else if ("/support".equals(path)) {
            handleSupportPost(request, response, user);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleShop(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        String searchTerm = request.getParameter("search");
        String sortOption = request.getParameter("sort");
        List<Furniture> furnitureList;

        if (searchTerm != null && !searchTerm.isBlank()) {
            furnitureList = furnitureDao.searchFurniture(searchTerm, sortOption);
        } else if (category != null && !category.isEmpty()) {
            furnitureList = furnitureDao.getFurnitureByCategory(category, sortOption);
        } else {
            furnitureList = furnitureDao.getAllFurniture(sortOption);
        }

        int cartCount = user == null ? 0 : cartDao.getCartItemCount(user.getId());

        request.setAttribute("furnitureList", furnitureList);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("sortOption", sortOption);
        request.setAttribute("cartCount", cartCount);
        request.setAttribute("guestUser", user == null);
        request.getRequestDispatcher("/WEB-INF/pages/user-shop.jsp").forward(request, response);
    }

    private void handleViewCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        List<Cart> cartList = cartDao.getUserCart(user.getId());
        double cartTotal = cartDao.getCartTotal(user.getId());

        request.setAttribute("cartList", cartList);
        request.setAttribute("cartTotal", cartTotal);
        request.getRequestDispatcher("/WEB-INF/pages/user-cart.jsp").forward(request, response);
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String furnitureIdStr = request.getParameter("furnitureId");
        String quantityStr = request.getParameter("quantity");

        if (furnitureIdStr == null || quantityStr == null) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        try {
            int furnitureId = Integer.parseInt(furnitureIdStr);
            int quantity = Integer.parseInt(quantityStr);

            Furniture furniture = furnitureDao.getFurnitureById(furnitureId);
            if (furniture == null || quantity <= 0 || quantity > furniture.getStock()) {
                response.sendRedirect(request.getContextPath() + "/shop");
                return;
            }

            Cart cart = new Cart(user.getId(), furnitureId, quantity);
            cartDao.addToCart(cart);

            response.sendRedirect(request.getContextPath() + "/cart?success=true");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shop");
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String cartIdStr = request.getParameter("cartId");

        if (cartIdStr != null) {
            try {
                int cartId = Integer.parseInt(cartIdStr);
                cartDao.removeFromCart(cartId);
            } catch (NumberFormatException e) {
                System.err.println("Invalid cart ID: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleCheckout(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        cartDao.checkoutCart(user.getId());
        response.sendRedirect(request.getContextPath() + "/orders?success=true");
    }

    private void handleViewOrders(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        List<Cart> orderList = cartDao.getUserOrders(user.getId());

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/WEB-INF/pages/user-orders.jsp").forward(request, response);
    }

    private void handleViewReport(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        List<Cart> orderList = cartDao.getUserOrders(user.getId());

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/WEB-INF/pages/report.jsp").forward(request, response);
    }

    private void handleSettings(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/settings.jsp").forward(request, response);
    }

    private void handleSettingsPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (firstName != null && lastName != null && email != null) {
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPhone(phone);
            
            // Update user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
        }

        response.sendRedirect(request.getContextPath() + "/settings");
    }

    private void handleSupport(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/support.jsp").forward(request, response);
    }

    private void handleSupportPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name != null && email != null && subject != null && message != null &&
            !name.isBlank() && !email.isBlank() && !subject.isBlank() && !message.isBlank()) {
            
            Feedback feedback = new Feedback();
            feedback.setUserId(user.getId());
            feedback.setUserEmail(email);
            feedback.setUserName(name);
            feedback.setSubject(subject);
            feedback.setMessage(message);
            feedback.setCreatedAt(LocalDateTime.now());

            FeedbackDao feedbackDao = new FeedbackDao();
            feedbackDao.saveFeedback(feedback);
        }

        response.sendRedirect(request.getContextPath() + "/support?submitted=true");
    }
}
