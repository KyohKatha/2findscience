/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pkg2FindScience.*;
import Pkg2FindScience.PublicationDAOException;
import java.io.IOException;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Gustavo Henrique
 */
public class EventMaintenance extends HttpServlet {

    private BDConnection connection = null;
    private RequestDispatcher rd = null;

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

        String action = request.getParameter("action");

        try {
            connection = BDConnection.getInstance();
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxEvents.jsp");
            rd.forward(request, response);
        }

        try{
            if(action.equals("show")){
                this.show(request, response);
            } else {
                if(action.equals("save")){
                    this.save(request, response);
                }
            }
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


    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int index = Integer.parseInt(request.getParameter("index"));
        Vector events = (Vector) request.getSession().getAttribute("eventVector");
        //request.removeAttribute("eventVector");
        String edit = null;
        Booktitle b = null;

        if (index > 0 && index <= events.size()){
            // alterar um evento já existente
            b = (Booktitle) events.get(index-1);
            edit = "update";
            request.setAttribute("selectedEvent", b);
        } else {
            edit = "insert";
        }
        request.setAttribute("edit", edit);
        rd = request.getRequestDispatcher("/AjaxEventsData.jsp");

    }


    private void save(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Booktitle b = new Booktitle();

        b.setCod(Integer.parseInt(request.getParameter("cod")));
        b.setName(request.getParameter("name"));
        b.setStartDate(request.getParameter("startDate"));
        b.setEndDate(request.getParameter("endDate"));
        b.setLocal(request.getParameter("city"));

        try{
            if (b.getCod() == 0)
                connection.saveEvent(b);
            else
                connection.updateEvent(b);
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Event</strong> was saved successfully </p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        } catch (PublicationDAOException e){
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> saving new <strong>event</strong></p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        }
    }
}