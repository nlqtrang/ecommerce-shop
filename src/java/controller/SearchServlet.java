/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductsCategoriesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ProductsCategoryDTO;
import model.ProductsType;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author DELL
 */
public class SearchServlet extends HttpServlet {
   
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
            out.println("<title>Servlet SearchServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath () + "</h1>");
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
        response.setContentType("application/json;charset=UTF-8");
        String search = request.getParameter("search");
        String type = request.getParameter("type");
        if (type==null)
            type="";
        else {
            request.setAttribute("currentType", Integer.parseInt(type));
        }
        if (search==null)
            search="";
        List<ProductsCategoryDTO> listProductsCategoriesDTO = new ProductsCategoriesDAO().listProductsCategoriesDTOBySearch(search, "", "", "", type);
        List<ProductsType> listProductsTypes = new ProductsCategoriesDAO().listProductsTypes();
        int page = listProductsCategoriesDTO.size()%3==0?listProductsCategoriesDTO.size()/3:listProductsCategoriesDTO.size()/3+1;
        listProductsCategoriesDTO=new ProductsCategoriesDAO().listProductsCategoriesDTOBySearch(search, "", "", "", type, 1);
        request.setAttribute("listProducts", listProductsCategoriesDTO);
        request.setAttribute("listProductsTypes", listProductsTypes);
        request.setAttribute("page", page);
        
        request.getRequestDispatcher("search.jsp").forward(request, response);
        
//response.getWriter().print(listProductsTypes);
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
        //processRequest(request, response);
        String search = request.getParameter("search2");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String sort = request.getParameter("sort");
        String category = request.getParameter("type");
        int noPage=Integer.parseInt(request.getParameter("noPage"));
        
        List<ProductsCategoryDTO> listProductsCategoriesDTO = new ProductsCategoriesDAO().listProductsCategoriesDTOBySearch(search, minPrice, maxPrice, sort, category);
//        List<ProductsType> listProductsTypes = new ProductsCategoriesDAO().listProductsTypes();
        int page = listProductsCategoriesDTO.size()%3==0?listProductsCategoriesDTO.size()/3:listProductsCategoriesDTO.size()/3+1;
        if (page==0)
            page=1;
        if (noPage>page) {
            noPage=1;
        } else {
            listProductsCategoriesDTO = new ProductsCategoriesDAO().listProductsCategoriesDTOBySearch(search, minPrice, maxPrice, sort, category, noPage);
        }
        String data="";
        for (ProductsCategoryDTO product : listProductsCategoriesDTO) {
            data+="<div class=\"col-lg-4 col-md-6 col-sm-6\">\n" +
"    <div class=\"product__item\">\n" +
"        <a class=\"prod_cont\" href=\"product-detail?productId="+product.getId()+"\" >\n" +
"                <div style=\"background-color: #f5f5f5;\">\n" +
"\n" +
"                    <div class=\"product p-2 pt-1\">\n" +
"                        <div class=\"categories__item set-bg product__image\" data-setbg=\""+product.getImage()+"\">\n" +
"                        </div>\n" +
"                        <div class=\"product__content\">\n" +
"                            <div class=\"product__top-right\">\n" +
"                                <span class=\"product__discount\">-"+product.getSalePrice()+"%</span>\n" +
"                            </div>\n" +
"                            <h5 class=\"product__title truncate-text\">"+product.getName()+"</h5>\n" +
"                            <div class=\"product__price\">\n" +
"                                <span class=\"product__sale-price\">"+product.getMinPrice()+"đ</span>\n" ;
            if (product.getMinPrice()!=product.getMaxPrice()) {
                data+="<span class=\"product__sale-price\">- "+product.getMaxPrice()+"đ</span>\n";
            }
            data+=
"                            </div>\n" +
"                            <div class=\"product__meta d-flex justify-content-between\">\n" +
"                                <span class=\"product__rating\"><i class=\"fa fa-star\"></i><i class=\"fa fa-star\"></i><i class=\"fa fa-star\"></i></span>\n" +
"                                <span class=\"product__sales\" style=\"color: black;\">Đã bán: "+product.getSoldQuantity()+"</span>\n" +
"                                <span class=\"product__sales\" style=\"color: black;\">Còn hàng: "+product.getQuantity()+"</span>\n" +
"                            </div>\n" +
"                        </div>\n" +
"                    </div>\n" +
"                </div>\n" +
"            </a>\n" +
"    </div>\n" +
"</div>";
        }
        
        Map<String, Object> res = new HashMap<>();
        res.put("data", data);
        res.put("noPage", noPage);
        res.put("page", page);
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(res);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
        
        
//        request.setAttribute("listProducts", listProductsCategoriesDTO);
//        request.setAttribute("listProductsTypes", listProductsTypes);
//        request.setAttribute("page", page);
        //response.getWriter().print(listProductsCategoriesDTO);
        
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
