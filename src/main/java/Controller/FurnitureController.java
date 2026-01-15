/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.FurnitureModel;
import View.AdminDashBoard;
import View.UserDashboard;

import java.awt.event.*;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 * FurnitureController class manages all CRUD operations for furniture items.
 * It follows the MVC architecture by interacting with the AdminDashBoard view
 * and updating the FurnitureModel data. It also synchronizes stock updates
 * with the UserDashboard and the global FurnitureStore.
 */
public class FurnitureController implements ActionListener {

    // Reference to the Admin dashboard view
    private AdminDashBoard view;

    // List to store all furniture items in memory
    private ArrayList<FurnitureModel> list;

    // Counter to generate unique IDs for new furniture items
    private int nextId;

    /**
     * Constructor initializes the controller with a reference to the Admin dashboard.
     * Registers event listeners for buttons and table clicks.
     * Loads initial demo data into the system.
     */
    public FurnitureController(AdminDashBoard view) {
        this.view = view;
        this.list = new ArrayList<>();
        this.nextId = 6; // Starting ID for new items

        loadInitialData();

        // Register action listeners for Add, Update, and Delete buttons
        view.getBtnAdd().addActionListener(this);
        view.getBtnUpdate().addActionListener(this);
        view.getBtnDelete().addActionListener(this);

        // Add mouse listener to populate input fields when a table row is clicked
        view.getTable().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                fillFieldsFromTable();
            }
        });
    }

    /**
     * Loads initial demo furniture data into the system.
     * Populates the internal list and refreshes the tables to display data.
     */
    private void loadInitialData() {
        list.add(new FurnitureModel(1, "Ergonomic Chair", "Chair", "Rs. 4,500", 12));
        list.add(new FurnitureModel(2, "King Size Bed", "Bed", "Rs. 45,000", 5));
        list.add(new FurnitureModel(3, "Leather Sofa", "Sofa", "Rs. 35,000", 8));
        list.add(new FurnitureModel(4, "Wooden Cupboard", "Cupboard", "Rs. 25,000", 4));
        list.add(new FurnitureModel(5, "Wall Rack", "Rack", "Rs. 2,500", 20));

        refreshAllTables();
    }

    /**
     * Handles all button actions: Add, Update, Delete.
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == view.getBtnAdd()) {
            addFurniture();
        } else if (e.getSource() == view.getBtnUpdate()) {
            updateFurniture();
        } else if (e.getSource() == view.getBtnDelete()) {
            deleteFurniture();
        }
    }

    /**
     * Checks if a furniture item already exists based on name and category.
     * @param name Furniture name
     * @param category Furniture category
     * @return true if duplicate exists, false otherwise
     */
    private boolean isDuplicate(String name, String category) {
        for (FurnitureModel f : list) {
            if (f.getName().equalsIgnoreCase(name)
                    && f.getCategory().equalsIgnoreCase(category)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Adds a new furniture item to the system.
     * Validates input, prevents duplicates, updates tables and global store.
     */
    private void addFurniture() {
        try {
            String name = view.getNameField().getText().trim();
            String category = view.getCategoryField().getText().trim();
            String price = view.getPriceField().getText().trim();
            int qty = Integer.parseInt(view.getQtyField().getText().trim());

            // Prevent adding duplicate items
            if (isDuplicate(name, category)) {
                JOptionPane.showMessageDialog(
                        view,
                        "Duplicate item!\nThis furniture already exists.",
                        "Duplication Error",
                        JOptionPane.ERROR_MESSAGE
                );
                return;
            }

            FurnitureModel f = new FurnitureModel(nextId++, name, category, price, qty);
            list.add(f);

            refreshAllTables();
            view.clearFields();

            JOptionPane.showMessageDialog(view, "Furniture added successfully");
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(
                    view,
                    "Invalid input. Please check all fields.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    /**
     * Updates the selected furniture item.
     * Validates input, prevents duplicate updates, and refreshes tables.
     */
    private void updateFurniture() {
        int row = view.getTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to update");
            return;
        }

        try {
            String name = view.getNameField().getText().trim();
            String category = view.getCategoryField().getText().trim();

            // Prevent duplication with other items
            for (int i = 0; i < list.size(); i++) {
                if (i != row) {
                    FurnitureModel other = list.get(i);
                    if (other.getName().equalsIgnoreCase(name)
                            && other.getCategory().equalsIgnoreCase(category)) {
                        JOptionPane.showMessageDialog(
                                view,
                                "Update would cause duplication!",
                                "Duplication Error",
                                JOptionPane.ERROR_MESSAGE
                        );
                        return;
                    }
                }
            }

            FurnitureModel f = list.get(row);
            f.setName(name);
            f.setCategory(category);
            f.setPrice(view.getPriceField().getText().trim());
            f.setQuantity(Integer.parseInt(view.getQtyField().getText().trim()));

            refreshAllTables();
            view.clearFields();
            JOptionPane.showMessageDialog(view, "Record updated successfully");
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(
                    view,
                    "Update failed. Check inputs.",
                    "Error",
                    JOptionPane.ERROR_MESSAGE
            );
        }
    }

    /**
     * Deletes the selected furniture item from the list and updates the tables.
     */
    private void deleteFurniture() {
        int row = view.getTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to delete");
            return;
        }

        int confirm = JOptionPane.showConfirmDialog(
                view,
                "Are you sure you want to delete this item?",
                "Confirm",
                JOptionPane.YES_NO_OPTION
        );

        if (confirm == JOptionPane.YES_OPTION) {
            list.remove(row);
            refreshAllTables();
            view.clearFields();
            JOptionPane.showMessageDialog(view, "Furniture deleted");
        }
    }

    /**
     * Fills input fields when a table row is clicked.
     */
    private void fillFieldsFromTable() {
        int row = view.getTable().getSelectedRow();
        if (row == -1) return;

        FurnitureModel f = list.get(row);
        view.getNameField().setText(f.getName());
        view.getCategoryField().setText(f.getCategory());
        view.getPriceField().setText(f.getPrice());
        view.getQtyField().setText(String.valueOf(f.getQuantity()));
    }

    /**
     * Refreshes all tables in the Admin and User dashboards and syncs with global store.
     */
    private void refreshAllTables() {
        refreshDashboardTable();
        refreshStockTable();
        syncWithGlobalStore();
        refreshUserDashboard();
    }

    // Refreshes the main Admin table
    private void refreshDashboardTable() {
        DefaultTableModel model = (DefaultTableModel) view.getTable().getModel();
        model.setRowCount(0);
        for (FurnitureModel f : list) {
            model.addRow(new Object[]{f.getId(), f.getName(), f.getCategory(), f.getPrice(), f.getQuantity()});
        }
    }

    // Refreshes the stock table
    private void refreshStockTable() {
        DefaultTableModel model = (DefaultTableModel) view.getStockTable().getModel();
        model.setRowCount(0);
        for (FurnitureModel f : list) {
            model.addRow(new Object[]{f.getId(), f.getCategory(), f.getPrice(), f.getQuantity()});
        }
    }

    // Synchronizes the internal list with the global FurnitureStore
    private void syncWithGlobalStore() {
        Model.FurnitureStore.stockList.clear();
        for (FurnitureModel f : list) {
            Object[] item = {f.getId(), f.getName(), f.getCategory(), f.getPrice(), f.getQuantity()};
            Model.FurnitureStore.stockList.add(item);
        }
    }

    // Refreshes the UserDashboard to reflect real-time stock updates
    private void refreshUserDashboard() {
        if (UserDashboard.instance != null) {
            UserDashboard.instance.loadStockFromAdmin();
        }
    }
}
