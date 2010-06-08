/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pkg2FindScience.BDConnection;
import Pkg2FindScience.User;
import Pkg2FindScience.PublicationDAOException;
import Pkg2FindScience.Subject;
import java.io.IOException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo Henrique
 */
public class MaintenanceUserData extends HttpServlet {

    final int ADMIN = 0;
    final int ACADEMIC = 1;
    final int COMMON = 2;
    final int ALLOW = 3;
    final int DENY = 4;
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
            throws ServletException, IOException, PublicationDAOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");

        try {
            connection = BDConnection.getInstance();
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");

            if (user.getProfile() == ADMIN) {
                rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
            } else {
                if (user.getProfile() == COMMON) {
                    rd = request.getRequestDispatcher("/AjaxHomeUserCommon.jsp");
                } else {
                    rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
                }
            }
            rd.forward(request, response);
        }

        try {
            if (action.equals("show")) {
                this.show(request, response);
            } else if (action.equals("save")) {
                this.save(request, response);
            } else if (action.equals("allowUpgrade")) {
                this.updateUpgrade(request, response, ALLOW);
            } else if (action.equals("denyUpgrade")) {
                this.updateUpgrade(request, response, DENY);
            } else {
                if (action.equals("consultRegister")) {
                    this.consultRegister(request, response);
                } else {
                    if (action.equals("consultProfile")) {
                        this.consultProfile(request, response, user);

                    } else {
                        String login = request.getParameter("login");
                        String password = request.getParameter("password");
                        String name = request.getParameter("name");
                        String email = request.getParameter("email");
                        String page = request.getParameter("page");
                        String subjects = request.getParameter("subjects");

                        User newUser = new User();
                        newUser.setLogin(login);
                        newUser.setPassword(password);
                        newUser.setName(name);
                        newUser.setEmail(email);
                        newUser.setPage(page);

                        if (action.equals("saveRegister")) { //Register new User
                            this.saveRegister(request, response, newUser, subjects);

                        } else { //Update profile
                            this.updateProfile(request, response, newUser, subjects);
                        }
                    }
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
        try {
            processRequest(request, response);



        } catch (PublicationDAOException ex) {
            Logger.getLogger(MaintenanceUserData.class.getName()).log(Level.SEVERE, null, ex);
        }


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
        try {
            processRequest(request, response);



        } catch (PublicationDAOException ex) {
            Logger.getLogger(MaintenanceUserData.class.getName()).log(Level.SEVERE, null, ex);
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

    private void consultRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, PublicationDAOException {

        try {
            Vector subjects = connection.getSubjects();
            request.setAttribute("subjects", subjects);
            rd = request.getRequestDispatcher("/AjaxRegister.jsp");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> getting subjects.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxHome.jsp");
        }
    }

    private void consultProfile(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, PublicationDAOException {

        String profile = (String) request.getParameter("profile");
        request.setAttribute("profile", profile);

        try {
            Vector subjectsUser = connection.getSubjectsUser(user);
            request.setAttribute("subjectsUser", subjectsUser);
            setHiddenSubjects(request, response, subjectsUser);
            Vector subjects = connection.getSubjectsAvailable(subjectsUser);
            request.setAttribute("subjects", subjects);
            rd = request.getRequestDispatcher("/AjaxEditProfile.jsp");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> getting subjects.</p><p>- Click on the box to close it.</p>");
            if (profile.equals("admin")) {
                rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
            } else {
                if (profile.equals("user")) {
                    rd = request.getRequestDispatcher("/AjaxHomeUserCommon.jsp");
                } else {
                    rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
                }
            }
        }
    }

    private void saveRegister(HttpServletRequest request, HttpServletResponse response, User newUser, String subjects)
            throws ServletException, IOException, PublicationDAOException {

        try {
            connection.registerUser(newUser, subjects);
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>register</strong> was saved successfully!</p><p>- Click on the box to close it.</p>");

            rd = request.getRequestDispatcher("/AjaxHome.jsp");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", e.getMessage());
            rd = request.getRequestDispatcher("/AjaxHome.jsp");

        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User newUser, String subjects)
            throws ServletException, IOException, PublicationDAOException {

        User currentUser = (User) request.getSession().getAttribute("user");
        String profile = (String) request.getParameter("profile");

        try {
            connection.updateUser(currentUser, newUser, subjects);
            request.getSession().removeAttribute("user");
            request.getSession().setAttribute("user", newUser);
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Register</strong> was updated successfully!</p><p>- Click on the box to close it.</p>");
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
        }
        if (profile.equals("admin")) {
            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        } else {
            if (profile.equals("user")) {
                rd = request.getRequestDispatcher("/AjaxHomeUserCommon.jsp");
            } else {
                rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
            }
        }
    }

    public void setHiddenSubjects(HttpServletRequest request, HttpServletResponse response, Vector subjects) {
        String hiddenSubjects = "";
        for (int i = 0; i < subjects.size(); i++) {
            Subject subject = (Subject) subjects.elementAt(i);
            hiddenSubjects += subject.getName() + ";";
        }
        request.setAttribute("hiddenSubjects", hiddenSubjects);
    }

    private void updateUpgrade(HttpServletRequest request, HttpServletResponse response, int mode) {
        String login = (String) request.getParameter("login");

        try {
            switch (mode) {
                case ALLOW:
                    connection.updateUpgrade(login, true);
                    break;

                case DENY:
                    connection.updateUpgrade(login, false);
                    break;

            }
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        }

        request.getSession().setAttribute("type", "success");
        String message = "<p>- The <strong>Upgrade</strong> to user <strong>" + login + "</strong> was ";

        switch (mode) {
            case ALLOW:
                message += "allowed";
                break;

            case DENY:
                message += "denied";
                break;

        }
        message += "com sucesso!</p><p>- Click on the box to close it.</p>";

        request.getSession().setAttribute("message", message);
        //rd = request.getRequestDispatcher("/AjaxHomeAdmin.jsp");
        rd = request.getRequestDispatcher("Filter?action=RequestUpgrade");

    }

    private void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int index = Integer.parseInt(request.getParameter("index"));
        Vector users = (Vector) request.getSession().getAttribute("userVector");

        //request.getSession().setAttribute("index", index);

        User u = null;

        if (index > 0) {
            u = (User) users.get(index - 1);
        }

        request.getSession().setAttribute("selectedUser", u);

        request.getSession().setAttribute("type", null);
        request.getSession().setAttribute("message", null);

        rd = request.getRequestDispatcher("/AjaxUserMaintenanceData.jsp");
    }

    private void save(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = new User();

        u.setName(request.getParameter("name"));
        u.setLogin(request.getParameter("login"));
        u.setEmail(request.getParameter("email"));
        u.setPage(request.getParameter("page"));
        String profile = request.getParameter("profile");
        if (profile.equals("Admin")) {
            u.setProfile(0);
        } else if (profile.equals("Academic")) {
            u.setProfile(1);
        } else {
            u.setProfile(2);
        }
        try {
            connection.saveUser(u);
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- <strong>User</strong> saved successfully </p><p>- Click on the box to close it.</p>");

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database </p><p>- Click on the box to close it.</p>");
            request.getSession().setAttribute("selectedUser", u);

        } finally {
            rd = request.getRequestDispatcher("Filter?action=RequestUpgrade");
        }

    }

    private void requestUpgrade(String login, String pwd){
        
    }
}
