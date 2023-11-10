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
import model.Product;
import model.ProductsCategory;
import model.ProductsImage;


public class ProductsImagesDAO extends DBContext {
    public List<ProductsImage> listProductsImagesByProductsCategoryId(int id) throws SQLException, ClassNotFoundException{
        List<ProductsImage> list = new ArrayList<>();
        String sql="SELECT * FROM products_images WHERE products_category_id = ?;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsImage s = new ProductsImage();
            ProductsCategory productsCategory = new ProductsCategoriesDAO().getProductsCategoryById(id);
            String image = rs.getString("image");
            ProductsImage s = new ProductsImage(id, productsCategory, image);
            list.add(s);
        }
        return list;
    }
}
