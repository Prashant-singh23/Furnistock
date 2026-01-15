/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;
import java.util.Queue;

public class FurnitureStore {
    // Shared list accessible by both Admin and User dashboards
    public static List<Object[]> stockList = new ArrayList<>();
    public static Queue<Object[]> recentItems = new LinkedList<>(); 
    // Initialize with default data (moved from your AdminDashBoard)
    static {
    // Format MUST be: {ID, Name, Category, Price, Qty} (5 items)
    stockList.add(new Object[]{1, "Ergonomic Chair", "Chair", "Rs. 4,500", 12});
    stockList.add(new Object[]{2, "King Size Bed", "Bed", "Rs. 45,000", 5});
    stockList.add(new Object[]{3, "Leather Sofa", "Sofa", "Rs. 35,000", 8});
    stockList.add(new Object[]{4, "Wooden Cupboard", "Cupboard", "Rs. 25,000", 4});
    stockList.add(new Object[]{5, "Wall Rack", "Rack", "Rs. 2,500", 20});

    }
}