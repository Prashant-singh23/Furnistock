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


public class FurnitureController implements ActionListener {

    private Dashboard view;
    private ArrayList<FurnitureModel> list;
    private int nextId;

    public FurnitureController(Dashboard view) {
        this.view = view;
        this.list = new ArrayList<>();
        this.nextId = 6;

        loadInitialData();

        view.getBtnAdd().addActionListener(this);
        view.getBtnUpdate().addActionListener(this);
        view.getBtnDelete().addActionListener(this);

        view.getTable().addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                fillFieldsFromTable();
            }
        });
    }

    //  INITIAL DATA 
    private void loadInitialData() {
        list.add(new FurnitureModel(1, "Ergonomic Chair", "Chair", "Rs. 4,500", 12));
        list.add(new FurnitureModel(2, "King Size Bed", "Bed", "Rs. 45,000", 5));
        list.add(new FurnitureModel(3, "Leather Sofa", "Sofa", "Rs. 35,000", 8));
        list.add(new FurnitureModel(4, "Wooden Cupboard", "Cupboard", "Rs. 25,000", 4));
        list.add(new FurnitureModel(5, "Wall Rack", "Rack", "Rs. 2,500", 20));

        refreshAllTables();
    }

    //  ACTION HANDLER 
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

    //  DUPLICATION CHECK 
    private boolean isDuplicate(String name, String category) {
        for (FurnitureModel f : list) {
            if (f.getName().equalsIgnoreCase(name)
                    && f.getCategory().equalsIgnoreCase(category)) {
                return true;
            }
        }
        return false;
    }

    //  ADD
    private void addFurniture() {
        try {
            String name = view.getNameField().getText().trim();
            String category = view.getCategoryField().getText().trim();
            String price = view.getPriceField().getText().trim();
            int qty = Integer.parseInt(view.getQtyField().getText().trim());

            // DUPLICATION CHECK
            if (isDuplicate(name, category)) {
                JOptionPane.showMessageDialog(
                        view,
                        "Duplicate item!\nThis furniture already exists.",
                        "Duplication Error",
                        JOptionPane.ERROR_MESSAGE
                );
                return;
            }

            FurnitureModel f = new FurnitureModel(
                    nextId++,
                    name,
                    category,
                    price,
                    qty
            );

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

    // UPDATE 
    private void updateFurniture() {
        int row = view.getTable().getSelectedRow();
        if (row == -1) {
            JOptionPane.showMessageDialog(view, "Select a row to update");
            return;
        }

        try {
            String name = view.getNameField().getText().trim();
            String category = view.getCategoryField().getText().trim();

            // DUPLICATION CHECK (ignore current record)
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

    //  DELETE
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

    //  TABLE CLICK 
    private void fillFieldsFromTable() {
        int row = view.getTable().getSelectedRow();
        if (row == -1) return;

        FurnitureModel f = list.get(row);
        view.getNameField().setText(f.getName());
        view.getCategoryField().setText(f.getCategory());
        view.getPriceField().setText(f.getPrice());
        view.getQtyField().setText(String.valueOf(f.getQuantity()));
    }

    //  REFRESH TABLES 
    private void refreshAllTables() {
        refreshDashboardTable();
        refreshStockTable();
    }

    private void refreshDashboardTable() {
        DefaultTableModel model =
                (DefaultTableModel) view.getTable().getModel();
        model.setRowCount(0);

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
        model.setRowCount(0);

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
