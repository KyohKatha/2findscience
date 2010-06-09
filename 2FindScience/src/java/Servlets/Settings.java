/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import Pkg2FindScience.BDConnection;
import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author Katha
 */
public class Settings extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        RequestDispatcher rd = null;
        String mode = (String) request.getParameter("mode");

        System.out.println("MODEE " + mode);

        try {
            if (mode.equals("upgrade")) {
                String newMaxUpgrade = request.getParameter("newMaxUpgrade");
                BDConnection con = BDConnection.getInstance();
                String st;
                st = "UPDATE integrado.settings SET upgrade = " + newMaxUpgrade;
                ResultSet resa = con.executeQuery(st);
                request.getSession().setAttribute("type", "success");
                request.getSession().setAttribute("message", "<p>- The <strong>Maximum number of upgrade requests</strong> was updated successfully!</p><p>- Click on the box to close it.</p>");
                rd = request.getRequestDispatcher("Filter?action=ThemeUpgradeFilter");
            } else {
                if(mode.equals("deleteSubject")){
                    int index = Integer.parseInt( request.getParameter("index"));

                    Vector subjects = (Vector) request.getSession().getAttribute("subjectVector");
                    String subject = subjects.elementAt(index).toString();
                    BDConnection con = BDConnection.getInstance();

                    con.deleteSubject(subject);
                    request.getSession().setAttribute("type", "success");
                    request.getSession().setAttribute("message", "<p>- <strong>Subject</strong> delete sucessfully!</p><p>- Click on the box to close it.</p>");
                    rd = request.getRequestDispatcher("Filter?action=ThemeUpgradeFilter");

                }else{
                String newTheme = request.getParameter("newTheme");
                BDConnection con = BDConnection.getInstance();
                boolean inserido = con.inserirNovoTema(newTheme);

                if (!inserido) {
                    request.getSession().setAttribute("type", "critical");
                    request.getSession().setAttribute("message", "<p>- <strong>Subject</strong> already exists!</p><p>- Click on the box to close it.</p>");
                    rd = request.getRequestDispatcher("/AjaxSettings.jsp");
                } else {
                    request.getSession().setAttribute("type", "success");
                    request.getSession().setAttribute("message", "<p>- The <strong>subject</strong> was saved successfully!</p><p>- Click on the box to close it.</p>");
                    rd = request.getRequestDispatcher("Filter?action=ThemeUpgradeFilter");
                }
                }
            }

        } catch (Exception e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxSettings.jsp");
        } finally {
            rd.forward(request, response);
            out.close();
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
