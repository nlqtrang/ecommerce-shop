/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CartsDAO;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductsVariant;
import model.User;

/**
 *
 * @author DELL
 */
public class AddProductToCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProductToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductToCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.sendRedirect("home");
        HttpSession session = request.getSession();
        session.setAttribute("param", null);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
//            response.getWriter().write("{\"redirect\":\"login\"}");
response.getWriter().write("{\"status\":\"login_required\"}");
            return;
        }
        if (session.getAttribute("user") != null) {
            int userId = ((User) session.getAttribute("user")).getId();
            String productsCategoryIdRaw = request.getParameter("productsCategoryId");
            int productsCategoryId = Integer.parseInt(productsCategoryIdRaw);
            String[] listVariants = request.getParameterValues("variant");
            String sku = "";
            if (listVariants !=null)
                for (String variant : listVariants) {
                    sku += variant + "_" + request.getParameter(variant) + "$";
                }
            else 
                sku=null;
            if (sku!=null)
                sku=sku.substring(0, sku.length() - 1);
            String quantityRaw = request.getParameter("quantity");
            int quantity = Integer.parseInt(quantityRaw);
            try {
                int productId;
                if (sku!=null)
                    productId = new ProductsDAO().getProductIdByProductsCategoryIdAndSku(productsCategoryId, sku);
                else
                    productId = new ProductsDAO().getProductIdByProductsCategoryIdAndSku(productsCategoryId);
                int row = new CartsDAO().addProductsToCart(userId, productId, quantity);
                int numberOfProductsInCart = new CartsDAO().numberOfProductsInCart(userId);
                session.setAttribute("numberOfProductsInCart", numberOfProductsInCart);
                if (row > 0) {
//                    String targetURL = (String) session.getAttribute("targetURL");
//                    if (targetURL.endsWith(".jsp")) {
//                        targetURL = targetURL.substring(0, targetURL.length() - 4);
//                    }
//                    if (session.getAttribute("param") != null) {
//                        targetURL = targetURL + "?" + session.getAttribute("param");
//                    }
//                    session.setAttribute("param", null);
//                    if (targetURL != null) {
//                        // Chuyển hướng người dùng đến URL đích
//                        session.removeAttribute("targetURL");
//                        response.sendRedirect(targetURL);
//                        
////                        request.getRequestDispatcher("targetURL").forward(request, response);
//                        return;
//                    } else {
//                        // Nếu không có URL đích, chuyển hướng đến trang home hoặc trang mặc định khác
//                        response.sendRedirect("home");
//                        return;
//                    }
                    //response.getWriter().print(true);
                    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write("{\"status\": true, \"newCartTotal\": " + numberOfProductsInCart + "}");
                }
                

            } catch (SQLException ex) {
                Logger.getLogger(AddProductToCart.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(AddProductToCart.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
