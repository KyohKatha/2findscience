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
import Pkg2FindScience.User;
import java.util.Vector;

/**
 *
 * @author Katha
 */
public class Search extends HttpServlet {
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
        PrintWriter out = response.getWriter();
        Vector result = new Vector();
        int n = 0;
        String modo = "";
        String param = request.getParameter("parametro");
        String filtro = "";
        User user = (User) request.getSession().getAttribute("user");

        try {
            String action = request.getParameter("action");
            if (action.equals("doSearch")) {
                modo = "next";
                filtro = request.getParameter("filtro");

                BDConnection con = BDConnection.getInstance();
                result = con.searchPublication(filtro, param);
                request.getSession().setAttribute("result", result);

            } else {
                modo = (String) request.getParameter("modo");
                n = Integer.parseInt(request.getParameter("numResultsPage"));
            }

            request.getSession().setAttribute("parametro", param);
            request.getSession().setAttribute("modo", modo);
            request.getSession().setAttribute("numResultsPage", n);
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("/AjaxSearchResult.jsp");
            rd.forward(request, response);
            out.close();

        } catch (Exception e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
            request.getSession().setAttribute("result", new Vector());
            request.getSession().setAttribute("parametro", param);
            request.getSession().setAttribute("modo", modo);
            request.getSession().setAttribute("numResultsPage", n);
            RequestDispatcher rd = null;

            if (user == null) {
                rd = request.getRequestDispatcher("/AjaxHome.jsp");
            } else {
                switch (user.getProfile()) {
                    case ADMIN:
                        rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
                        break;
                    case ACADEMIC:
                        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
                        break;
                    case COMMON:
                        rd = request.getRequestDispatcher("/AjaxHomeUserCommon.jsp");
                        break;
                }
            }
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
