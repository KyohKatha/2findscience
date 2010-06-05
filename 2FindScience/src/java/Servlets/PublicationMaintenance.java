/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pkg2FindScience.*;
import Pkg2FindScience.PublicationDAOException;
import java.io.IOException;
import java.util.ArrayList;
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
public class PublicationMaintenance extends HttpServlet {

    final int ADMIN = 0;
    final int ACADEMIC = 1;
    final int COMMON = 2;
    private BDConnection connection = null;
    private RequestDispatcher rd = null;
    private User user;

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
        user = (User) request.getSession().getAttribute("user");

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
            if (action.equals("Consult")) {
                this.consult(request, response);
            } else {
                if (action.equals("savePublication")) {
                    this.savePublication(request, response);
                } else {
                    if (action.equals("updatePublication")) {
                        this.updatePublication(request, response);
                    } else {
                        if (action.equals("deletePublication")) {
                            this.deletePublication(request, response);
                        }else{
                            if (action.equals("managePost")) {
                                int mode  = Integer.parseInt( request.getParameter("mode"));
                                this.managePosts(request, response, mode);
                            }
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

    private void consult(HttpServletRequest request, HttpServletResponse response) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (user.getProfile() != ADMIN && index == 0) {
            rd = request.getRequestDispatcher("/AjaxPublicationDataSelect.jsp");
         } else {

       
        Vector publications = (Vector) request.getSession().getAttribute("publications");
        Publication publication = null;

        if (user.getProfile() == ADMIN) {
            publication = (Publication) publications.elementAt(index);
        } else {
            publication = (Publication) publications.elementAt(index - 1);
        }

        String typePublication = publication.getType();
        PhdThesis phdThesis = null;
        MasterThesis masterThesis = null;
        Inproceedings inproceedings = null;
        Book book = null;
        Incollection incollection = null;
        Www www = null;
        Article article = null;
        Proceedings procedings = null;
        request.setAttribute("indexSelected", index + "");

        try {
            if (typePublication.equals("phdThesis")) {
                phdThesis = (PhdThesis) request.getAttribute("phdThesis");
            } else {
                if (typePublication.equals("masterThesis")) {
                    masterThesis = (MasterThesis) request.getAttribute("masterThesis");
                } else {
                    if (typePublication.equals("inprocedings")) {
                        inproceedings = (Inproceedings) request.getAttribute("inproceedings");
                    } else {
                        if (typePublication.equals("book")) {
                            book = (Book) request.getAttribute("book");
                        } else {
                            if (typePublication.equals("incollection")) {
                                incollection = (Incollection) request.getAttribute("incollection");
                            } else {
                                if (typePublication.equals("www")) {
                                    www = (Www) request.getAttribute("www");
                                } else {
                                    if (typePublication.equals("article")) {
                                        article = connection.setArticle(publication.getCod());
                                        request.setAttribute("typePublication", "article");
                                        request.setAttribute("article", article);
                                    } else {
                                        procedings = (Proceedings) request.getAttribute("procedings");
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/AjaxPublicationData.jsp");
         }
    }

    private void savePublication(HttpServletRequest request, HttpServletResponse response) {

        String typePublication = request.getParameter("typePublication");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String bookTitle = request.getParameter("bookTitle");

        try {
            if (typePublication.equals("phdThesis")) {
            } else {
                if (typePublication.equals("masterThesis")) {
                } else {
                    if (typePublication.equals("inprocedings")) {
                    } else {
                        if (typePublication.equals("book")) {
                        } else {
                            if (typePublication.equals("incollection")) {
                            } else {
                                if (typePublication.equals("www")) {
                                } else {
                                    if (typePublication.equals("article")) {
                                        String cdrom = request.getParameter("cdrom");
                                        String journal = request.getParameter("journal");
                                        String note = request.getParameter("note");
                                        String month = request.getParameter("month");
                                        String ee = request.getParameter("ee");
                                        String url = request.getParameter("url");
                                        String startPage = request.getParameter("startPage");
                                        String endPage = request.getParameter("endPage");
                                        String volume = request.getParameter("volume");
                                        String number = request.getParameter("number");

                                        Article article = new Article(title, note, url, ee, journal, volume, note, number, month, cdrom, startPage, endPage);

                                        connection.saveArticle(article, user.getLogin(), author, bookTitle);
                                    } else {
                                        //procedings
                                    }
                                }
                            }
                        }
                    }
                }
            }
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Publication</strong> was saved successfully!</p><p>- Click on the box to close it.</p>");

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> saving publication!</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
    }

    private void updatePublication(HttpServletRequest request, HttpServletResponse response) {

        int index = Integer.parseInt(request.getParameter("index"));
        Vector publications = (Vector) request.getSession().getAttribute("publications");
        Publication publication = null;

        if (user.getProfile() == ADMIN) {
            publication = (Publication) publications.elementAt(index);
        } else {
            publication = (Publication) publications.elementAt(index - 1);
        }

        String titleAnt = publication.getTitle();
        String typePublication = request.getParameter("typePublication");
        String title = request.getParameter("title");

        try {
            if (typePublication.equals("phdThesis")) {
            } else {
                if (typePublication.equals("masterThesis")) {
                } else {
                    if (typePublication.equals("inprocedings")) {
                    } else {
                        if (typePublication.equals("book")) {
                        } else {
                            if (typePublication.equals("incollection")) {
                            } else {
                                if (typePublication.equals("www")) {
                                } else {
                                    if (typePublication.equals("article")) {
                                        String cdrom = request.getParameter("cdrom");
                                        String journal = request.getParameter("journal");
                                        String note = request.getParameter("note");
                                        String month = request.getParameter("month");
                                        String ee = request.getParameter("ee");
                                        String url = request.getParameter("url");
                                        String startPage = request.getParameter("startPage");
                                        String endPage = request.getParameter("endPage");
                                        String volume = request.getParameter("volume");
                                        String number = request.getParameter("number");

                                        Article article = new Article(title, note, url, ee, journal, volume, note, number, month, cdrom, startPage, endPage);

                                        connection.updateArticle(article, user.getLogin(), titleAnt);
                                    } else {
                                        //procedings
                                    }
                                }
                            }
                        }
                    }
                }
            }
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>publication</strong> was updated successfully!</p><p>- Click on the box to close it.</p>");

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> updating publication!</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
    }

    private void deletePublication(HttpServletRequest request, HttpServletResponse response) {
        int index = Integer.parseInt(request.getParameter("index"));
        Vector publications = (Vector) request.getSession().getAttribute("publications");
        Publication publication = (Publication) publications.elementAt(index - 1);
        String login = null;

        if (user.getProfile() != ADMIN) {
            login = user.getLogin();
        }

        try {
            connection.deletePublication(publication, login);
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Publication</strong> was deleted successfully!</p><p>- Click on the box to close it.</p>");

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> deleting publication!</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
    }


   private void managePosts(HttpServletRequest request, HttpServletResponse response, int mode)
            throws ServletException, IOException {

        String sCod = (String) request.getParameter("publication");
        double codPublication = Double.parseDouble(sCod);
        Vector publication  =  (Vector) request.getSession().getAttribute("publication");

        

        try {
            switch (mode) {
                //Consulta de posts
                case 0:
                    int position = Integer.parseInt( request.getParameter("position"));
                    request.getSession().setAttribute("position", position + "");
                    break;

                case 1:
                    String userLogin = request.getParameter("login");
                    String text = request.getParameter("text");
                    connection.insertPost(codPublication, userLogin, text);
                    request.getSession().setAttribute("type", "success");
                    request.getSession().setAttribute("message", "<p>- The <strong>post</strong> was saved successfully!</p><p>- Click on the box to close it.</p>");
                    break;

            }

            ArrayList<Post> result = connection.getPosts(codPublication);
            request.setAttribute("result", result);

            String positionSession = (String) request.getSession().getAttribute("position");
            Publication pub = (Publication) publication.elementAt( Integer.parseInt(positionSession));
            request.setAttribute("publication", pub);

            rd = request.getRequestDispatcher("/AjaxSearchForum.jsp");
            

        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> connecting database.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxSearchResult.jsp");
        }
    }
}
        
