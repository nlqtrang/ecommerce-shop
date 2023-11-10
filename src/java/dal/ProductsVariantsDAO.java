/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductsCategory;
import model.ProductsVariant;
import model.ProductsVariantsValue;

/**
 *
 * @author DELL
 */
public class ProductsVariantsDAO extends DBContext {
    public ProductsVariant getProductsVariantById(int id) throws SQLException, ClassNotFoundException{
        
        String sql="SELECT * FROM products_variants WHERE id=?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsVariant s = new ProductsVariant();
            String name = rs.getNString("name");
            ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(rs.getInt("products_category_id"));
            String sku = rs.getString("sku");
            ProductsVariant s = new ProductsVariant(id, productsCategory, name, sku);
            return s;
        }
        return null;
    }
    
    public List<ProductsVariant> listProductsVariantsByProductsCategoryId(int id) throws SQLException, ClassNotFoundException{
        List<ProductsVariant> list = new ArrayList<>();
        String sql="SELECT * FROM products_variants WHERE products_category_id = ?;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            int pid = rs.getInt("id");
            String name = rs.getNString("name");
            ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(rs.getInt("products_category_id"));
            String sku = rs.getString("sku");
            ProductsVariant s = new ProductsVariant(pid, productsCategory, name, sku);
            list.add(s);
        }
        return list;
    }
        
    public int updateVariant(int id, String variant) {
        int generatedKey = 0;
        try {
            String name = variant.substring(0, variant.indexOf('(')).trim();
            String sku = variant.substring(variant.indexOf('(')+1, variant.indexOf(')')).trim();
            String checkSql = "SELECT * FROM products_variants WHERE products_category_id = ? AND sku = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            checkStm.setString(2, sku);
            ResultSet checkRs = checkStm.executeQuery();
            if (checkRs.next()) {
                // Dòng đã tồn tại, thực hiện cập nhật quantity
                String updateSql = "UPDATE products_variants SET name = ? WHERE products_category_id = ? AND sku = ?";
                PreparedStatement updateStm = connection.prepareStatement(updateSql, Statement.RETURN_GENERATED_KEYS);
                updateStm.setString(1, name);
                updateStm.setInt(2, id);
                updateStm.setString(3, sku);
                int affectedRows = updateStm.executeUpdate();

        // Check if the insert was successful
                if (affectedRows > 0) {
                    return checkRs.getInt("id");
                }
            } else {
                // Dòng chưa tồn tại, thực hiện insert
                String insertSql = "INSERT INTO products_variants (products_category_id, name, sku) VALUES (?, ?, ?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
                insertStm.setInt(1, id);
                insertStm.setString(2, name);
                insertStm.setString(3, sku);
                int affectedRows = insertStm.executeUpdate();

        // Check if the insert was successful
                if (affectedRows > 0) {
                    // Retrieve the generated key
                    ResultSet generatedKeys = insertStm.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        generatedKey = generatedKeys.getInt(1); // Assume the generated key is of type INT
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return generatedKey;
    }
}
