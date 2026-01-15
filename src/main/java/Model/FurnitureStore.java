/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;
import java.util.Queue;

/**
 * FurnitureStore class acts as a centralized, shared data repository
 * for the FurniStock system. It maintains the inventory data
 * that is accessible by both Admin and User dashboards.
 * 
 * This class uses static collections to ensure that there is a single
 * source of truth for stock data across the application.
 * 
 * By using static members, all instances of views and controllers
 * access the same inventory data in real time.
 */
public class FurnitureStore {

    /**
     * Shared list storing all furniture items.
     * Each element is an Object array with format:
     * {ID, Name, Category, Price, Quantity}
     * 
     * This list acts as the main data source for inventory operations,
     * ensuring consistency between Admin and User dashboards.
     */
    public static List<Object[]> stockList = new ArrayList<>();

    /**
     * Queue to track recently added or modified furniture items.
     * Can be used for notifications, quick-access lists, or undo functionality.
     */
    public static Queue<Object[]> recentItems = new LinkedList<>();

    /**
     * This ensures the application has sample data immediately after startup.
     */
    static {
        // Add default furniture items with format: {ID, Name, Category, Price, Quantity}
        stockList.add(new Object[]{1, "Ergonomic Chair", "Chair", "Rs. 4,500", 12});
        stockList.add(new Object[]{2, "King Size Bed", "Bed", "Rs. 45,000", 5});
        stockList.add(new Object[]{3, "Leather Sofa", "Sofa", "Rs. 35,000", 8});
        stockList.add(new Object[]{4, "Wooden Cupboard", "Cupboard", "Rs. 25,000", 4});
        stockList.add(new Object[]{5, "Wall Rack", "Rack", "Rs. 2,500", 20});
    }
}
