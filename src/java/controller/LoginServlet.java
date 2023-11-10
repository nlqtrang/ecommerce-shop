/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CartsDAO;
import dal.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {
   
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
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
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
        //response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        //processRequest(request, response);
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            User u = (User)session.getAttribute("user");
            if (u.getRole()==2) {
                //request.getRequestDispatcher("home").forward(request, response);
                response.sendRedirect("home");
            } else {
                response.sendRedirect("admin/dashboard.jsp");
            }
        }
        else request.getRequestDispatcher("login.jsp").forward(request, response);
//        response.sendRedirect("login.jsp");
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
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        //response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            if (session.getAttribute("user") != null) {
                response.getWriter().print("Logged");
            } else {
                String user_raw = request.getParameter("user");
                String pass_raw = request.getParameter("pass");
                User user = new UsersDAO().userSignIn(user_raw, pass_raw);
                
                if (user == null) {
                    session.setAttribute("user", null);
                    request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu bị sai!");
                    //response.sendRedirect("login.jsp");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    
                } else if (!user.isIsBanned()){
                    session.setAttribute("user", user);
                    int numberOfProductsInCart = new CartsDAO().numberOfProductsInCart(user.getId());
                    session.setAttribute("numberOfProductsInCart", numberOfProductsInCart);
//                    response.sendRedirect("home");
                    if (user.getRole()==2) {
                        String targetURL = (String) session.getAttribute("targetURL");
                        if (targetURL.endsWith(".jsp"))
                            targetURL = targetURL.substring(0, targetURL.length()-4);
                        if (session.getAttribute("param")!=null)
                            targetURL = targetURL + "?" + session.getAttribute("param");
                        session.setAttribute("param", null);
                        if (targetURL != null) {
                            // Chuyển hướng người dùng đến URL đích
                            session.removeAttribute("targetURL");
                            response.sendRedirect(targetURL);
                        } else {
                            // Nếu không có URL đích, chuyển hướng đến trang home hoặc trang mặc định khác
                            response.sendRedirect("home");
                        }
                    } else {
                        response.sendRedirect("dashboard");
                    }
                    
                }
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
