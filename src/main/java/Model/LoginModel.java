/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 * Model class representing user login credentials.
 * This class encapsulates username and password data for authentication purposes.
 * 
 * 
 * @author MY PC
 */
public class LoginModel {
    
    // Username entered by the user for authentication
    private String username;
    
    // Password entered by the user for authentication
    // passwords should be hashed and not stored as plain text
    private String password;
    
    //  CONSTRUCTOR 
   
    public LoginModel(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    //  GETTERS 
    
    public String getUsername() {
        return username;
    }
    
   
    public String getPassword() {
        return password;
    }
    
    // Note: No setters provided - credentials are set once during construction
    // and should not be modified after creation for security reasons
}