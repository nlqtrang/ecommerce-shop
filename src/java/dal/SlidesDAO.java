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
import model.Slide;

/**
 *
 * @author DELL
 */
public class SlidesDAO extends DBContext {
    public List<Slide> listSlides() throws SQLException, ClassNotFoundException{
        List<Slide> list = new ArrayList<>();
        String sql="SELECT * FROM slides;";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
                //5. Process Result
        while (rs.next()) {
            
            int id = rs.getInt("id");
            String image = rs.getString("image");
            String url = rs.getString("url");
            String title = rs.getNString("title");
            String desc = rs.getNString("description");
            Slide s = new Slide(id, image, url, title, desc);
            list.add(s);
        }
        return list;
    }
}
