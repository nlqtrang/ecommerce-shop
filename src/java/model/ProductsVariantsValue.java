/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class ProductsVariantsValue {
    private int id;
    private ProductsVariant productsVariant;
    private String name, sku;

    public ProductsVariantsValue() {
    }

    public ProductsVariantsValue(int id, ProductsVariant productsVariant, String name, String sku) {
        this.id = id;
        this.productsVariant = productsVariant;
        this.name = name;
        this.sku = sku;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProductsVariant getProductsVariant() {
        return productsVariant;
    }

    public void setProductsVariant(ProductsVariant productsVariant) {
        this.productsVariant = productsVariant;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    
    
    
}
