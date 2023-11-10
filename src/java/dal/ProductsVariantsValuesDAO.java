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
import model.ProductsImage;
import model.ProductsVariant;
import model.ProductsVariantsValue;

/**
 *
 * @author DELL
 */
public class ProductsVariantsValuesDAO extends DBContext {
    public List<ProductsVariantsValue> listProductsVariantsValuesByProductsVariantId(int id) throws SQLException, ClassNotFoundException{
        List<ProductsVariantsValue> list = new ArrayList<>();
        String sql="SELECT * FROM products_variants_values WHERE products_variant_id = ?;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            
            int pid = rs.getInt("id");
            String name = rs.getNString("name");
            ProductsVariant productsVariant = new ProductsVariantsDAO().getProductsVariantById(rs.getInt("products_variant_id"));
            String sku = rs.getString("sku");
            ProductsVariantsValue s = new ProductsVariantsValue(id, productsVariant, name, sku);
            list.add(s);
        }
        return list;
    }
    
    public int updateVariantsValue(int id, String option) {
        try {
            String name = option.substring(0, option.indexOf('(')).trim();
            String sku = option.substring(option.indexOf('(')+1, option.indexOf(')')).trim();
            String checkSql = "SELECT * FROM products_variants_values WHERE products_variant_id = ? AND sku = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            checkStm.setString(2, sku);
            ResultSet checkRs = checkStm.executeQuery();
            if (checkRs.next()) {
                // Dòng đã tồn tại, thực hiện cập nhật quantity
                String updateSql = "UPDATE products_variants_values SET name = ? WHERE products_variant_id = ? AND sku = ?";
                PreparedStatement updateStm = connection.prepareStatement(updateSql);
                updateStm.setString(1, name);
                updateStm.setInt(2, id);
                updateStm.setString(3, sku);
                return updateStm.executeUpdate();

            } else {
                // Dòng chưa tồn tại, thực hiện insert
                String insertSql = "INSERT INTO products_variants_values (products_variant_id, name, sku) VALUES (?, ?, ?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                insertStm.setInt(1, id);
                insertStm.setString(2, name);
                insertStm.setString(3, sku);
                return insertStm.executeUpdate();

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
