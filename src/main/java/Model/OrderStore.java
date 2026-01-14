/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.util.ArrayList;
import java.util.List;

public class OrderStore {
    public static List<Object[]> orders = new ArrayList<>();          // Pending
    public static List<Object[]> confirmedOrders = new ArrayList<>(); // History <--- ADD THIS
}