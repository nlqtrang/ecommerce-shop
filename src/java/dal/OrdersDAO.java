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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderDTO;
import model.ProductsInCartDTO;

/**
 *
 * @author DELL
 */
public class OrdersDAO extends DBContext {
    public int addOrder(int userId, String name, String address, String phone, String message) {
        try {
            String sql = "insert into orders (user_id, name, address, phone, message)\n" +
                    "values (?, ?, ?, ?, ?);";

            PreparedStatement insertStm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            insertStm.setInt(1, userId);
            insertStm.setString(2, name);
            insertStm.setString(3, address);
            insertStm.setString(4, phone);
            insertStm.setString(5, message);
            int affectedRows = insertStm.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = insertStm.getGeneratedKeys()) {
                    if (rs.next()) {
                        int newRowId = rs.getInt(1); // Lấy ID của row vừa được thêm
                        return newRowId;
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    
    public int addOrdersDetail(int orderId, int productId, int quantity, double price, double sale, double sum) {
        try {
            String sql = "insert into dbo.orders_details (order_id, product_id, quantity, price, sale, sum)\n" +
"values (?, ?, ?, ?, ?, ?);";
            
            PreparedStatement insertStm = connection.prepareStatement(sql);
            insertStm.setInt(1, orderId);
            insertStm.setInt(2, productId);
            insertStm.setInt(3, quantity);
            insertStm.setDouble(4, price);
            insertStm.setDouble(5, sale);
            insertStm.setDouble(6, sum);

            return insertStm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public List<ProductsInCartDTO> listOrdersDetails(int userId, int orderId) {
        List<ProductsInCartDTO> list = new ArrayList<>();
        try {
            String sql = "select od.product_id, pc.id as productCategoryId, pc.image, pc.name, p.sku,\n" +
                    "       p.sale_price, p.price, od.quantity, p.quantity as productQuantity, p.is_stored\n" +
                    "from orders o, products p, products_categories pc, orders_details od\n" +
                    "where o.user_id=? and p.id=od.product_id and pc.id=p.products_category_id and o.id=od.order_id and o.id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, orderId);
            ResultSet rs = ps.executeQuery();
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
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<OrderDTO> listOrders(int userId) {
        List<OrderDTO> list = new ArrayList<>();
        try {
            String sql = "select o.id, s.id as status_id, s.name as status, od.product_id, pc.id as productCategoryId, pc.image, pc.name, p.sku,\n" +
"       p.sale_price, p.price, od.quantity, p.quantity as productQuantity, p.is_stored\n" +
"from orders o, products p, products_categories pc, orders_details od, status s\n" +
"where o.user_id=? and p.id=od.product_id and pc.id=p.products_category_id and o.id=od.order_id and o.status_id=s.id order by o.created_at desc";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            int oldId=0;
            int count=0;
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
                int id=rs.getInt("id");
                if (id==oldId) {
                    list.get(count-1).getListOrdersDetails().add(p);
                    double priceM = list.get(count-1).getPrice();
                    priceM = p.getTotal()+priceM;
                    list.get(count-1).setPrice(priceM);
                } else {
                    List<ProductsInCartDTO> productList = new ArrayList<>();
                    productList.add(p);
                    list.add(new OrderDTO(id, userId, rs.getInt("status_id"), rs.getNString("status"), p.getTotal(), productList));
                    count++;
                    
                }
                oldId=id;
//                if (map.containsKey(rs.getInt("id"))) {
//                    map.get(rs.getInt("id")).getListOrdersDetails().add(p);
//                    double priceM = map.get(rs.getInt("id")).getPrice();
//                    priceM = p.getTotal()+priceM;
//                    map.get(rs.getInt("id")).setPrice(priceM);
//                }else {
//                    List<ProductsInCartDTO> productList = new ArrayList<>();
//                    productList.add(p);
//                    map.put(rs.getInt("id"), new OrderDTO(rs.getInt("id"), userId, rs.getInt("status_id"), rs.getNString("status"), p.getTotal(), productList));
//                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<OrderDTO> listOrders() {
        List<OrderDTO> list = new ArrayList<>();
        try {
            String sql = "select o.id,o.user_id, s.id as status_id, s.name as status, od.product_id, pc.id as productCategoryId, pc.image, pc.name, p.sku,\n" +
"       p.sale_price, p.price, od.quantity, p.quantity as productQuantity, p.is_stored\n" +
"from orders o, products p, products_categories pc, orders_details od, status s\n" +
"where p.id=od.product_id and pc.id=p.products_category_id and o.id=od.order_id and o.status_id=s.id order by o.created_at desc";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int oldId=0;
            int count=0;
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
                int id=rs.getInt("id");
                if (id==oldId) {
                    list.get(count-1).getListOrdersDetails().add(p);
                    double priceM = list.get(count-1).getPrice();
                    priceM = p.getTotal()+priceM;
                    list.get(count-1).setPrice(priceM);
                } else {
                    List<ProductsInCartDTO> productList = new ArrayList<>();
                    productList.add(p);
                    list.add(new OrderDTO(id, rs.getInt("user_id"), rs.getInt("status_id"), rs.getNString("status"), p.getTotal(), productList));
                    count++;
                    
                }
                oldId=id;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Order getOrderByOrderId(int orderId) {
        try {
            String sql = "select o.id,\n" +
"o.user_id,\n" +
"o.created_at,\n" +
"o.shipping_date,\n" +
"o.shipped_date,\n" +
"s.name as status,\n" +
"o.name,\n" +
"o.address,\n" +
"o.phone,\n" +
"o.message from orders o, status s where o.status_id=s.id and o.id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"), 
                        rs.getInt("user_id"), 
                        rs.getString("created_at"), 
                        rs.getString("shipping_date"), 
                        rs.getString("shipped_date"), 
                        rs.getString("status"), 
                        rs.getNString("name"), 
                        rs.getNString("address"), 
                        rs.getString("phone"), 
                        rs.getString("message")
                );
                return o;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int updateOrderStatus(int orderId, int status) {
        try {
            String sql = "update orders\n" +
                    "set status_id = ?\n" +
                    "where id = ?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public String getStatusByOrderId(int orderId) {
        try {
            String sql = "select status.name from status, orders\n" +
                    "where status.id=orders.status_id and orders.id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs =  ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
    }
    
    public List<Integer> getMoneyByMonth(int month, int year) {
        List<Integer> list = new ArrayList<>();
        String sql = "select sum(od.sum) as sum from orders o, orders_details od where o.id=od.order_id and o.status_id=5 and YEAR(o.shipped_date) = ? and MONTH(o.shipped_date)=? and DAY(o.shipped_date)=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, year);
            ps.setInt(2, month);
            int size;
            if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
                size=31;
            else if (month==2)
                size=28;
            else 
                size=30;
            
            for (int i = 1; i <= size; i++) {
                ps.setInt(3, i);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    list.add(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
        }
        return list;
    }
    
}
