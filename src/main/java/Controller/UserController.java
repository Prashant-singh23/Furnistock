/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.UserModel;
import View.AdminDashBoard;

import java.awt.event.*;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 * Controller class for managing user operations.
 * Implements MVC pattern by handling user CRUD operations and updating the view.
 * Handles add, update, and delete operations for user management.
 */
public class UserController implements ActionListener {

    // Reference to the Dashboard view
    private AdminDashBoard view;
    
    // List to store all user records
    private ArrayList<UserModel> list;
    
    // Counter to generate unique user IDs (starts at 1001)
    private int nextId;

   
    public UserController(AdminDashBoard view) {
        this.view = view;
        this.list = new ArrayList<>();
        this.nextId = 1001; // Starting ID for users (will be prefixed with "U")

        // Register action listeners for the three user management buttons
        view.getBtnAddUser().addActionListener(this);
        view.getBtnUpdateUser().addActionListener(this);
        view.getBtnDeleteUser().addActionListener(this);

        // Add mouse listener to handle table row selection
        view.getUserTable().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                // When a row is clicked, populate input fields with that row's data
                fillFieldsFromTable();
            }
        });
    }

    //  ACTION HANDLER 
    
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == view.getBtnAddUser()) {
            addUser();
        } 
        else if (e.getSource() == view.getBtnUpdateUser()) {
            updateUser();
        } 
        else if (e.getSource() == view.getBtnDeleteUser()) {
            deleteUser();
        }
    }

    //  ADD USER
   
    private void addUser() {
        try {
            // Generate unique user ID with "U" prefix and auto-increment
            String id = "U" + nextId++;
            
            // Get and trim input values from view fields
            String name = view.getUserNameField().getText().trim();
            String email = view.getUserEmailField().getText().trim();
            String phone = view.getUserPhoneField().getText().trim();
            String status = view.getUserStatusCombo().getSelectedItem().toString();

            // Create new user model with collected data
            UserModel u = new UserModel(
                    id,
                    name,
                    email,
                    phone,
                    status
            );

            // Add user to list and update display
            list.add(u);
            refreshTable();
            view.clearUserFields();

            // Show success message
            JOptionPane.showMessageDialog(view, "User added successfully");

        } catch (Exception ex) {
            // Handle invalid input or any errors during user creation
            JOptionPane.showMessageDialog(view,
                    "Invalid input. Please check all fields.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    //  UPDATE USER
    
    private void updateUser() {
        // Check if a row is selected
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to update");
            return;
        }

        try {
            // Get the user at the selected row
            UserModel u = list.get(row);
            
            // Update all editable fields with new values from input fields
            // Note: ID remains unchanged
            u.setName(view.getUserNameField().getText().trim());
            u.setEmail(view.getUserEmailField().getText().trim());
            u.setPhone(view.getUserPhoneField().getText().trim());
            u.setStatus(view.getUserStatusCombo().getSelectedItem().toString());

            // Refresh display and clear input fields
            refreshTable();
            view.clearUserFields();
            JOptionPane.showMessageDialog(view, "Record updated successfully");

        } catch (Exception ex) {
            // Handle invalid input or update errors
            JOptionPane.showMessageDialog(view,
                    "Update failed. Check inputs.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    //  DELETE USER 
   
    private void deleteUser() {
        // Check if a row is selected
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to delete");
            return;
        }

        // Show confirmation dialog to prevent accidental deletion
        int confirm = JOptionPane.showConfirmDialog(
                view,
                "Are you sure you want to delete this item?",
                "Confirm",
                JOptionPane.YES_NO_OPTION
        );

        // If user confirms, remove user from list
        if (confirm == JOptionPane.YES_OPTION) {
            list.remove(row);
            refreshTable();
            view.clearUserFields();
            JOptionPane.showMessageDialog(view, "User deleted");
        }
    }

    //  TABLE CLICK 
    
    private void fillFieldsFromTable() {
        // Get selected row index
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) return; // No row selected

        // Get user at selected row
        UserModel u = list.get(row);
        
        // Populate all input fields with user's data
        view.getUserIdField().setText(u.getId());
        view.getUserNameField().setText(u.getName());
        view.getUserEmailField().setText(u.getEmail());
        view.getUserPhoneField().setText(u.getPhone());
        view.getUserStatusCombo().setSelectedItem(u.getStatus());
    }

    //  REFRESH TABLE 
   
    private void refreshTable() {
        DefaultTableModel model =
                (DefaultTableModel) view.getUserTable().getModel();

        // Clear all existing rows
        model.setRowCount(0);

        // Add all users from list to the table
        for (UserModel u : list) {
            model.addRow(new Object[]{
                u.getId(),
                u.getName(),
                u.getEmail(),
                u.getPhone()
                // Note: Status is not displayed in the table
            });
        }
    }
}