/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ProductsVariantsValuesDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class ProductsVariant {
    private int id;
    private ProductsCategory productsCategory;
    private String name;
    private String sku;
    private List<ProductsVariantsValue> listProductsVariantsValues;

    public ProductsVariant() {
    }

    public ProductsVariant(int id, ProductsCategory productsCategory, String name, String sku) {
        this.id = id;
        this.productsCategory = productsCategory;
        this.name = name;
        this.sku = sku;
        
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


    public List<ProductsVariantsValue> getListProductsVariantsValues() {
        setListProductsVariantsValues();
        return listProductsVariantsValues;
    }

    public void setListProductsVariantsValues() {
        try {
            listProductsVariantsValues = new ProductsVariantsValuesDAO().listProductsVariantsValuesByProductsVariantId(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsVariant.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsVariant.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    
    
}
