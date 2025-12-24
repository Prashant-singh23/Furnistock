/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.FurnitureModel;
import View.Dashboard;

import java.awt.event.*;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 * Controller class for managing furniture inventory operations.
 * Implements MVC pattern by handling user interactions and updating the model and view.
 */
public class FurnitureController implements ActionListener {

    // Reference to the Dashboard view
    private Dashboard view;
    
    // List to store all furniture items
    private ArrayList<FurnitureModel> list;
    
    // Counter to generate unique IDs for new furniture items
    private int nextId;

    
    public FurnitureController(Dashboard view) {
        this.view = view;
        this.list = new ArrayList<>();
        this.nextId = 6; // Start ID from 6 (since initial data uses 1-5)

        // Load initial furniture data into the list
        loadInitialData();

        // Register action listeners for the three main buttons
        view.getBtnAdd().addActionListener(this);
        view.getBtnUpdate().addActionListener(this);
        view.getBtnDelete().addActionListener(this);

        // Add mouse listener to handle table row selection
        view.getTable().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                // When a row is clicked, populate input fields with that row's data
                fillFieldsFromTable();
            }
        });
    }

    
    private void loadInitialData() {
        list.add(new FurnitureModel(1, "Ergonomic Chair", "Chair", "Rs. 4,500", 12));
        list.add(new FurnitureModel(2, "King Size Bed", "Bed", "Rs. 45,000", 5));
        list.add(new FurnitureModel(3, "Leather Sofa", "Sofa", "Rs. 35,000", 8));
        list.add(new FurnitureModel(4, "Wooden Cupboard", "Cupboard", "Rs. 25,000", 4));
        list.add(new FurnitureModel(5, "Wall Rack", "Rack", "Rs. 2,500", 20));
        
        // Update both dashboard and stock tables with initial data
        refreshAllTables();
    }

    // ACTION HANDLING
   
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == view.getBtnAdd()) {
            addFurniture();
        } 
        else if (e.getSource() == view.getBtnUpdate()) {
            updateFurniture();
        } 
        else if (e.getSource() == view.getBtnDelete()) {
            deleteFurniture();
        }
    }

    //ADD
    
    private void addFurniture() {
        try {
            // Get and trim input values from view fields
            String name = view.getNameField().getText().trim();
            String category = view.getCategoryField().getText().trim();
            String price = view.getPriceField().getText().trim();
            int qty = Integer.parseInt(view.getQtyField().getText().trim());

            // Create new furniture model with auto-incremented ID
            FurnitureModel f = new FurnitureModel(
                    nextId++, // Use current ID and increment for next item
                    name,
                    category,
                    price,
                    qty
            );

            // Add to list and update display
            list.add(f);
            refreshAllTables();
            view.clearFields();

            // Show success message
            JOptionPane.showMessageDialog(view, "Furniture added successfully");

        } catch (Exception ex) {
            // Handle invalid input (e.g., non-numeric quantity)
            JOptionPane.showMessageDialog(view,
                    "Invalid input. Please check all fields.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    // UPDATE
  
    private void updateFurniture() {
        // Check if a row is selected
        int row = view.getTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to update");
            return;
        }

        try {
            // Get the furniture item at the selected row
            FurnitureModel f = list.get(row);
            
            // Update all fields with new values from input fields
            f.setName(view.getNameField().getText().trim());
            f.setCategory(view.getCategoryField().getText().trim());
            f.setPrice(view.getPriceField().getText().trim());
            f.setQuantity(Integer.parseInt(view.getQtyField().getText().trim()));

            // Refresh display and clear input fields
            refreshAllTables();
            view.clearFields();
            JOptionPane.showMessageDialog(view, "Record updated successfully");

        } catch (Exception ex) {
            // Handle invalid input or update errors
            JOptionPane.showMessageDialog(view,
                    "Update failed. Check inputs.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
    }

    //  DELETE 
   
    private void deleteFurniture() {
        // Check if a row is selected
        int row = view.getTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to delete");
            return;
        }

        // Show confirmation dialog
        int confirm = JOptionPane.showConfirmDialog(
                view,
                "Are you sure you want to delete this item?",
                "Confirm",
                JOptionPane.YES_NO_OPTION
        );

        // If user confirms, remove item from list
        if (confirm == JOptionPane.YES_OPTION) {
            list.remove(row);
            refreshAllTables();
            view.clearFields();
            JOptionPane.showMessageDialog(view, "Furniture deleted");
        }
    }

   
    private void fillFieldsFromTable() {
        // Get selected row index
        int row = view.getTable().getSelectedRow();
        if (row == -1) return; // No row selected

        // Get furniture item at selected row
        FurnitureModel f = list.get(row);
        
        // Populate input fields with item's data
        view.getNameField().setText(f.getName());
        view.getCategoryField().setText(f.getCategory());
        view.getPriceField().setText(f.getPrice());
        view.getQtyField().setText(String.valueOf(f.getQuantity()));
    }

    //  REFRESH ALL TABLES 
   
    private void refreshAllTables() {
        refreshDashboardTable();
        refreshStockTable();
    }

   
    private void refreshDashboardTable() {
        DefaultTableModel model =
                (DefaultTableModel) view.getTable().getModel();

        // Clear existing rows
        model.setRowCount(0);

        // Add all furniture items to the table
        for (FurnitureModel f : list) {
            model.addRow(new Object[]{
                f.getId(),
                f.getName(),
                f.getCategory(),
                f.getPrice(),
                f.getQuantity()
            });
        }
    }

   
    private void refreshStockTable() {
        DefaultTableModel model =
                (DefaultTableModel) view.getStockTable().getModel();

        // Clear existing rows
        model.setRowCount(0);

        // Add all furniture items to the stock table
        for (FurnitureModel f : list) {
            model.addRow(new Object[]{
                f.getId(),
                f.getCategory(),
                f.getPrice(),
                f.getQuantity()
            });
        }
    }
}