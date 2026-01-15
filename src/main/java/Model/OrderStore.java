package Model;

import java.util.ArrayList;
import java.util.List;

/**
 * OrderStore class acts as a centralized repository for storing
 * all customer orders in the FurniStock system.
 * It maintains two separate static lists to manage orders:
 * Each order is represented as an Object array (Object[]) containing
 * relevant information such as:
 *  {OrderID, CustomerID, FurnitureID, Quantity, TotalPrice, PaymentStatus, etc.}
 */
public class OrderStore {

    /**
     * List of pending or in-progress orders.
     * Admin or system users can view, update, or process these orders.
     */
    public static List<Object[]> orders = new ArrayList<>();

    /**
     * List of confirmed or completed orders (order history).
     * Provides a record of past sales for reporting, auditing,
     * or customer service purposes.
     */
    public static List<Object[]> confirmedOrders = new ArrayList<>();
}
