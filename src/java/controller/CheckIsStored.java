/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import dal.ProductsDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
/**
 *
 * @author DELL
 */
public class CheckIsStored extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckIsStored</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckIsStored at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        //processRequest(request, response);
//        String variantsJSON = request.getParameter("variants"); // Lấy dữ liệu theo tên tham số "variants"
//        String productCategoryId = request.getParameter("productCategoryId"); // Lấy dữ liệu theo tên tham số "productCategoryId"
//        Gson gson = new Gson();
//        String[] variantsArray = gson.fromJson(variantsJSON, String[].class);
//        
//        try {
//            // Trả về phản hồi
//            List<String> list = new ProductsDAO().getSkuLeftIsStored(productCategoryId, variantsArray);
//            String skuListJSON = gson.toJson(list);
//            response.setContentType("application/json");
//            response.setCharacterEncoding("UTF-8");
//            response.getWriter().write(skuListJSON);
//            return;
//        } catch (SQLException ex) {
//            Logger.getLogger(CheckIsStored.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(CheckIsStored.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write("{\"message\": \"Dữ liệu đã được xử lý.\"}");
////        response.getWriter().write(0);
//    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        String skuJSON = request.getParameter("sku"); // Lấy dữ liệu theo tên tham số "variants"
        String productCategoryId = request.getParameter("productCategoryId"); // Lấy dữ liệu theo tên tham số "productCategoryId"
        Gson gson = new Gson();
        String sku = gson.fromJson(skuJSON, String.class);
        
        try {
            // Trả về phản hồi
            Product p = new ProductsDAO().getProductBySku(productCategoryId, sku);
            String skuListJSON = gson.toJson(p);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(skuListJSON);
            return;
        } catch (SQLException ex) {
            Logger.getLogger(CheckIsStored.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CheckIsStored.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"message\": \"Dữ liệu đã được xử lý.\"}");
//        response.getWriter().write(0);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
