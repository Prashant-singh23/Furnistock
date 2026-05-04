package com.Furnistock.controller;

import com.Furnistock.dao.CartDao;
import com.Furnistock.dao.FurnitureDao;
import com.Furnistock.dao.UserDao;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/login", "/register", "/home", "/logout", "/admin", "/admin-login", "/index", "/view-customers"})
public class LoginController extends HttpServlet {

    private UserDao userDao;
    private CartDao cartDao;
    private FurnitureDao furnitureDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
        cartDao = new CartDao();
        furnitureDao = new FurnitureDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                forward(request, response, "/WEB-INF/pages/login.jsp");
                break;

            case "/admin-login":
                forward(request, response, "/WEB-INF/pages/admin-login.jsp");
                break;

            case "/index":
                forward(request, response, "/WEB-INF/pages/index.jsp");
                break;

            case "/register":
                forward(request, response, "/WEB-INF/pages/register.jsp");
                break;

            case "/logout":
                HttpSession logoutSession = request.getSession(false);
                if (logoutSession != null) logoutSession.invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                break;

            case "/home":
                User homeUser = getSessionUser(request);
                if (homeUser == null) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
                request.setAttribute("cartCount",    cartDao.getCartItemCount(homeUser.getId()));
                request.setAttribute("orderCount",   cartDao.getUserOrders(homeUser.getId()).size());
                request.setAttribute("productCount", furnitureDao.getAllFurniture().size());
                forward(request, response, "/WEB-INF/pages/home.jsp");
                break;

            case "/admin":
                User adminUser = getSessionUser(request);
                if (adminUser == null || !isAdmin(adminUser)) {
                    response.sendRedirect(request.getContextPath() + "/admin-login");
                    return;
                }
                request.setAttribute("totalUsers",    userDao.getUserCount());
                request.setAttribute("totalOrders",   cartDao.getTotalOrderCount());
                request.setAttribute("totalProducts", furnitureDao.getAllFurniture().size());
                request.setAttribute("totalRevenue",  cartDao.getTotalRevenue());
                forward(request, response, "/WEB-INF/pages/admin.jsp");
                break;

            case "/view-customers":
                User viewUser = getSessionUser(request);
                if (viewUser == null || !isAdmin(viewUser)) {
                    response.sendRedirect(request.getContextPath() + "/admin-login");
                    return;
                }
                List<User> customers = userDao.getAllUsers();
                request.setAttribute("customers", customers);
                forward(request, response, "/WEB-INF/pages/customer-list.jsp");
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/admin-login":
                handleAdminLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // ── Handlers ──────────────────────────────────────────────────────────────

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        if (isBlank(email) || isBlank(password)) {
            request.setAttribute("error", "Email and password are required.");
            forward(request, response, "/WEB-INF/pages/login.jsp");
            return;
        }

        User user = userDao.validateUser(email, password);
        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            forward(request, response, "/WEB-INF/pages/login.jsp");
            return;
        }

        request.getSession().setAttribute("user", user);
        String dest = isAdmin(user) ? "/admin" : "/home";
        response.sendRedirect(request.getContextPath() + dest);
    }

    private void handleAdminLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (isBlank(username) || isBlank(password)) {
            request.setAttribute("error", "Username and password are required.");
            forward(request, response, "/WEB-INF/pages/admin-login.jsp");
            return;
        }

        User admin = userDao.validateAdmin(username, password);
        if (admin == null) {
            request.setAttribute("error", "Invalid username or password.");
            forward(request, response, "/WEB-INF/pages/admin-login.jsp");
            return;
        }

        request.getSession().setAttribute("user", admin);
        response.sendRedirect(request.getContextPath() + "/admin");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName   = request.getParameter("firstName");
        String lastName    = request.getParameter("lastName");
        String email       = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password    = request.getParameter("password");

        if (isBlank(firstName) || isBlank(lastName) || isBlank(email) || isBlank(password)) {
            request.setAttribute("error", "All required fields must be filled.");
            forward(request, response, "/WEB-INF/pages/register.jsp");
            return;
        }

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setPasswordHash(password);

        if (userDao.registerUser(user)) {
            response.sendRedirect(request.getContextPath() + "/login?success=true");
        } else {
            request.setAttribute("error", "Registration failed. Email may already exist.");
            forward(request, response, "/WEB-INF/pages/register.jsp");
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private User getSessionUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("user");
    }

    private boolean isAdmin(User user) {
        return user != null && "admin".equals(user.getRole());
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, String path)
            throws ServletException, IOException {
        req.getRequestDispatcher(path).forward(req, res);
    }
}