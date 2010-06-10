/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Servlets;

import Pkg2FindScience.BDConnection;
import Pkg2FindScience.PublicationDAOException;
import Pkg2FindScience.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Kaori
 */
public class NewsMaintenance extends HttpServlet {

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

        BDConnection connection = null;
        RequestDispatcher rd = null;
        Vector newsVector = null;
        User user = (User) request.getSession().getAttribute("user");

        try {
            connection = BDConnection.getInstance();

            if(user == null || user.getProfile() == ADMIN){
                newsVector = connection.getNews();
            }else{
                newsVector = connection.getNewsUser(user.getLogin());
            }
            request.getSession().setAttribute("newsVector", newsVector);
            rd = request.getRequestDispatcher("/AjaxNews.jsp");
        } catch (PublicationDAOException e){
            request.getSession().setAttribute("newsVector", newsVector);
            rd = request.getRequestDispatcher("/AjaxNews.jsp");
        } finally {
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
