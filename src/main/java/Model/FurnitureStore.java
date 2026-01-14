/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;
import java.util.List;

public class FurnitureStore {
    // Shared list accessible by both Admin and User dashboards
    public static List<Object[]> stockList = new ArrayList<>();

    // Initialize with default data (moved from your AdminDashBoard)
    static {
        stockList.add(new Object[]{101, "Chair", "Rs. 4,500", 12});
        stockList.add(new Object[]{102, "Bed", "Rs. 45,000", 5});
        stockList.add(new Object[]{103, "Sofa", "Rs. 35,000", 8});
        stockList.add(new Object[]{104, "Cupboard", "Rs. 25,000", 4});
        stockList.add(new Object[]{105, "Rack", "Rs. 2,500", 20});
    }
}