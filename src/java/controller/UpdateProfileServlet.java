/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
public class UpdateProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String button = request.getParameter("button");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        boolean isUpdated = false;
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }
        if (button.equals("updateProfile")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");

            new UsersDAO().updateUser(user.getId(), name, email, address, gender.equals("true"), phone);
            try {
                session.setAttribute("user", new UsersDAO().userSignIn(user.getUsername(), user.getPassword()));
                isUpdated = true;
                request.setAttribute("isUpdated", isUpdated);
//                response.sendRedirect("profile");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
//                        response.getWriter().print(address);
            } catch (SQLException ex) {
                Logger.getLogger(UpdateProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdateProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            //request.getRequestDispatcher("profile.jsp").forward(request, response);

        } else {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");
            String message1 = "", message2 = "";
            if (!newPassword.equals(confirmNewPassword)) {
                message2 = "Mật khẩu không trùng";
                request.setAttribute("message2", message2);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;

            }
            if (!currentPassword.equals(user.getPassword())) {
                message1 = "Sai mật khẩu!";
                request.setAttribute("message1", message1);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
            new UsersDAO().updateUserPassword(user.getId(), newPassword);
            user.setPassword(newPassword);
            session.setAttribute("user", user);
            isUpdated = true;
            request.setAttribute("isUpdated", isUpdated);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
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
