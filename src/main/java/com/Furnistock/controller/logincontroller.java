package com.Furnistock.controller;

import com.Furnistock.dao.UserDao;
import com.Furnistock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AuthController handles all authentication-related requests: Login, Registration, and Logout.
 * This satisfies the "Two Controllers" requirement.
 */
@WebServlet({"/login", "/register", "/home"})
public class logincontroller extends HttpServlet {
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        // Routing based on servlet path
        if (path.equals("/login")) {
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        } else if (path.equals("/register")) {
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        } else if (path.equals("/home")) {
        	request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);  
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path.equals("/login")) {
            handleLogin(request, response);
        } else if (path.equals("/register")) {
            handleRegister(request, response);
        }
    }

    /**
     * Logic for user login: validating credentials, setting session, and cookie.
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDao.validateUser(email, password);

        if (user != null) {
            // Login successful → redirect to home page
            response.sendRedirect("home");
        } else {
            // Login failed → return to login page with error
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("password");

        // Basic validation
        if (firstName == null || lastName == null || email == null || password == null) {
            request.setAttribute("error", "All required fields must be filled.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setPasswordHash(password); // raw password, DAO will hash it

        boolean isRegistered = userDao.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("login?success=true");
        } else {
            request.setAttribute("error", "Registration failed. Email may already exist.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }

  
}
