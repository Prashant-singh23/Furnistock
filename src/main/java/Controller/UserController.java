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
 * UserController handles all user-related operations in the FurniStock system.
 * 
 * Responsibilities include:
 *  - Adding new users
 *  - Updating existing user details
 *  - Deleting users
 *  - Populating input fields when a table row is selected
 *  - Refreshing the user table in the Admin Dashboard
 * 
 * Implements ActionListener to respond to button clicks in the Admin Dashboard.
 * Follows MVC design pattern to separate data (UserModel), UI (AdminDashBoard),
 * and logic (Controller).
 */
public class UserController implements ActionListener {

    // Reference to the Admin dashboard view
    private AdminDashBoard view;
    
    // List to store all user records in-memory
    private ArrayList<UserModel> list;
    
    // Counter to generate unique user IDs, starting from 1001
    private int nextId;

    /**
     * Constructor initializes the controller with a reference to the dashboard view.
     * Sets up button listeners for add, update, and delete actions,
     * and a mouse listener for table row selection.
     * 
     * @param view AdminDashBoard instance for UI interaction
     */
    public UserController(AdminDashBoard view) {
        this.view = view;
        this.list = new ArrayList<>();
        this.nextId = 1001; // Starting ID for new users

        // Register button action listeners
        view.getBtnAddUser().addActionListener(this);
        view.getBtnUpdateUser().addActionListener(this);
        view.getBtnDeleteUser().addActionListener(this);

        // Add mouse listener for table row selection
        view.getUserTable().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                fillFieldsFromTable(); // Populate input fields when a row is clicked
            }
        });
    }

    /**
     * Handles all button click actions for user management.
     * Determines which button was clicked and invokes the corresponding method.
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == view.getBtnAddUser()) {
            addUser(); // Add new user
        } 
        else if (e.getSource() == view.getBtnUpdateUser()) {
            updateUser(); // Update selected user
        } 
        else if (e.getSource() == view.getBtnDeleteUser()) {
            deleteUser(); // Delete selected user
        }
    }

    /**
     * Adds a new user to the system.
     * Generates a unique ID, collects input from UI, validates it,
     * adds the user to the list, refreshes the table, and clears input fields.
     */
    private void addUser() {
        try {
            // Generate unique user ID with "U" prefix
            String id = "U" + nextId++;

            // Read and trim input from UI fields
            String name = view.getUserNameField().getText().trim();
            String email = view.getUserEmailField().getText().trim();
            String phone = view.getUserPhoneField().getText().trim();
            String status = view.getUserStatusCombo().getSelectedItem().toString();

            // Create new UserModel object
            UserModel u = new UserModel(id, name, email, phone, status);

            // Add user to list and refresh table
            list.add(u);
            refreshTable();
            view.clearUserFields();

            JOptionPane.showMessageDialog(view, "User added successfully");

        } catch (Exception ex) {
            // Handle invalid input gracefully
            JOptionPane.showMessageDialog(view,
                    "Invalid input. Please check all fields.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    /**
     * Updates the details of the selected user in the table.
     * Validates input and keeps the user ID unchanged.
     */
    private void updateUser() {
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to update");
            return;
        }

        try {
            UserModel u = list.get(row);

            // Update user details with trimmed input values
            u.setName(view.getUserNameField().getText().trim());
            u.setEmail(view.getUserEmailField().getText().trim());
            u.setPhone(view.getUserPhoneField().getText().trim());
            u.setStatus(view.getUserStatusCombo().getSelectedItem().toString());

            refreshTable();
            view.clearUserFields();
            JOptionPane.showMessageDialog(view, "Record updated successfully");

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(view,
                    "Update failed. Check inputs.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    /**
     * Deletes the selected user from the list after confirmation.
     */
    private void deleteUser() {
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to delete");
            return;
        }

        int confirm = JOptionPane.showConfirmDialog(view,
                "Are you sure you want to delete this item?",
                "Confirm",
                JOptionPane.YES_NO_OPTION);

        if (confirm == JOptionPane.YES_OPTION) {
            list.remove(row);
            refreshTable();
            view.clearUserFields();
            JOptionPane.showMessageDialog(view, "User deleted");
        }
    }

    /**
     * Populates input fields with data from the selected table row.
     * Allows easy editing of user information.
     */
    private void fillFieldsFromTable() {
        int row = view.getUserTable().getSelectedRow();
        if (row == -1) return;

        UserModel u = list.get(row);

        view.getUserIdField().setText(u.getId());
        view.getUserNameField().setText(u.getName());
        view.getUserEmailField().setText(u.getEmail());
        view.getUserPhoneField().setText(u.getPhone());
        view.getUserStatusCombo().setSelectedItem(u.getStatus());
    }

    /**
     * Refreshes the user table in the Admin Dashboard to reflect current data.
     */
    private void refreshTable() {
        DefaultTableModel model = (DefaultTableModel) view.getUserTable().getModel();
        model.setRowCount(0); // Clear existing rows

        for (UserModel u : list) {
            model.addRow(new Object[]{
                u.getId(),
                u.getName(),
                u.getEmail(),
                u.getPhone()
                // Status is managed internally and not displayed in table
            });
        }
    }
}
