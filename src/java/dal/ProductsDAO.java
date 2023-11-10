/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductsCategory;

public class ProductsDAO extends DBContext {

    public List<Product> listProductsByProductsCategoryId(int id) throws SQLException, ClassNotFoundException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE products_category_id = ?;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        //5. Process Result
        while (rs.next()) {
            //Product s = new Product();
            int pid = rs.getInt("id");
            ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(id);
            String sku = rs.getString("sku");
            double price = rs.getDouble("price");
            String image = rs.getString("image");
            int quan = rs.getInt("quantity");
            int quanSold = rs.getInt("quantity_sold");
            double sale = rs.getDouble("sale_price");
            boolean isStored = rs.getBoolean("is_stored");
            Product s = new Product(pid, productsCategory, sku, price, image, quan, quanSold, sale, isStored);
            list.add(s);
        }
        return list;
    }

    public int getProductIdByProductsCategoryIdAndSku(int id, String sku) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id\n"
                + "FROM products WHERE products_category_id=? and sku=?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        stm.setString(2, sku);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            //Product s = new Product();
            int pid = rs.getInt("id");
            return pid;
        }
        return -1;
    }

    public int getProductIdByProductsCategoryIdAndSku(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id\n"
                + "FROM products WHERE products_category_id=? and sku is null";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            //Product s = new Product();
            int pid = rs.getInt("id");
            return pid;
        }
        return -1;
    }

    public List<String> getSkuLeftIsStored(String id, String[] variants) throws SQLException, ClassNotFoundException {
        List<String> list = new ArrayList<>();
        String sku = "";
        for (String variant : variants) {
            sku += "%" + variant;
        }
        sku += "%";
        String sql = "Select * from products\n"
                + "where products_category_id=? and sku like ? and (is_stored=1 or quantity=0)";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, id);
        stm.setString(2, sku);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            //Product s = new Product();
            String psku = rs.getString("sku");
            String[] pskus = psku.split("\\$");
            for (String psku1 : pskus) {
                boolean kt = false;
                for (String variant : variants) {
                    if (variant.equals(psku1)) {
                        kt = true;
                    }
                }
                if (kt == false) {
                    list.add(psku1);
                }
            }

        }
        return list;

    }

    public Product getProductBySku(String id, String sku) throws SQLException, ClassNotFoundException {

        String sql = "Select * from products\n"
                + "where products_category_id=? and sku = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, id);
        stm.setString(2, sku);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            //Product s = new Product();
            int pid = rs.getInt("id");
            ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(Integer.parseInt(id));
            double price = rs.getDouble("price");
            String image = rs.getString("image");
            int quan = rs.getInt("quantity");
            int quanSold = rs.getInt("quantity_sold");
            double sale = rs.getDouble("sale_price");
            boolean isStored = rs.getBoolean("is_stored");
            Product s = new Product(pid, productsCategory, sku, price, image, quan, quanSold, sale, isStored);
            return s;

        }
        return null;

    }

    public Map<String, Product> mapProductsByProductsCategoryId(String id) {
        Map<String, Product> map = new HashMap<>();
        try {

            String sql = "Select * from products\n"
                    + "where products_category_id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                //Product s = new Product();
                int pid = rs.getInt("id");
                ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(Integer.parseInt(id));
                String sku = rs.getString("sku");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                int quan = rs.getInt("quantity");
                int quanSold = rs.getInt("quantity_sold");
                double sale = rs.getDouble("sale_price");
                boolean isStored = rs.getBoolean("is_stored");
                Product s = new Product(pid, productsCategory, sku, price, image, quan, quanSold, sale, isStored);
                map.put(sku, s);

            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return map;
    }

    public String getNameOfProduct(int id, String sku) throws SQLException, ClassNotFoundException {
        String result = "";
        String[] skus = sku.split("\\$");
        for (String sku1 : skus) {
            String sql = "select pv.name as variantName, prv.name as valueName from products p, products_variants pv, products_variants_values prv\n"
                    + "where p.id=" + id + " and p.products_category_id=pv.products_category_id and pv.id=prv.products_variant_id and (pv.sku+'_'+prv.sku) = '" + sku1 + "'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                //Product s = new Product();
                String variantName = rs.getNString("variantName");
                String valueName = rs.getNString("valueName");
                result += variantName + " " + valueName + " ";
            }
        }

        return result;
    }

    public int updateProduct(int id, String sku, String price, String image, String quantity, String salePrice, String isStored) throws SQLException, ClassNotFoundException{
        
            // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
            String checkSql = "SELECT * FROM products WHERE products_category_id = ? AND sku = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            checkStm.setString(2, sku);
            ResultSet checkRs = checkStm.executeQuery();
            boolean b = Boolean.parseBoolean(isStored);
            if (checkRs.next()) {
                // Dòng đã tồn tại, thực hiện cập nhật quantity
                String updateSql;
                if (image == null || image.isEmpty()) {
                    updateSql = "UPDATE products SET price = ?, quantity=?, sale_price=?, is_stored=? WHERE products_category_id = ? AND sku = ?";
                    PreparedStatement updateStm = connection.prepareStatement(updateSql);
                    updateStm.setDouble(1, Double.parseDouble(price));
                    updateStm.setInt(2, Integer.parseInt(quantity));
                    updateStm.setDouble(3, Double.parseDouble(salePrice));
                    updateStm.setBoolean(4, b);
                    updateStm.setInt(5, id);
                    updateStm.setString(6, sku);

                    return updateStm.executeUpdate();
                } else {
                    updateSql = "UPDATE products SET price = ?, image=?, quantity=?, sale_price=?, is_stored=? WHERE products_category_id = ? AND sku = ?";
                    PreparedStatement updateStm = connection.prepareStatement(updateSql);
                    updateStm.setDouble(1, Double.parseDouble(price));
                    updateStm.setString(2, image);
                    updateStm.setInt(3, Integer.parseInt(quantity));
                    updateStm.setDouble(4, Double.parseDouble(salePrice));
                    updateStm.setBoolean(5, b);
                    updateStm.setInt(6, id);
                    updateStm.setString(7, sku);

                    return updateStm.executeUpdate();
                }
            } else {
                // Dòng chưa tồn tại, thực hiện insert
                String insertSql = "INSERT INTO products (products_category_id, sku, price, image, quantity, quantity_sold, sale_price, is_stored) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                insertStm.setInt(1, id);
                insertStm.setString(2, sku);
                insertStm.setDouble(3, Double.parseDouble(price));
                insertStm.setString(4, image);
                insertStm.setInt(5, Integer.parseInt(quantity));
                insertStm.setInt(6, 0);
                insertStm.setDouble(7, Double.parseDouble(salePrice));
                insertStm.setBoolean(8, b);
                return insertStm.executeUpdate();
            }
        
    }
    
    public int updateProductIfSkuIsNull(int id, String price, String image, String quantity, String salePrice, String isStored) throws SQLException, ClassNotFoundException{
        
            // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
            String checkSql = "SELECT * FROM products WHERE products_category_id = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            ResultSet checkRs = checkStm.executeQuery();
            boolean b = Boolean.parseBoolean(isStored);
            if (checkRs.next()) {
                // Dòng đã tồn tại, thực hiện cập nhật quantity
                String updateSql;
                if (image == null || image.isEmpty()) {
                    updateSql = "UPDATE products SET price = ?, quantity=?, sale_price=?, is_stored=? WHERE products_category_id = ?";
                    PreparedStatement updateStm = connection.prepareStatement(updateSql);
                    updateStm.setDouble(1, Double.parseDouble(price));
                    updateStm.setInt(2, Integer.parseInt(quantity));
                    updateStm.setDouble(3, Double.parseDouble(salePrice));
                    updateStm.setBoolean(4, b);
                    updateStm.setInt(5, id);

                    return updateStm.executeUpdate();
                } else {
                    updateSql = "UPDATE products SET price = ?, image=?, quantity=?, sale_price=?, is_stored=? WHERE products_category_id = ?";
                    PreparedStatement updateStm = connection.prepareStatement(updateSql);
                    updateStm.setDouble(1, Double.parseDouble(price));
                    updateStm.setString(2, image);
                    updateStm.setInt(3, Integer.parseInt(quantity));
                    updateStm.setDouble(4, Double.parseDouble(salePrice));
                    updateStm.setBoolean(5, b);
                    updateStm.setInt(6, id);

                    return updateStm.executeUpdate();
                }
            } else {
                // Dòng chưa tồn tại, thực hiện insert
                String insertSql = "INSERT INTO products (products_category_id, price, image, quantity, quantity_sold, sale_price, is_stored) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                insertStm.setInt(1, id);
                insertStm.setDouble(2, Double.parseDouble(price));
                insertStm.setString(3, image);
                insertStm.setInt(4, Integer.parseInt(quantity));
                insertStm.setInt(5, 0);
                insertStm.setDouble(6, Double.parseDouble(salePrice));
                insertStm.setBoolean(7, b);
                return insertStm.executeUpdate();
            }
        
    }
    
    public int updateProductStored(int id, String notStored){
        
        try {
            // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
            
            String updateSql = "UPDATE products SET is_stored=1 WHERE products_category_id = ? and sku not in ("+notStored+")";
            
            PreparedStatement updateStm = connection.prepareStatement(updateSql);
            updateStm.setInt(1, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    public int updateProductStoredIfSkuIsNull(int id){
        
        try {
            // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
            
            String updateSql = "UPDATE products SET is_stored=true WHERE products_category_id = ?";
            
            PreparedStatement updateStm = connection.prepareStatement(updateSql);
            updateStm.setInt(1, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
