/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.LoginModel;
import View.LoginPage;
import View.AdminDashBoard;
import javax.swing.JOptionPane;

/**
 * LoginController class handles user authentication for the FurniStock system.
 * It validates login credentials entered on the LoginPage view and provides
 * access to the AdminDashBoard if the credentials are correct.
 * 
 * This controller follows the MVC design pattern by separating the
 * authentication logic from the view and model.
 */
public class LoginController {

    // Reference to the LoginPage view
    private LoginPage loginView;

    /**
     * Constructor initializes the controller with a reference to the login view.
     * @param view The LoginPage instance associated with this controller
     */
    public LoginController(LoginPage view) {
        this.loginView = view;
    }

    /**
     * Validates login credentials entered by the user.
     * This method trims any leading/trailing spaces, checks the
     * credentials against predefined admin values, and opens
     * the Admin dashboard on successful login.
     *
     * @param user The username entered by the user
     * @param pass The password entered by the user
     */
    public void validateLogin(String user, String pass) {
        // Remove any accidental spaces before or after the entered text
        String cleanUser = user.trim();
        String cleanPass = pass.trim();

        // Create a LoginModel instance to store username and password
        LoginModel loginData = new LoginModel(cleanUser, cleanPass);

        // Check credentials against predefined admin username and password
        if (loginData.getUsername().equals("@prashant") && loginData.getPassword().equals("12345")) {
            // Display success message
            JOptionPane.showMessageDialog(loginView, "Login Successful! Welcome Admin.");
            
            // Close the login page
            loginView.dispose();
            
            // Open the Admin Dashboard
            AdminDashBoard dash = new AdminDashBoard();
            dash.setVisible(true);
        } else {
            // Show error message if credentials are invalid
            JOptionPane.showMessageDialog(
                    loginView, 
                    "Invalid Username or Password", 
                    "Login Error", 
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }
}
