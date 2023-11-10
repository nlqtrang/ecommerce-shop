/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ProductsDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Product {
    private int id;
    private ProductsCategory productsCategory;
    private String sku;
    private double price;
    private String image;
    private int quantity, quantitySold;
    private double salePrice;
    private boolean isStored;

    public Product() {
    }

    public Product(int id, ProductsCategory productsCategoryId, String sku, double price, String image, int quantity, int quantitySold, double salePrice, boolean isStored) {
        this.id = id;
        this.productsCategory = productsCategoryId;
        this.sku = sku;
        this.price = price;
        this.image = image;
        this.quantity = quantity;
        this.quantitySold = quantitySold;
        this.salePrice = salePrice;
        this.isStored = isStored;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProductsCategory getProductsCategory() {
        return productsCategory;
    }

    public void setProductsCategory(ProductsCategory productsCategory) {
        this.productsCategory = productsCategory;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public boolean isIsStored() {
        return isStored;
    }

    public void setIsStored(boolean isStored) {
        this.isStored = isStored;
    }
    

    
    
    
    
}
