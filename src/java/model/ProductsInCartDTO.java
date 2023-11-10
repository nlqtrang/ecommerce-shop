/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ProductsDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductsInCartDTO {
    private int id;
    private int productCategoryId;
    private String image;
    private String name;
    private String sku;
    private double priceSale;
    private double priceOriginal;
    private int quantity;
    private int productQuantity;
    private boolean isStored;

    public ProductsInCartDTO() {
    }

    public ProductsInCartDTO(int id, int productCategoryId, String image, String name, String sku, double priceSale, double priceOriginal, int quantity, int productQuantity, boolean isStored) {
        this.id=id;
        this.productCategoryId=productCategoryId;
        this.image = image;
        this.name = name;
        this.sku=sku;
        this.priceSale = priceSale;
        this.priceOriginal = priceOriginal;
        this.quantity = quantity;
        this.productQuantity=productQuantity;
        this.isStored=isStored;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(int productCategoryId) {
        this.productCategoryId = productCategoryId;
    }
    
    

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
    
    

    public double getPriceSale() {
        return priceSale;
    }

    public void setPriceSale(double priceSale) {
        this.priceSale = priceSale;
    }

    public double getPriceOriginal() {
        return priceOriginal;
    }

    public void setPriceOriginal(double priceOriginal) {
        this.priceOriginal = priceOriginal;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    public boolean isIsStored() {
        return isStored;
    }

    public void setIsStored(boolean isStored) {
        this.isStored = isStored;
    }
    
    
    
    public String getVariantName() {
        if (sku==null)
            return "";
        try {
            String name1 =  new ProductsDAO().getNameOfProduct(id, sku);
            if (name1.equals(""))
                return "";
            return name1;
        } catch (SQLException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
    }
    
    public double getPrice() {
        return priceOriginal*(100-priceSale)/100;
    }
    
    public double getTotal() {
        return getPrice()*getQuantity();
    }

    @Override
    public String toString() {
        return "ProductsInCartDTO{" + "id=" + id + ", image=" + image + ", name=" + name + ", sku=" + sku + ", priceSale=" + priceSale + ", priceOriginal=" + priceOriginal + ", quantity=" + quantity + ", productQuantity=" + productQuantity + ", isStored=" + isStored + '}';
    }
    
    
           
}
