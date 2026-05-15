package com.Furnistock.controller;

import com.Furnistock.dao.UserDao;
import com.Furnistock.model.User;
import com.Furnistock.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet({"/login", "/register", "/admin-login", "/logout", "/forgot-password", "/reset-password"})
public class AuthController extends HttpServlet {

    private final UserDao userDao = new UserDao();
    private static final long RESET_CODE_TTL_MS = 15 * 60 * 1000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                        .forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                        .forward(request, response);
                break;
            case "/admin-login":
                request.getRequestDispatcher("/WEB-INF/pages/admin-login.jsp")
                        .forward(request, response);
                break;
            case "/forgot-password":
                request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                        .forward(request, response);
                break;
            case "/reset-password":
                request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                        .forward(request, response);
                break;
            case "/logout":
                handleLogout(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            case "/admin-login":
                handleAdminLogin(request, response);
                break;
            case "/forgot-password":
                handleForgotPassword(request, response);
                break;
            case "/reset-password":
                handleResetPassword(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                    .forward(request, response);
            return;
        }

        email = email.trim();
        User user = userDao.validateUser(email, password);

        if (user != null && User.ROLE_USER.equalsIgnoreCase(user.getRole().trim())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                    .forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (firstName == null || firstName.isBlank()
                || lastName == null || lastName.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                    .forward(request, response);
            return;
        }

        firstName = firstName.trim();
        lastName = lastName.trim();
        email = email.trim().toLowerCase();
        phoneNumber = phoneNumber == null || phoneNumber.isBlank() ? null : phoneNumber.trim();

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                    .forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                    .forward(request, response);
            return;
        }

        User existingUser = userDao.getUserByEmail(email);
        if (existingUser != null) {
            request.setAttribute("error", "Email already exists.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                    .forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phoneNumber);
        newUser.setPasswordHash(password); // Plain password, will be hashed in DAO
        newUser.setRole(User.ROLE_USER);

        boolean isRegistered = userDao.registerUser(newUser);

        if (isRegistered) {
            HttpSession session = request.getSession();
            session.setAttribute("registerSuccess", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                    .forward(request, response);
        }
    }

    private void handleAdminLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/admin-login.jsp")
                    .forward(request, response);
            return;
        }

        User adminUser = userDao.validateAdmin(username, password);

        if (adminUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", adminUser);
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/pages/admin-login.jsp")
                    .forward(request, response);
        }
    }

    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email == null || email.isBlank()) {
            request.setAttribute("error", "Email is required to send a reset code.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                    .forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        User existingUser = userDao.getUserByEmail(email);
        if (existingUser == null) {
            request.setAttribute("error", "No user found with that email address.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                    .forward(request, response);
            return;
        }

        String code = generateResetCode();
        String subject = "Your FurniStock OTP code";
        String message = "Hello " + existingUser.getFirstName() + ",\n\n"
                + "Use the following OTP code to reset your FurniStock password:\n\n"
                + code + "\n\n"
                + "This OTP expires in 15 minutes. If you did not request this, please ignore this email.\n\n"
                + "Thank you,\n"
                + "The FurniStock Team";

        boolean sent = EmailUtil.sendEmail(email, subject, message);
        HttpSession session = request.getSession();
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetCode", code);
        session.setAttribute("resetCodeExpiry", System.currentTimeMillis() + RESET_CODE_TTL_MS);

        if (!sent) {
            request.setAttribute("info", "Email could not be sent, so the OTP is shown locally for testing.");
            request.setAttribute("otpNotice", "Use OTP: " + code);
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        request.setAttribute("info", "A verification code has been sent to your email. Enter the code below to reset your password.");
        request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                .forward(request, response);
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String code = request.getParameter("code");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession(false);
        if (session == null) {
            request.setAttribute("error", "Session expired. Request a new reset code.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                    .forward(request, response);
            return;
        }

        String expectedEmail = (String) session.getAttribute("resetEmail");
        String expectedCode = (String) session.getAttribute("resetCode");
        Long expiresAt = (Long) session.getAttribute("resetCodeExpiry");

        if (email == null || email.isBlank()
                || code == null || code.isBlank()
                || password == null || password.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        if (expectedEmail == null || expectedCode == null || expiresAt == null
                || !email.equals(expectedEmail)
                || !code.equals(expectedCode)
                || expiresAt < System.currentTimeMillis()) {
            clearResetSession(session);
            request.setAttribute("error", "Invalid or expired code. Request a new reset code.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                    .forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                    .forward(request, response);
            return;
        }

        User existingUser = userDao.getUserByEmail(email);
        if (existingUser == null) {
            request.setAttribute("error", "No user found with that email address.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp")
                    .forward(request, response);
            return;
        }

        boolean updated = userDao.updatePasswordByEmail(email, password);
        if (updated) {
            clearResetSession(session);
            session.setAttribute("success", "Password reset successfully. Please login with your new password.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Unable to reset password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp")
                    .forward(request, response);
        }
    }

    private void clearResetSession(HttpSession session) {
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetCode");
        session.removeAttribute("resetCodeExpiry");
    }

    private String generateResetCode() {
        Random rng = new Random();
        int code = 100000 + rng.nextInt(900000);
        return String.valueOf(code);
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/index");
    }
}
