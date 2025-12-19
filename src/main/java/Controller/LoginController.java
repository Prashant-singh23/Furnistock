/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.LoginModel;
import View.LoginPage;
import View.Dashboard;
import javax.swing.JOptionPane;

public class LoginController {
    private LoginPage loginView;

    public LoginController(LoginPage view) {
        this.loginView = view;
    }

    public void validateLogin(String user, String pass) {
        // .trim() removes any accidental spaces before or after the text
        String cleanUser = user.trim();
        String cleanPass = pass.trim();

        LoginModel loginData = new LoginModel(cleanUser, cleanPass);

        // Check against the exact values
        if (loginData.getUsername().equals("@prashant") && loginData.getPassword().equals("12345")) {
            JOptionPane.showMessageDialog(loginView, "Login Successful! Welcome Admin.");
            
            loginView.dispose(); // Close login
            Dashboard dash = new Dashboard(); // Open Dashboard
            dash.setVisible(true);
        } else {
            JOptionPane.showMessageDialog(loginView, "Invalid Username or Password", "Login Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}