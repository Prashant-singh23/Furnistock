/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 * Model class representing a furniture item in the inventory system.
 * This class follows private fields and public getter/setter methods.
 * Part of the MVC architecture as the data model.
 * 
 * @author MY PC
 */
public class FurnitureModel {
    
    // Unique identifier for the furniture item
    private int id;
    
    // Name/title of the furniture item (e.g., "Ergonomic Chair")
    private String name;
    
    // Category/type of furniture (e.g., "Chair", "Bed", "Sofa")
    private String category;
    
    // Price of the furniture item as a string (e.g., "Rs. 4,500")
    // Stored as String to preserve formatting with currency symbol
    private String price;
    
    // Quantity/stock available for this furniture item
    private int quantity;
    
    //CONSTRUCTOR 
   
    public FurnitureModel(int id, String name, String category, String price, int quantity) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
    }
    
    // GETTERS
   
    public int getId() {
        return id;
    }
    
   
    public String getName() {
        return name;
    }
    
    
    public String getCategory() {
        return category;
    }
    
    // Add these methods:
    public String getPrice() {
    return price;
}


    
   
    public int getQuantity() {
        return quantity;
    }
    
    //  SETTERS
    
    public void setId(int id) {
    this.id = id;
}
    public void setName(String name) {
        this.name = name;
    }
    
    
    public void setCategory(String category) {
        this.category = category;
    }
    
   public void setPrice(String price) {
    this.price = price;
}
    
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}