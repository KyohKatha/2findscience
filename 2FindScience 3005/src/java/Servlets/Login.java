/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pkg2FindScience.BDConnection;
import Pkg2FindScience.User;
import Pkg2FindScience.PublicationDAOException;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo Henrique
 */
public class Login extends HttpServlet {

    final int ADMIN = 0;
    final int ACADEMIC = 1;
    final int COMMON = 2;

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

        RequestDispatcher rd = null;

        String loginUser = request.getParameter("login");
        String password = request.getParameter("password");

        BDConnection connection = null;
        
        try {
            connection = BDConnection.getInstance();
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connection with database</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxHome.jsp");
        }

        try {
            User user = connection.login(loginUser, password);
            request.getSession().setAttribute("user", user);

            if (user.getProfile() == ADMIN) {
                rd = request.getRequestDispatcher("/home_admin.jsp");

            } else {
                if (user.getProfile() == COMMON) {
                    rd = request.getRequestDispatcher("/home_usercommon.jsp");
                } else {
                    rd = request.getRequestDispatcher("/home_academic.jsp");
                }
            }

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Login</strong> and/or <strong>password</strong> invalid! </p><p>- Click on the box to close it.</p>");

            rd = request.getRequestDispatcher("/home.jsp");
           
        }finally{
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
    protected

void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);


}

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

        @Override
        protected void

doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);


}

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */

        @Override
        public String

getServletInfo() {
        return "Short description";

}// </editor-fold>
}
