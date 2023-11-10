/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductsCategoriesDAO;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductsCategory;
import com.google.gson.Gson;
import dal.ProductsVariantsDAO;
import dal.ProductsVariantsValuesDAO;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.ProductsType;

/**
 *
 * @author DELL
 */
public class AdminEditProduct extends HttpServlet {

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
            out.println("<title>Servlet AdminEditProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminEditProduct at " + request.getContextPath() + "</h1>");
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
        String rawid = request.getParameter("productId");
        int id = Integer.parseInt(rawid);
        ProductsCategory p;
        try {
            p = new ProductsCategoriesDAO().getProductsCategoryById(id);
            p.setListImages();
            p.setListProductsVariants();
            p.setListProducts();
            List<ProductsType> listTypes = new ProductsCategoriesDAO().listProductsTypes();
            List<Integer> listTypesByProductsCategoryId = new ProductsCategoriesDAO().listTypesByProductsCategoryId(id);
            request.setAttribute("listTypes", listTypes);
            request.setAttribute("product", p);
            request.setAttribute("listTypesByProductsCategoryId", listTypesByProductsCategoryId);
        } catch (SQLException ex) {
            Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        Map<String, Product> mapProductsByProductsCategoryId = new ProductsDAO().mapProductsByProductsCategoryId(rawid);
        Gson gson = new Gson();
        String listProductsJson = gson.toJson(mapProductsByProductsCategoryId);
        request.setAttribute("listProductsJson", listProductsJson);
        request.getRequestDispatcher("admin/edit-product.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("id"));
        String pName = request.getParameter("productName");
        String pImage = request.getParameter("productImage");
        String pDescription = request.getParameter("productDescription");
//        response.getWriter().print(pDescription);
        boolean pIsStored = Boolean.parseBoolean(request.getParameter("productIsStored"));
        //response.getWriter().print(pIsStored);
        new ProductsCategoriesDAO().updateProductsCategory(id, pName, pImage, pIsStored, pDescription);
        String[] variants = request.getParameterValues("variant_name");
        for (int i=0; i<variants.length; i++) {
            int variantId = new ProductsVariantsDAO().updateVariant(id, variants[i]);
            //response.getWriter().print(variantId);
            try {
                String variantName = new ProductsVariantsDAO().getProductsVariantById(variantId).getSku();
                String[] options = request.getParameterValues(variantName);
                for (int j=0; j<options.length; j++) {
                    //response.getWriter().println(variantId + " "+ options[j]);
                    int row = new ProductsVariantsValuesDAO().updateVariantsValue(variantId, options[j]);
                    
                }
                
            } catch (SQLException ex) {
                Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
                response.getWriter().print(ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        String[] skus = request.getParameterValues("sku");
        if (!skus[0].isEmpty() && skus[0] != null) {
            String[] prices = request.getParameterValues("price");
            String[] images = request.getParameterValues("image");
            String[] quantities = request.getParameterValues("quantity");
            String[] salePrices = request.getParameterValues("salePrice");
            String[] isStoreds = request.getParameterValues("isStored");
            List<String> listIsStoreds = new ArrayList<>();
            if (isStoreds != null) {
                listIsStoreds = new ArrayList<String>(Arrays.asList(isStoreds));

            } else {
                listIsStoreds.add("");
            }

            String notStored = "";
//        response.getWriter().print(skus);
//        response.getWriter().print(isStoreds);

            for (int i = 0; i < prices.length; i++) {
                String isStored;
                notStored += "'"+skus[i] + "',";
                if (listIsStoreds.contains(skus[i])) {
                    isStored = "true";
                } else {
                    isStored = "false";
                }
                int row;
                try {
                    row = new ProductsDAO().updateProduct(id, skus[i], prices[i], "", quantities[i], salePrices[i], isStored);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
                    response.getWriter().println(ex);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
                    response.getWriter().println(ex);
                }
            }
            //response.getWriter().print(notStored);
            String m = notStored.substring(0, notStored.length() - 1);
            //response.getWriter().print("UPDATE products SET is_stored=1 WHERE products_category_id = ? and sku not in (" + m + ")");
            new ProductsDAO().updateProductStored(id, notStored.substring(0, notStored.length() - 1));
        } else {
            //response.getWriter().print(skus[0]);
            String price = request.getParameter("price");
            String image = request.getParameter("image");
            String quantity = request.getParameter("quantity");
            String salePrice = request.getParameter("salePrice");
            String isStored = request.getParameter("isStored");
            String b;
            if (isStored == "null" || isStored == null) {
                b = "true";
            } else {
                b = "false";
            }
            try {
                new ProductsDAO().updateProductIfSkuIsNull(id, price, "", quantity, salePrice, b);
            } catch (SQLException ex) {
                Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(AdminEditProduct.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
        
        String[] types = request.getParameterValues("type");
        String sqlType="";
        if (!types[0].isEmpty() && types[0] != null && types!=null) {
            for (int i=0; i<types.length; i++) {
                new ProductsCategoriesDAO().updateTypes(id, Integer.parseInt(types[i]));
                sqlType+="'"+types[i]+"',";
            } 
            
        }
        new ProductsCategoriesDAO().deleteTypes(id, sqlType.substring(0, sqlType.length()-1));
        response.sendRedirect("edit-product?productId="+id);
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
