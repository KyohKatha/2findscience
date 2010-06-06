/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pkg2FindScience.BDConnection;
import Pkg2FindScience.Post;
import Pkg2FindScience.Publication;
import Pkg2FindScience.User;
import Pkg2FindScience.PublicationDAOException;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo Henrique
 */
public class Filter extends HttpServlet {

    final int ADMIN = 0;
    final int ACADEMIC = 1;
    final int COMMON = 2;
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

        String action = (String) request.getParameter("action");
        String parameter = (String) request.getParameter("parameter");
        User user = (User) request.getSession().getAttribute("user");
        boolean redirect = true;

        try {
            connection = BDConnection.getInstance();
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxPublicationData.jsp");
            rd.forward(request, response);
        }

        try {
            if (action.equals("PublicationMaintenance")) {
                this.publicationMaintenance(request, response, user, parameter);
            } else {
                if (action.equals("popupInsert")) {
                        this.popUpSelectBox(request, response);
                        redirect = false;
                } else {
                    if (action.equals("EventFilter")) {
                        this.EventFilter(request, response, user, parameter);
                    } else if (action.equals("RequestUpgrade")) {
                        this.upgradeRequest(request, response);
                    } else if (action.equals("ThemeUpgradeFilter")) {
                        this.ThemeUpgradeFilter(request, response);
                    } else if (action.equals("UserFilter")){
                        this.UserFilter(request, response, parameter);
                    }
                }
            }
        } finally {
            if (redirect) {
                rd.forward(request, response);
            }
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

    private void publicationMaintenance(HttpServletRequest request, HttpServletResponse response, User user, String parameter)
            throws ServletException, IOException {

        String sQuery = null;

        if (user.getProfile() == ADMIN) {
            sQuery = "SELECT TOP 200 title, type, cod  FROM integrado.publication WHERE title like '%" + parameter + "%';";

        } else {
            sQuery = "SELECT TOP 200 title, type, cod FROM integrado.publication WHERE loginUser = '" + user.getLogin() + "' AND title like '%" + parameter + "%';";
        }

        try {
            Vector publications = connection.consultPublication(sQuery);
            request.getSession().setAttribute("publications", publications);
            rd = request.getRequestDispatcher("/AjaxGetPublicationMaintenance.jsp");

        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");

            rd = request.getRequestDispatcher("/AjaxPublicationData.jsp");
        }
    }

    private void EventFilter(HttpServletRequest request, HttpServletResponse response, User user, String parameter)
            throws ServletException, IOException {

        String sql = "SELECT TOP 200 cod, name, startDate, endDate, local"
                + " FROM integrado.bookTitle WHERE name LIKE '%" + parameter + "%';";

        Vector events;

        try {
            events = connection.getEvents(sql);
            request.getSession().setAttribute("eventVector", events);
            rd = request.getRequestDispatcher("/AjaxEventsTitle.jsp");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");

            rd = request.getRequestDispatcher("/AjaxEvents.jsp");
        }
    }

    private void upgradeRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ArrayList<User> result = connection.getUpdateRequests();
            request.setAttribute("result", result);
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
        } finally {
            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
            //rd = request.getRequestDispatcher("Filter?action=RequestUpgrade");
        }
    }

    private void ThemeUpgradeFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Vector subjects;

        try {
            subjects = connection.getSubjects();
            System.out.println("Size: " + subjects.size());
            request.getSession().setAttribute("subjectVector", subjects);

            String sql = "select upgrade from integrado.settings";
            ResultSet rs_up = connection.executeQuery(sql);
            int upgrade = 0;
            while (rs_up.next()) {
                upgrade = rs_up.getInt("upgrade");
            }
            request.getSession().setAttribute("upgrade", upgrade);

            rd = request.getRequestDispatcher("/AjaxSettings.jsp");
        } catch (Exception e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");

            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        }
    }


    private void UserFilter(HttpServletRequest request, HttpServletResponse response, String parameter)
            throws ServletException, IOException {

        String sql = "SELECT TOP 200 *"
                + " FROM integrado.userData WHERE login LIKE '%" + parameter + "%';";

        Vector users;

        try {
            users = connection.getUsers(sql);
            request.getSession().setAttribute("userVector", users);
            rd = request.getRequestDispatcher("/AjaxUserMaintenanceTitle.jsp");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database</p><p>- Click on the box to close it.</p>");
            request.getSession().setAttribute("userVector", new Vector());
            rd = request.getRequestDispatcher("/AjaxUserMaintenanceTitle.jsp");
        }
    }

     private void popUpSelectBox(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mode = (String) request.getParameter("mode");
        Vector available = null;

        try {

            if (mode.equals("author")) {
                available = connection.getAuthors();
            } else {
                if (mode.equals("booktitle")) {
                    available = connection.getBookTitle();
                } else {
                    if (mode.equals("editor")) {
                        available = connection.getEditor();
                    } else {
                        if (mode.equals("publisher")) {
                            available = connection.getPublisher();
                        }
                    }
                }
            }
            request.getSession().setAttribute("available", available);
            request.getSession().setAttribute("nameOption", mode);
        } catch (Exception e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> getting authors </p>");
        }
    }

}
