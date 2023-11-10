/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author DELL
 */
public class UsersDAO extends DBContext {
    public User userSignIn (String username, String password)
            throws SQLException, ClassNotFoundException{
//        PreparedStatement stm = null;
//        ResultSet rs = null;
        try{
            //1. Connect DB
            
                //2. Create SQL String
                String sql="SELECT * FROM users WHERE username = ? AND password = ?;";
                //3. Create Statement
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                //4. Excute Query
                ResultSet rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getNString("name");
                    String email = rs.getString("email");
                    String user = rs.getString("username");
                    String pass = rs.getString("password");
                    int role = rs.getInt("role");
                    String phone = rs.getString("phone");
                    boolean isBanned = rs.getBoolean("is_banned");
                    String address = rs.getNString("address");
                    boolean gender = rs.getBoolean("gender");
                    
                    User dto = new User(id, name, email, user, pass, role, phone, isBanned, address, gender);
                    return dto;
                }
            
        }
        catch(Exception e){  
            System.out.println(e);
        }
        return null;
    }
    
    public boolean userSignUp (String name, String username, String password)
            throws SQLException, ClassNotFoundException{
        try{
            //1. Connect DB
            
                //2. Create SQL String
                String sql="INSERT INTO users(name, username, password) VALUES (?, ?, ?)";
                //3. Create Statement
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, username);
                stm.setString(3, password);
                //4. Excute Query
                int row = stm.executeUpdate();
                //5. Process Result
                if (row>0) {
                    return true;
                }
                    
            
        }
        catch(Exception e){    
        }
        return false;
    }
    
    public boolean isUserNameExisted (String username) 
        throws SQLException, ClassNotFoundException{
        try{
            //1. Connect DB
            
                //2. Create SQL String
                String sql="SELECT * FROM users WHERE username = ?;";
                //3. Create Statement
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, username);
                //4. Excute Query
                ResultSet rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    return true;
                }
            
        }
        catch(Exception e){  
            System.out.println(e);
        }
        return false;
    }
    
    public List<User> listUsers() {
        List<User> accounts = new ArrayList<>();
        try {
            
            
            
            //2. Create SQL String
            String sql="Select * "
                    + "FROM users;";
            //3. Create Statement
            PreparedStatement stm = connection.prepareStatement(sql);
            //4. Excute Query
            ResultSet rs = stm.executeQuery();
            //5. Process Result
            while(rs.next()){
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getNString("name"));
                u.setEmail(rs.getString("email"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getInt("role"));
                u.setPhone(rs.getString("phone"));
                u.setIsBanned(rs.getBoolean("is_banned"));
                u.setAddress(rs.getNString("address"));
                u.setGender(rs.getBoolean("gender"));
                
                accounts.add(u);
            }// end traverse Result Set
            
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }
    
    public boolean updateUser(int userId, String name, String email, String address, boolean gender, String phone) {
        try {
            String sql = "update users\n" +
                    "set name = ?, email=?, address=?, gender=?, phone=?\n" +
                    "where id=?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, address);
            ps.setBoolean(4, gender);
            ps.setString(5, phone);
            ps.setInt(6, userId);
            int updatedRows = ps.executeUpdate();
            if (updatedRows>0)
                return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean updateUserPassword(int userId, String pass) {
        try {
            String sql = "update users\n" +
                    "set password=?\n" +
                    "where id=?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, pass);
            ps.setInt(2, userId);
            int updatedRows = ps.executeUpdate();
            if (updatedRows>0)
                return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean updateUserRole(int userId, int role) {
        try {
            String sql = "update users\n" +
                    "set role=?\n" +
                    "where id=?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role);
            ps.setInt(2, userId);
            int updatedRows = ps.executeUpdate();
            if (updatedRows>0)
                return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateUserIsBanned(int userId, boolean isBanned) {
        try {
            String sql = "update users\n" +
                    "set is_banned=?\n" +
                    "where id=?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isBanned);
            ps.setInt(2, userId);
            int updatedRows = ps.executeUpdate();
            if (updatedRows>0)
                return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
}
