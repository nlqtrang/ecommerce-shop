/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ProductsCategoryDTO {
    private int id;
    private String name, image;
    private boolean isStored;
    private double minPrice, maxPrice, salePrice;
    private int soldQuantity;
    private int quantity;

    public ProductsCategoryDTO() {
    }

    public ProductsCategoryDTO(int id, String name, String image, boolean isStored, double minPrice, double maxPrice, double salePrice, int soldQuantity, int quantity) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.isStored = isStored;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
        this.salePrice = salePrice;
        this.soldQuantity = soldQuantity;
        this.quantity = quantity;
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isIsStored() {
        return isStored;
    }

    public void setIsStored(boolean isStored) {
        this.isStored = isStored;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
    
    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
