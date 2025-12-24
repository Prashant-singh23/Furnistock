/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 * Model class representing a user in the system.
 * This class follows private fields and public getter/setter methods.
 * 
 * Users have a unique ID, personal information (name, email, phone), and a status.
 */
public class UserModel {
    
    // Unique identifier for the user (e.g., "U1001", "U1002")
    // Generated with "U" prefix followed by incrementing number
    private String id;
    
    // Full name of the user
    private String name;
    
    // Email address of the user
    private String email;
    
    // Phone/contact number of the user
    private String phone;
    
    // Current status of the user (e.g., "Active", "Inactive")
    // Used to track whether the user account is currently active
    private String status;
    
    //  CONSTRUCTOR 
    
    public UserModel(String id, String name, String email, String phone, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.status = status;
    }
    
    //  GETTERS METHOD
    
    public String getId() {
        return id;
    }
    
   
    public String getName() {
        return name;
    }
    
    
    public String getEmail() {
        return email;
    }
    
    
    public String getPhone() {
        return phone;
    }
    
    
    public String getStatus() {
        return status;
    }
    
    //  SETTERS METHOD
    
    public void setName(String name) {
        this.name = name;
    }
    
   
    public void setEmail(String email) {
        this.email = email;
    }
    
   
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    // Note: No setter for ID - the user ID is immutable once created
    // This prevents accidental modification of the unique identifier
}