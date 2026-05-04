package com.Furnistock.controller;

import com.Furnistock.dao.UserDao;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/customer-list", "/customer-delete"})
public class UserController extends HttpServlet {
    private final UserDao userDao = new UserDao();

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

        if ("/customer-list".equals(path)) {
            handleCustomerList(request, response);
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

        if ("/customer-delete".equals(path)) {
            handleDeleteCustomer(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleCustomerList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> customerList = userDao.getAllUsers();
        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("/WEB-INF/pages/customer-list.jsp").forward(request, response);
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                if (userDao.deleteUser(id)) {
                    response.sendRedirect(request.getContextPath() + "/customer-list?deleted=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/customer-list?error=delete_failed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/customer-list?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/customer-list?error=missing_id");
        }
    }
}