/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UsersDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import util.SignUpValidation;

/**
 *
 * @author DELL
 */
public class SignUpServlet extends HttpServlet {
   
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        String fullname = request.getParameter("name");

        String url = "login.jsp";
        SignUpValidation errors = new SignUpValidation();
    
        boolean bErr = false;
        try{

            if(username.trim().length() < 6 || username.trim().length() > 20){
                bErr = true;
                errors.setUsernameLengthErr("Username yêu cầu 6 - 20 kí tự");
            }// end if username
            if(password.trim().length() < 6 || password.trim().length() > 30){
                bErr = true;
                errors.setPasswordLengthErr("Password yêu cầu 6 - 30 kí tự");
            }
            else if(!password.trim().equals(confirm.trim())){
                bErr = true;
                errors.setConfirmNotMatch("Mật khẩu không trùng!");
            }// end if password
            if (fullname.trim().length() < 6 || fullname.trim().length() > 50) {
                bErr = true;
                errors.setFullNameLengthErr("Name yêu cầu 6 - 50 kí tự");
            }// end if username
            
            if(bErr){
                request.setAttribute("INSERTERR", errors);
            }
            else{
                UsersDAO dao = new UsersDAO();
                boolean result = dao.userSignUp(fullname, username, password);
                if(result){
                    url = "login.jsp";
                }
            }//enf if bErr
        }
        catch (SQLException ex) {
            log("CreateAccountServlet _Nameing:" + ex.getMessage());
            errors.setUsernameIsExited(username+" đã tồn tại, yêu cầu dùng tên đăng nhập khác!");
            request.setAttribute("INSERTERR", errors);
        } 
        catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }        
        finally{
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
        response.sendRedirect("login.jsp");
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
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");
        String fullname = request.getParameter("name");
        boolean signup=true;
        request.setAttribute("signup", signup);
        String url = "login.jsp";
        SignUpValidation errors = new SignUpValidation();
    
        boolean bErr = false;
        try{

            if(username.trim().length() < 6 || username.trim().length() > 20){
                bErr = true;
                errors.setUsernameLengthErr("Username yêu cầu 6 - 20 kí tự");
            }// end if username
            if(password.trim().length() < 6 || password.trim().length() > 30){
                bErr = true;
                errors.setPasswordLengthErr("Password yêu cầu 6 - 30 kí tự");
            }
            else if(!password.trim().equals(confirm.trim())){
                bErr = true;
                errors.setConfirmNotMatch("Mật khẩu không trùng!");
            }// end if password
            if (fullname.trim().length() < 6 || fullname.trim().length() > 50) {
                bErr = true;
                errors.setFullNameLengthErr("Name yêu cầu 6 - 50 kí tự");
            }// end if username
            if (new UsersDAO().isUserNameExisted(username)) {
                bErr=true;
                errors.setUsernameIsExited(username+" đã tồn tại, yêu cầu dùng tên đăng nhập khác!");
            }
            if(bErr){
                request.setAttribute("INSERTERR", errors);
            }
            else{
                UsersDAO dao = new UsersDAO();
                boolean result = dao.userSignUp(fullname, username, password);
                
                if(result){
//                    signup=false;
//                    request.setAttribute("signup", signup);
//                    
//                    fullname="";
//                    password="";
//                    confirm="";
//                    url = "login.jsp";
                    
                    response.sendRedirect("login.jsp");
                    return;
                }
            }//enf if bErr
            
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
        catch (SQLException ex) {
            log("CreateAccountServlet _Nameing:" + ex.getMessage());
            errors.setUsernameIsExited(username+" đã tồn tại, yêu cầu dùng tên đăng nhập khác!");
            request.setAttribute("INSERTERR", errors);
        } 
        catch (ClassNotFoundException ex) {
            ex.printStackTrace();
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
