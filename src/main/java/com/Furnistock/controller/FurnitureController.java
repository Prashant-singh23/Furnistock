package com.Furnistock.controller;

import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.model.Furniture;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/furniture", "/furniture-list", "/furniture-add", "/furniture-edit", "/furniture-delete", "/furniture-search"})
public class FurnitureController extends HttpServlet {
    private final FurnitureDao furnitureDao = new FurnitureDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        // Check if user is admin
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String path = request.getServletPath();

        if ("/furniture-list".equals(path)) {
            handleFurnitureList(request, response);
        } else if ("/furniture-add".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp").forward(request, response);
        } else if ("/furniture-edit".equals(path)) {
            handleFurnitureEdit(request, response);
        } else if ("/furniture-search".equals(path)) {
            handleFurnitureSearch(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        // Check if user is admin
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String path = request.getServletPath();

        if ("/furniture-add".equals(path)) {
            handleAddFurniture(request, response);
        } else if ("/furniture-edit".equals(path)) {
            handleUpdateFurniture(request, response);
        } else if ("/furniture-delete".equals(path)) {
            handleDeleteFurniture(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleFurnitureList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Furniture> furnitureList = furnitureDao.getAllFurniture();
        request.setAttribute("furnitureList", furnitureList);
        request.getRequestDispatcher("/WEB-INF/pages/furniture-list.jsp").forward(request, response);
    }

    private void handleFurnitureEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Furniture furniture = furnitureDao.getFurnitureById(id);
                if (furniture != null) {
                    request.setAttribute("furniture", furniture);
                    request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/furniture-list");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/furniture-list");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/furniture-list");
        }
    }

    private void handleAddFurniture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");

        if (name == null || description == null || category == null || priceStr == null || 
            stockStr == null || name.isBlank() || description.isBlank() || category.isBlank()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp").forward(request, response);
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if (price < 0 || stock < 0) {
                request.setAttribute("error", "Price and stock must be positive numbers.");
                request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp").forward(request, response);
                return;
            }

            Furniture furniture = new Furniture(name, description, category, price, stock, 
                    imageUrl != null && !imageUrl.isBlank() ? imageUrl : "default.jpg");

            if (furnitureDao.addFurniture(furniture)) {
                response.sendRedirect(request.getContextPath() + "/furniture-list?success=true");
            } else {
                request.setAttribute("error", "Failed to add furniture. Please try again.");
                request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or stock value.");
            request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp").forward(request, response);
        }
    }

    private void handleUpdateFurniture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");

        if (idStr == null || name == null || description == null || category == null || 
            priceStr == null || stockStr == null || name.isBlank() || description.isBlank() || 
            category.isBlank()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if (price < 0 || stock < 0) {
                request.setAttribute("error", "Price and stock must be positive numbers.");
                request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp").forward(request, response);
                return;
            }

            Furniture furniture = new Furniture(id, name, description, category, price, stock,
                    imageUrl != null && !imageUrl.isBlank() ? imageUrl : "default.jpg");

            if (furnitureDao.updateFurniture(furniture)) {
                response.sendRedirect(request.getContextPath() + "/furniture-list?success=true");
            } else {
                request.setAttribute("error", "Failed to update furniture. Please try again.");
                request.setAttribute("furniture", furniture);
                request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input values.");
            request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp").forward(request, response);
        }
    }

    private void handleDeleteFurniture(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                furnitureDao.deleteFurniture(id);
            } catch (NumberFormatException e) {
                System.err.println("Invalid furniture ID: " + e.getMessage());
            }
        }
        response.sendRedirect(request.getContextPath() + "/furniture-list?success=true");
    }

    private void handleFurnitureSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        List<Furniture> furnitureList;

        if (searchTerm != null && !searchTerm.isBlank()) {
            furnitureList = furnitureDao.searchFurniture(searchTerm);
        } else {
            furnitureList = furnitureDao.getAllFurniture();
        }

        request.setAttribute("furnitureList", furnitureList);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("/WEB-INF/pages/furniture-list.jsp").forward(request, response);
    }
}
