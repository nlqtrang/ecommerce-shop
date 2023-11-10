/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductsCategoriesDAO;
import dal.SlidesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductsCategory;
import model.ProductsCategoryDTO;
import model.ProductsType;
import model.Slide;

/**
 *
 * @author DELL
 */
public class HomeServlet extends HttpServlet {
   
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
            out.println("<title>Servlet HomeServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath () + "</h1>");
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
        
        try {
            HttpSession session = request.getSession();
            session.setAttribute("param", null);
            //processRequest(request, response);
            List<Slide> listSlides = new ArrayList<>();
            listSlides = new SlidesDAO().listSlides();
            request.setAttribute("listSlides", listSlides);
            
            List<ProductsType> listProductsTypes = new ProductsCategoriesDAO().listProductsTypes();
            request.setAttribute("listProductsTypes", listProductsTypes);
            
            List<ProductsCategoryDTO> listProductsCategoriesDTOFlashSale = new ProductsCategoriesDAO().listProductsCategoriesDTOFlashSale();
            request.setAttribute("listProductsCategoriesDTOFlashSale", listProductsCategoriesDTOFlashSale);
            
            List<ProductsCategoryDTO> listProductsCategoriesDTO = new ProductsCategoriesDAO().listProductsCategoriesDTO();
            request.setAttribute("listProductsCategoriesDTO", listProductsCategoriesDTO);
            
            List<Integer> listProductsCategoriesBestSellers = new ProductsCategoriesDAO().listProductsCategoriesBestSellers(5);
            request.setAttribute("listProductsCategoriesBestSellers", listProductsCategoriesBestSellers);
            
            List<Integer> listProductsCategoriesNewest = new ProductsCategoriesDAO().listProductsCategoriesNewest(5);
            request.setAttribute("listProductsCategoriesNewest", listProductsCategoriesNewest);
            
            List<Integer> listProductsCategoriesSales = new ProductsCategoriesDAO().listProductsCategoriesSales();
            request.setAttribute("listProductsCategoriesSales", listProductsCategoriesSales);
            PrintWriter out = response.getWriter();
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
