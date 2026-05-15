package com.Furnistock.controller;

import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.model.Furniture;
import com.Furnistock.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({
        "/furniture",
        "/furniture-list",
        "/furniture-add",
        "/furniture-edit",
        "/furniture-delete",
        "/furniture-search"
})
public class FurnitureController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final FurnitureDao furnitureDao = new FurnitureDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        // Admin authentication check
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String path = request.getServletPath();

        switch (path) {

            case "/furniture":
            case "/furniture-list":
                handleFurnitureList(request, response);
                break;

            case "/furniture-add":
                request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp")
                        .forward(request, response);
                break;

            case "/furniture-edit":
                handleFurnitureEdit(request, response);
                break;

            case "/furniture-search":
                handleFurnitureSearch(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        // Admin authentication check
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String path = request.getServletPath();

        switch (path) {

            case "/furniture-add":
                handleAddFurniture(request, response);
                break;

            case "/furniture-edit":
                handleUpdateFurniture(request, response);
                break;

            case "/furniture-delete":
                handleDeleteFurniture(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void handleFurnitureList(HttpServletRequest request,
                                     HttpServletResponse response)
            throws ServletException, IOException {

        String sortOption = request.getParameter("sort");
        List<Furniture> furnitureList;

        try {
            furnitureList = furnitureDao.getAllFurniture(sortOption);
            if (furnitureList == null) {
                furnitureList = new ArrayList<>();
            }
        } catch (Exception e) {
            furnitureList = new ArrayList<>();
            request.setAttribute("error", "Unable to load products. Please try again later.");
            System.err.println("Error loading furniture list: " + e.getMessage());
        }

        request.setAttribute("furnitureList", furnitureList);
        request.setAttribute("searchTerm", "");
        request.setAttribute("sortOption", sortOption == null ? "" : sortOption);

        request.getRequestDispatcher("/WEB-INF/pages/furniture-list.jsp")
                .forward(request, response);
    }

    private void handleFurnitureEdit(HttpServletRequest request,
                                     HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/furniture-list");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            Furniture furniture = furnitureDao.getFurnitureById(id);

            if (furniture != null) {

                request.setAttribute("furniture", furniture);

                request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp")
                        .forward(request, response);

            } else {
                response.sendRedirect(request.getContextPath() + "/furniture-list");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/furniture-list");
        }
    }

    private void handleAddFurniture(HttpServletRequest request,
                                    HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");

        // Validation
        if (name == null || name.isBlank()
                || description == null || description.isBlank()
                || category == null || category.isBlank()
                || priceStr == null || stockStr == null) {

            request.setAttribute("error", "All fields are required.");

            request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp")
                    .forward(request, response);

            return;
        }

        try {

            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if (price < 0 || stock < 0) {

                request.setAttribute("error",
                        "Price and stock must be positive.");

                request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp")
                        .forward(request, response);

                return;
            }

            if (imageUrl == null || imageUrl.isBlank()) {
                imageUrl = null;
            }

            Furniture furniture = new Furniture(
                    name,
                    description,
                    category,
                    price,
                    stock,
                    imageUrl
            );

            boolean isAdded = furnitureDao.addFurniture(furniture);

            if (isAdded) {
                response.sendRedirect(
                        request.getContextPath() + "/furniture-list?success=added"
                );
            } else {

                request.setAttribute("error",
                        "Failed to add furniture.");

                request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp")
                        .forward(request, response);
            }

        } catch (NumberFormatException e) {

            request.setAttribute("error",
                    "Invalid price or stock value.");

            request.getRequestDispatcher("/WEB-INF/pages/furniture-add.jsp")
                    .forward(request, response);
        }
    }

    private void handleUpdateFurniture(HttpServletRequest request,
                                       HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String imageUrl = request.getParameter("imageUrl");

        // Validation
        if (idStr == null || idStr.isBlank()
                || name == null || name.isBlank()
                || description == null || description.isBlank()
                || category == null || category.isBlank()
                || priceStr == null || stockStr == null) {

            request.setAttribute("error", "All fields are required.");

            request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp")
                    .forward(request, response);

            return;
        }

        try {

            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if (price < 0 || stock < 0) {

                request.setAttribute("error",
                        "Price and stock must be positive.");

                request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp")
                        .forward(request, response);

                return;
            }

            if (imageUrl == null || imageUrl.isBlank()) {
                imageUrl = null;
            }

            Furniture furniture = new Furniture(
                    id,
                    name,
                    description,
                    category,
                    price,
                    stock,
                    imageUrl
            );

            boolean isUpdated = furnitureDao.updateFurniture(furniture);

            if (isUpdated) {

                response.sendRedirect(
                        request.getContextPath() + "/furniture-list?success=updated"
                );

            } else {

                request.setAttribute("error",
                        "Failed to update furniture.");

                request.setAttribute("furniture", furniture);

                request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp")
                        .forward(request, response);
            }

        } catch (NumberFormatException e) {

            request.setAttribute("error",
                    "Invalid input values.");

            request.getRequestDispatcher("/WEB-INF/pages/furniture-edit.jsp")
                    .forward(request, response);
        }
    }

    private void handleDeleteFurniture(HttpServletRequest request,
                                       HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isBlank()) {

            try {

                int id = Integer.parseInt(idStr);

                furnitureDao.deleteFurniture(id);

            } catch (NumberFormatException e) {

                System.out.println("Invalid furniture ID: "
                        + e.getMessage());
            }
        }

        response.sendRedirect(
                request.getContextPath() + "/furniture-list?success=deleted"
        );
    }

    private void handleFurnitureSearch(HttpServletRequest request,
                                       HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("search");
        String sortOption = request.getParameter("sort");

        List<Furniture> furnitureList;

        if (searchTerm != null && !searchTerm.isBlank()) {
            furnitureList = furnitureDao.searchFurniture(searchTerm, sortOption);
        } else {
            furnitureList = furnitureDao.getAllFurniture(sortOption);
        }

        request.setAttribute("furnitureList", furnitureList);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("sortOption", sortOption);

        request.getRequestDispatcher("/WEB-INF/pages/furniture-list.jsp")
                .forward(request, response);
    }
}