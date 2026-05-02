package com.Furnistock.controller;

import com.Furnistock.dao.CartDao;
import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.model.Cart;
import com.Furnistock.model.Furniture;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/shop", "/cart", "/add-to-cart", "/remove-from-cart", "/checkout", "/orders"})
public class UserShopController extends HttpServlet {
    private final FurnitureDao furnitureDao = new FurnitureDao();
    private final CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/shop".equals(path)) {
            handleShop(request, response, user);
        } else if ("/cart".equals(path)) {
            handleViewCart(request, response, user);
        } else if ("/orders".equals(path)) {
            handleViewOrders(request, response, user);
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
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleShop(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Furniture> furnitureList;

        if (category != null && !category.isEmpty()) {
            furnitureList = furnitureDao.getFurnitureByCategory(category);
        } else {
            furnitureList = furnitureDao.getAllFurniture();
        }

        int cartCount = cartDao.getCartItemCount(user.getId());

        request.setAttribute("furnitureList", furnitureList);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("cartCount", cartCount);
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
}
