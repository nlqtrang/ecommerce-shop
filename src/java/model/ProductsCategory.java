/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ProductsCategoriesDAO;
import dal.ProductsDAO;
import dal.ProductsImagesDAO;
import dal.ProductsVariantsDAO;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductsCategory {
    private int id;
    private String name, image, description;
    private boolean isStored;
    private List<Product> listProducts;
    private List<ProductsImage> listImages;
    private List<ProductsVariant> listProductsVariants;
    

    public ProductsCategory() {
    }

    public ProductsCategory(int id, String name, String image, String description, boolean isStored) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.description = description;
        this.isStored = isStored;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isIsStored() {
        return isStored;
    }

    public void setIsStored(boolean isStored) {
        this.isStored = isStored;
    }

    public List<Product> getListProducts() {
        return listProducts;
    }

    public void setListProducts() {
        try {
            this.listProducts = new ProductsDAO().listProductsByProductsCategoryId(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<ProductsImage> getListImages() {
        return listImages;
    }

    public void setListImages() {
        try {
            this.listImages = new ProductsImagesDAO().listProductsImagesByProductsCategoryId(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<ProductsVariant> getListProductsVariants() {
        return listProductsVariants;
    }

    public void setListProductsVariants() {
        try {
            this.listProductsVariants = new ProductsVariantsDAO().listProductsVariantsByProductsCategoryId(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public double getMinPrice() {
        Product p = Collections.min(getListProducts(), (o1, o2) -> {
            return (int) (o1.getPrice()*(100-o1.getSalePrice())/100 - o2.getPrice()*(100-o2.getSalePrice())/100); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/LambdaBody
        });
        return p.getPrice()*(100-p.getSalePrice())/100;
    }
    
    public double getMinPriceOriginal() {
        Product p = Collections.min(getListProducts(), (o1, o2) -> {
            return (int) (o1.getPrice() - o2.getPrice()); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/LambdaBody
        });
        return p.getPrice();
    }

    public double getMaxPrice() {
        Product p = Collections.max(getListProducts(), (o1, o2) -> {
            return (int) (o1.getPrice()*(100-o1.getSalePrice())/100 - o2.getPrice()*(100-o2.getSalePrice())/100); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/LambdaBody
        });
        return p.getPrice()*(100-p.getSalePrice())/100;
    }
    
    public double getMaxPriceOriginal() {
        Product p = Collections.max(getListProducts(), (o1, o2) -> {
            return (int) (o1.getPrice() - o2.getPrice()); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/LambdaBody
        });
        return p.getPrice();
    }
    
    public double getSalePrice() {
        Product p = Collections.max(getListProducts(), (o1, o2) -> {
            return (int)(o1.getSalePrice() - o2.getSalePrice()); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/LambdaBody
        });
        return p.getSalePrice();
    }
    
    public int getQuantitySold() {
        try {
            return new ProductsCategoriesDAO().getQuantitySoldByProductsCategoryById(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public int getQuantity() {
        try {
            return new ProductsCategoriesDAO().getQuantityByProductsCategoryById(id);
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
