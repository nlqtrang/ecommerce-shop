/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ProductsImage {
    private int id;
    private ProductsCategory productsCategory;
    private String image;

    public ProductsImage() {
    }

    public ProductsImage(int id, ProductsCategory productsCategory, String image) {
        this.id = id;
        this.productsCategory = productsCategory;
        this.image = image;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    
}
