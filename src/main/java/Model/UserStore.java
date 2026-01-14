/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.util.ArrayList;
import java.util.List;

public class UserStore {
    public static List<Object[]> users = new ArrayList<>();
    private static int nextId = 6; // New users will start from 6

    // This block runs once as soon as the app starts
    static {
        users.add(new Object[]{1, "user1", "user1@gmail.com", "9867456345"});
        users.add(new Object[]{2, "user2", "user2@gmail.com", "9812345672"});
        users.add(new Object[]{3, "user3", "user3@gmail.com", "9848290200"});
        users.add(new Object[]{4, "user4", "user4@gmail.com", "9845672345"});
        users.add(new Object[]{5, "user5", "user5@gmail.com", "9812347658"});
    }

    public static int generateId() {
        return nextId++;
    }
}