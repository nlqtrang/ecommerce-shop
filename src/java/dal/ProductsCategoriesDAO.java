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
import model.ProductsCategoryDTO;
import model.ProductsType;


/**
 *
 * @author DELL
 */
public class ProductsCategoriesDAO extends DBContext {
    public List<ProductsCategory> listProductsCategories() throws SQLException, ClassNotFoundException{
        List<ProductsCategory> list = new ArrayList<>();
        String sql="SELECT * FROM products_categories;";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsCategory s = new ProductsCategory();
            int id = rs.getInt("id");
            String name = rs.getNString("name");
            String image = rs.getString("image");
            String desc = rs.getNString("description");
            boolean isStored = rs.getBoolean("is_stored");
            ProductsCategory s = new ProductsCategory(id, name, image, desc, isStored);
            list.add(s);
        }
        return list;
    }
    
    public List<ProductsCategoryDTO> listProductsCategoriesDTO() throws SQLException, ClassNotFoundException{
        List<ProductsCategoryDTO> list = new ArrayList<>();
        String sql="select h.id, h.name, h.image, h.is_stored, min(h.price) as [min_price], max(h.price) as [max_price], max(h.sale_price) as [sale_price],sum(h.quantity_sold) as [quantity_sold], sum(h.quantity) as [quantity]\n" +
                    "from (SELECT pc.id, pc.name, pc.image, pc.is_stored, p.price, p.sale_price, p.quantity_sold, p.quantity\n" +
                    "    from products p, products_categories pc\n" +
                    "    where p.products_category_id = pc.id) as h\n" +
                    "group by h.id, h.name, h.image, h.is_stored";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            
            ProductsCategoryDTO s = new ProductsCategoryDTO(
                    rs.getInt("id"), 
                    rs.getNString("name"), 
                    rs.getString("image"), 
                    rs.getBoolean("is_stored"), 
                    rs.getDouble("min_price"), 
                    rs.getDouble("max_price"), 
                    rs.getDouble("sale_price"), 
                    rs.getInt("quantity_sold"), 
                    rs.getInt("quantity"));
            list.add(s);
        }
        return list;
    }
    
    public List<ProductsCategoryDTO> listProductsCategoriesDTOBySearch(String search, String minPrice, String maxPrice, String sort, String category, int pageNumber){
        List<ProductsCategoryDTO> list = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            search=" and (pc.name LIKE N'%"+search+"%' OR pc.description LIKE N'%"+search+"%') \n";
        } else search="";
        if (minPrice != null && !minPrice.isEmpty()) {
            minPrice= " AND p.price >= "+minPrice;
        } else minPrice="";
        if (maxPrice != null && !maxPrice.isEmpty()) {
            maxPrice += " AND p.price <= "+maxPrice;
        } else maxPrice="";
        if (sort!=null && !sort.isEmpty()) {
            if (sort.equals("price-high")) {
                sort = " order by max_price desc";
            } else if (sort.equals("price-low")) {
                sort = " order by min_price";
            } else if (sort.equals("best-seller")) {
                sort = " order by quantity_sold desc";
            } else if (sort.equals("newest")) {
                sort = " order by id desc";
            }
        } else sort=" order by id";
        if (category!= null && !category.isEmpty()) {
            category = " , products_types_categories pth\n" +
"                    where pth.products_category_id=h.id and pth.products_type_id= " + category;
        } else category="";
        pageNumber = (pageNumber-1)*3;
        try {
            
            String sql="select h.id, h.name, h.image, h.is_stored, min(h.price) as [min_price], max(h.price) as [max_price], max(h.sale_price) as [sale_price],sum(h.quantity_sold) as [quantity_sold], sum(h.quantity) as [quantity]\n" +
"                    from (SELECT pc.id, pc.name, pc.image, pc.is_stored, p.price, p.sale_price, p.quantity_sold, p.quantity\n" +
"                        from products p, products_categories pc\n" +
"                        where p.products_category_id = pc.id\n" + search + minPrice + maxPrice +
"                    ) as h "+category+
"                    group by h.id, h.name, h.image, h.is_stored\n" + sort+
                        " OFFSET "+pageNumber+" ROWS FETCH NEXT 3 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            //5. Process Result
            while (rs.next()) {
                
                ProductsCategoryDTO s = new ProductsCategoryDTO(
                        rs.getInt("id"),
                        rs.getNString("name"),
                        rs.getString("image"),
                        rs.getBoolean("is_stored"),
                        rs.getDouble("min_price"),
                        rs.getDouble("max_price"),
                        rs.getDouble("sale_price"),
                        rs.getInt("quantity_sold"),
                        rs.getInt("quantity"));
                list.add(s);
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add this line for debugging
            Logger.getLogger(ProductsCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public List<ProductsCategoryDTO> listProductsCategoriesDTOBySearch(String search, String minPrice, String maxPrice, String sort, String category){
        List<ProductsCategoryDTO> list = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            search=" and (pc.name LIKE N'%"+search+"%' OR pc.description LIKE N'%"+search+"%') \n";
        } else search="";
        if (minPrice != null && !minPrice.isEmpty()) {
            minPrice= " AND p.price >= "+minPrice;
        } else minPrice="";
        if (maxPrice != null && !maxPrice.isEmpty()) {
            maxPrice += " AND p.price <= "+maxPrice;
        } else maxPrice="";
        if (sort!=null && !sort.isEmpty()) {
            if (sort.equals("price-high")) {
                sort = " order by max_price desc";
            } else if (sort.equals("price-low")) {
                sort = " order by min_price";
            } else if (sort.equals("best-seller")) {
                sort = " order by quantity_sold desc";
            } else if (sort.equals("newest")) {
                sort = " order by id desc";
            }
        } else sort=" order by id";
        if (category!= null && !category.isEmpty()) {
            category = " , products_types_categories pth\n" +
"                    where pth.products_category_id=h.id and pth.products_type_id= " + category;
        } else category="";
        try {
            
            String sql="select h.id, h.name, h.image, h.is_stored, min(h.price) as [min_price], max(h.price) as [max_price], max(h.sale_price) as [sale_price],sum(h.quantity_sold) as [quantity_sold], sum(h.quantity) as [quantity]\n" +
"                    from (SELECT pc.id, pc.name, pc.image, pc.is_stored, p.price, p.sale_price, p.quantity_sold, p.quantity\n" +
"                        from products p, products_categories pc\n" +
"                        where p.products_category_id = pc.id\n" + search + minPrice + maxPrice +
"                    ) as h "+category+
"                    group by h.id, h.name, h.image, h.is_stored\n" + sort;
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            //5. Process Result
            while (rs.next()) {
                
                ProductsCategoryDTO s = new ProductsCategoryDTO(
                        rs.getInt("id"),
                        rs.getNString("name"),
                        rs.getString("image"),
                        rs.getBoolean("is_stored"),
                        rs.getDouble("min_price"),
                        rs.getDouble("max_price"),
                        rs.getDouble("sale_price"),
                        rs.getInt("quantity_sold"),
                        rs.getInt("quantity"));
                list.add(s);
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace(); // Add this line for debugging
            Logger.getLogger(ProductsCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public ProductsCategory getProductsCategoryById(int id) throws SQLException, ClassNotFoundException{
        
        String sql="SELECT * FROM products_categories WHERE id=?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
//            ProductsCategory s = new ProductsCategory();
            String name = rs.getNString("name");
            String image = rs.getString("image");
            String desc = rs.getNString("description");
            boolean isStored = rs.getBoolean("is_stored");
            ProductsCategory s = new ProductsCategory(id, name, image, desc, isStored);
            return s;
        }
        return null;
    }
    
    public List<ProductsCategoryDTO> listProductsCategoriesDTOFlashSale() throws SQLException, ClassNotFoundException{
        List<ProductsCategoryDTO> list = new ArrayList<>();
        String sql="select h.id, h.name, h.image, h.is_stored, min(h.price) as [min_price], max(h.price) as [max_price], max(h.sale_price) as [sale_price],sum(h.quantity_sold) as [quantity_sold], sum(h.quantity) as [quantity]\n" +
                    "from (SELECT pc.id, pc.name, pc.image, pc.is_stored, p.price, p.sale_price, p.quantity_sold, p.quantity\n" +
                    "    from products p, products_categories pc, flash_sales f\n" +
                    "    where p.products_category_id = pc.id and pc.id=f.products_category_id) as h\n" +
                    "group by h.id, h.name, h.image, h.is_stored";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsCategory s = new ProductsCategory();
            ProductsCategoryDTO s = new ProductsCategoryDTO(
                    rs.getInt("id"), 
                    rs.getNString("name"), 
                    rs.getString("image"), 
                    rs.getBoolean("is_stored"), 
                    rs.getDouble("min_price"), 
                    rs.getDouble("max_price"), 
                    rs.getDouble("sale_price"), 
                    rs.getInt("quantity_sold"), 
                    rs.getInt("quantity"));
            list.add(s);
        }
        return list;
    }
    
    public int getQuantitySoldByProductsCategoryById(int id) throws SQLException, ClassNotFoundException{
        int quan;
        String sql = "SELECT p.products_category_id,  SUM(p.quantity_sold) AS total_quantity_sold\n" +
                    "FROM products p\n" +
                    "JOIN products_categories pc ON p.products_category_id = pc.id\n" +
                    "WHERE p.products_category_id = ? \n" +
                    "GROUP BY p.products_category_id;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            quan = rs.getInt("total_quantity_sold");
            return quan;
        }
        return -1;
    }
    
        public int getQuantityByProductsCategoryById(int id) throws SQLException, ClassNotFoundException{
        int quan;
        String sql = "SELECT p.products_category_id,  SUM(p.quantity) AS total_quantity_sold\n" +
                    "FROM products p\n" +
                    "JOIN products_categories pc ON p.products_category_id = pc.id\n" +
                    "WHERE p.products_category_id = ? \n" +
                    "GROUP BY p.products_category_id;";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            quan = rs.getInt("total_quantity_sold");
            return quan;
        }
        return -1;
    }
    
    public List<Integer> listProductsCategoriesBestSellers(int n) throws SQLException, ClassNotFoundException{
        List<Integer> list = new ArrayList<>();
        String sql="SELECT TOP "+n+" p.products_category_id,  SUM(p.quantity_sold) AS total_quantity_sold\n" +
                    "FROM products p\n" +
                    "JOIN products_categories pc ON p.products_category_id = pc.id\n" +
                    "GROUP BY p.products_category_id\n" +
                    "ORDER BY total_quantity_sold DESC;";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsCategory s = new ProductsCategory();
            int id = rs.getInt("products_category_id");
            list.add(id);
        }
        return list;
    }
    
    public List<Integer> listProductsCategoriesNewest(int n) throws SQLException, ClassNotFoundException{
        List<Integer> list = new ArrayList<>();
        String sql="SELECT top "+n+" id\n" +
                        "FROM products_categories pc\n" +
                        "ORDER BY id desc;";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsCategory s = new ProductsCategory();
            int id = rs.getInt("id");
            list.add(id);
        }
        return list;
    }
    
    public List<Integer> listProductsCategoriesSales() throws SQLException, ClassNotFoundException{
        List<Integer> list = new ArrayList<>();
        String sql="SELECT p.id FROM products_categories p, flash_sales f WHERE p.id=f.products_category_id;";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            //ProductsCategory s = new ProductsCategory();
            int id = rs.getInt("id");
            list.add(id);
        }
        return list;
    }
    
    public List<ProductsType> listProductsTypes() {
        List<ProductsType> list = new ArrayList<>();
        try {
            
            String sql = "select * from products_types";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                //ProductsCategory s = new ProductsCategory();
                int id = rs.getInt("id");
                String name = rs.getNString("name");
                list.add(new ProductsType(id, name));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public int updateProductsCategory(int id, String name, String image, boolean isStored, String description) {
        try {
            // Kiểm tra xem đã tồn tại dòng có userId và productId trong bảng carts chưa
            
            String updateSql = "UPDATE products_categories"
                    + " SET name=?, image=?, is_stored=?, description=?"
                    + " WHERE id = ?";
            
            PreparedStatement updateStm = connection.prepareStatement(updateSql);
            updateStm.setString(1, name);
            updateStm.setString(2, image);
            updateStm.setBoolean(3, isStored);
            updateStm.setString(4, description);
            updateStm.setInt(5, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int insertProductsCategory(String name, String image, String description) {
    int generatedKey = 0; // Default to 0 to indicate no key has been generated

    try {
        // Your SQL statement had some issues. Here's a corrected version:
        String updateSql = "INSERT INTO products_categories (name, image, is_stored, description) VALUES (?, ?, 0, ?)";

        // Prepare the statement with the option to retrieve auto-generated keys
        PreparedStatement updateStm = connection.prepareStatement(updateSql, Statement.RETURN_GENERATED_KEYS);

        // Set parameters for the insert statement
        updateStm.setString(1, name);
        updateStm.setString(2, image);
        updateStm.setString(3, description);

        // Execute the update
        int affectedRows = updateStm.executeUpdate();

        // Check if the insert was successful
        if (affectedRows > 0) {
            // Retrieve the generated key
            ResultSet generatedKeys = updateStm.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedKey = generatedKeys.getInt(1); // Assume the generated key is of type INT
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
        Logger.getLogger(ProductsDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    // Return the generated key or 0 if no key was generated
    return generatedKey;
}
    public List<Integer> listTypesByProductsCategoryId(int id) {
        List<Integer> list = new ArrayList<>();
        try {
            
            String sql = "select * from products_types_categories where products_category_id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("products_type_id"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductsCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int updateTypes(int id, int type) {
        try {
            String checkSql = "SELECT * FROM products_types_categories WHERE products_category_id = ? AND products_type_id = ?";
            PreparedStatement checkStm = connection.prepareStatement(checkSql);
            checkStm.setInt(1, id);
            checkStm.setInt(2, type);
            ResultSet checkRs = checkStm.executeQuery();
            if (checkRs.next()) {
                // Dòng đã tồn tại, thực hiện cập nhật
                return 0;
            } else {
                // Dòng chưa tồn tại, thực hiện insert
                String insertSql = "INSERT INTO products_types_categories (products_category_id, products_type_id) VALUES (?, ?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                insertStm.setInt(1, id);
                insertStm.setInt(2, type);
                return insertStm.executeUpdate();

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int deleteTypes(int id, String type) {
        try {
            String sql = "delete\n" +
                    "from products_types_categories\n" +
                    "where products_category_id = ? and products_type_id not in ("+type+")";
            PreparedStatement updateStm = connection.prepareStatement(sql);
            updateStm.setInt(1, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsCategoriesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public int insertTypes(String type) {
        try {
                String insertSql = "INSERT INTO products_types (name) VALUES (?)";
                PreparedStatement insertStm = connection.prepareStatement(insertSql);
                
                insertStm.setString(1, type);
                return insertStm.executeUpdate();

            
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    public int deleteTypes(int id) {
        try {
                String sql = "delete\n" +
                    "from products_types\n" +
                    "where id =?";
            PreparedStatement updateStm = connection.prepareStatement(sql);
            updateStm.setInt(1, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    public int updateTypes(int id, String name) {
        try {
                String sql = "update products_types\n" +
"set name = ?\n" +
"where id = ?";
            PreparedStatement updateStm = connection.prepareStatement(sql);
            updateStm.setString(1, name);
            updateStm.setInt(2, id);
            return updateStm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(ProductsVariantsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
