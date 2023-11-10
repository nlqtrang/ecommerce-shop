/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductsCategory;
import model.ProductsInCartDTO;

public class CartsDAO extends DBContext {

    public int addProductsToCart(int userId, int productId, int quantity) throws SQLException, ClassNotFoundException {
        // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
        String checkSql = "SELECT * FROM carts WHERE users_id = ? AND product_id = ?";
        PreparedStatement checkStm = connection.prepareStatement(checkSql);
        checkStm.setInt(1, userId);
        checkStm.setInt(2, productId);
        ResultSet checkRs = checkStm.executeQuery();

        if (checkRs.next()) {
            // Dòng đã tồn tại, thực hiện cập nhật quantity
            int cartQuantity = checkRs.getInt("quantity");
            String updateSql = "UPDATE carts SET quantity = ? WHERE users_id = ? AND product_id = ?";
            PreparedStatement updateStm = connection.prepareStatement(updateSql);
            updateStm.setInt(1, quantity + cartQuantity);
            updateStm.setInt(2, userId);
            updateStm.setInt(3, productId);

            return updateStm.executeUpdate();
        } else {
            // Dòng chưa tồn tại, thực hiện insert
            String insertSql = "INSERT INTO carts (users_id, product_id, quantity) VALUES (?, ?, ?)";
            PreparedStatement insertStm = connection.prepareStatement(insertSql);
            insertStm.setInt(1, userId);
            insertStm.setInt(2, productId);
            insertStm.setInt(3, quantity);

            return insertStm.executeUpdate();
        }
    }
    
    public int updateProductsToCart(int userId, int productId, int quantity) throws SQLException, ClassNotFoundException {
        
            String updateSql = "UPDATE carts SET quantity = ? WHERE users_id = ? AND product_id = ?";
            PreparedStatement updateStm = connection.prepareStatement(updateSql);
            updateStm.setInt(1, quantity);
            updateStm.setInt(2, userId);
            updateStm.setInt(3, productId);

            return updateStm.executeUpdate();
        
    }
    
    public int deleteProductFromCart(int userId, int productId) throws SQLException, ClassNotFoundException {
    
        String deleteSql = "DELETE FROM carts WHERE users_id = ? AND product_id = ?";
        PreparedStatement deleteStm = connection.prepareStatement(deleteSql);
        deleteStm.setInt(1, userId);
        deleteStm.setInt(2, productId);

        return deleteStm.executeUpdate();
    }
    
    public int numberOfProductsInCart(int userId) throws SQLException, ClassNotFoundException {
        String checkSql = "SELECT count(*) count\n" +
                            "FROM carts c, products p\n" +
                            "WHERE c.users_id = ? and p.is_stored=0 and c.product_id=p.id and p.quantity>0";
        PreparedStatement checkStm = connection.prepareStatement(checkSql);
        checkStm.setInt(1, userId);
        ResultSet checkRs = checkStm.executeQuery();

        if (checkRs.next()) {
            

            return checkRs.getInt(1);
        } 
        return 0;
    }
    
    public List<ProductsInCartDTO> listProductsInCartByUserId(int id) {
        try {
            String checkSql = "select c.product_id, pc.id as productCategoryId, pc.image, pc.name, p.sku, p.sale_price, p.price, c.quantity, p.quantity as productQuantity, p.is_stored from carts c, products p, products_categories pc\n" +
                    "where c.users_id=? and p.id=c.product_id and pc.id=p.products_category_id";
            
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            ResultSet rs = checkStm.executeQuery();
            List<ProductsInCartDTO> list = new ArrayList<>();
            while (rs.next()) {
                
                int product_id=rs.getInt("product_id");
                int productCategoryid = rs.getInt("productCategoryId");
                String image = rs.getString("image");
                String name = rs.getNString("name");
                String sku = rs.getString("sku");
                double sale_price = rs.getDouble("sale_price");
                double price = rs.getDouble("price");
                int quan = rs.getInt("quantity");
                int p_quan = rs.getInt("productQuantity");
                boolean isStored = rs.getBoolean("is_stored");
                ProductsInCartDTO p = new ProductsInCartDTO(product_id, productCategoryid, image, name, sku, sale_price, price, quan,p_quan , isStored);
                list.add(p);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(CartsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public List<ProductsInCartDTO> listProductsCheckOut(int userId, String listIds) {
        List<ProductsInCartDTO> list = new ArrayList<>();
        try {
            String checkSql = "select c.product_id, pc.id as productCategoryId, pc.image, pc.name, p.sku, p.sale_price, p.price, c.quantity, p.quantity as productQuantity, p.is_stored from carts c, products p, products_categories pc\n" +
    "where c.users_id=? and p.id=c.product_id and pc.id=p.products_category_id and c.product_id in ("+ listIds +")";

            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, userId);
            ResultSet rs = checkStm.executeQuery();
            
            while (rs.next()) {
                int product_id=rs.getInt("product_id");
                int productCategoryid = rs.getInt("productCategoryId");
                String image = rs.getString("image");
                String name = rs.getNString("name"); 
                String sku = rs.getString("sku"); 
                double sale_price = rs.getDouble("sale_price"); 
                double price = rs.getDouble("price");
                int quan = rs.getInt("quantity");
                int p_quan = rs.getInt("productQuantity");
                boolean isStored = rs.getBoolean("is_stored");
                ProductsInCartDTO p = new ProductsInCartDTO(product_id, productCategoryid, image, name, sku, sale_price, price, quan,p_quan , isStored);
                list.add(p);
            }
        } catch (SQLException e) {
        }
        return list;
    }
    
    public int deleteProductFromCart(int userId, String listIds) {
    
        try {
            String deleteSql = "DELETE FROM carts WHERE users_id = ? AND product_id in ("+ listIds +")";
            PreparedStatement deleteStm = connection.prepareStatement(deleteSql);
            deleteStm.setInt(1, userId);
            
            return deleteStm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    

}
