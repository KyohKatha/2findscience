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
                            }else{
                                if(action.equals("newOption")){
                                    this.newOption(request, response);
                                }
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
            Proceedings proceedings = null;
            request.setAttribute("indexSelected", index + "");
            request.setAttribute("typePublication", typePublication);

            try {
                if (typePublication.equals("phdthesis")) {
                    phdThesis = connection.setPhdThesis(publication.getCod());
                    request.setAttribute("phdthesis", phdThesis);
                } else {
                    if (typePublication.equals("mastersthesis")) {
                        masterThesis = connection.setMastersThesis(publication.getCod());
                        request.setAttribute("mastersthesis", masterThesis);
                    } else {
                        if (typePublication.equals("inproceedings")) {
                            inproceedings = connection.setInproceedings(publication.getCod());
                            request.setAttribute("inproceedings", inproceedings);
                        } else {
                            if (typePublication.equals("book")) {
                                book = connection.setBook(publication.getCod());
                                request.setAttribute("book", book);
                            } else {
                                if (typePublication.equals("incollection")) {
                                    incollection = connection.setIncollection(publication.getCod());
                                     request.setAttribute("incollection", incollection);
                                } else {
                                    if (typePublication.equals("www")) {
                                        www = connection.setWww(publication.getCod());
                                        request.setAttribute("www", www);
                                    } else {
                                        if (typePublication.equals("article")) {
                                            article = connection.setArticle(publication.getCod());
                                            request.setAttribute("article", article);
                                        } else {
                                            proceedings = connection.setProceedings(publication.getCod());
                                            request.setAttribute("proceedings", proceedings);
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
        String bookTitle = request.getParameter("booktitle");
        String editor = request.getParameter("editor");
        String publisher = request.getParameter("publisher");

        //VERIFICAR AQUII
      /*  request.getSession().removeAttribute("Author");
        request.getSession().removeAttribute("BookTitle");
        request.getSession().removeAttribute("Editor");
        request.getSession().removeAttribute("Publisher"); */

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
        String school = request.getParameter("school");
        String isbn = request.getParameter("isbn");
        String chapter = request.getParameter("chapter");
        String address = request.getParameter("address");

        try {
            if (typePublication.equals("phdthesis")) {
                PhdThesis phdThesis = new PhdThesis(title, url, school, number, volume, month, ee, isbn, author, 0);
                connection.savePhdThesis(phdThesis,user.getLogin() );
            } else {
                if (typePublication.equals("mastersthesis")) {
                    MasterThesis masterThesis = new MasterThesis(title, url, school, author, 0);
                    connection.saveMasterThesis(masterThesis, user.getLogin());
                } else {
                    if (typePublication.equals("inprocedings")) {
                        Inproceedings inproceedings = new Inproceedings(title, url, ee, startPage, endPage, cdrom, note, number, month, author, bookTitle, publisher, editor, 0);
                        connection.saveInproceedings(inproceedings, user.getLogin());
                    } else {
                        if (typePublication.equals("book")) {
                            Book book = new Book(title, url, ee, volume, cdrom, month, bookTitle, publisher, editor, author, isbn, 0);
                            connection.saveBook(book, user.getLogin());
                         } else {
                            if (typePublication.equals("incollection")) {
                                Incollection incollection = new Incollection(title, url, ee, startPage, endPage, cdrom, chapter, editor, author, publisher, bookTitle, isbn, 0);
                                connection.saveIncollection(incollection, user.getLogin());
                            } else {
                                if (typePublication.equals("www")) {
                                    Www www = new Www(title, url, ee, note, editor, author, publisher, bookTitle, 0);
                                    connection.saveWww(www, user.getLogin());
                                } else {
                                    if (typePublication.equals("article")) {
                                        Article article = new Article(title, url, ee, journal, volume, note, number, month, cdrom, startPage, endPage, author, bookTitle, publisher, editor, 0);
                                        connection.saveArticle(article, user.getLogin());
                                    } else { //Proceedings
                                        Proceedings proceedings = new Proceedings(title, url, ee, journal, volume, number, note, month, address, editor, author, publisher, bookTitle, isbn, 0);
                                        connection.saveProceedings(proceedings, user.getLogin());
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
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> saving <p>publication.</p><p>- Click on the box to close it.</p>");
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

        String typePublication = request.getParameter("typePublication");
        String title = request.getParameter("title");
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
        String school = request.getParameter("school");
        String isbn = request.getParameter("isbn");
        String chapter = request.getParameter("chapter");
        String address = request.getParameter("address");


        try {
            if (typePublication.equals("phdthesis")) {
                PhdThesis newPhdThesis = new PhdThesis(title, url, school, number, volume, month, ee, isbn, null, 0);
                connection.updatePhdThesis(newPhdThesis, publication.getCod() );
            } else {
                if (typePublication.equals("mastersthesis")) {
                    MasterThesis newMasterThesis = new MasterThesis(title, url, school, null, 0);
                    connection.updateMasterThesis(newMasterThesis, publication.getCod());
                } else {
                    if (typePublication.equals("inprocedings")) {
                        Inproceedings newInproceedings = new Inproceedings(title, url, ee, startPage, endPage, cdrom, note, number, month, null, null, null, null, 0);
                        connection.updateInproceedings(newInproceedings, publication.getCod());
                    } else {
                        if (typePublication.equals("book")) {
                            Book newBook = new Book(title, url, ee, volume, cdrom, month, null, null, null, null, isbn, 0);
                            connection.updateBook(newBook, publication.getCod());
                        } else {
                            if (typePublication.equals("incollection")) {
                                Incollection newIncollection = new Incollection(title, url, ee, startPage, endPage, cdrom, chapter, null, null, null, null, isbn, 0);
                                connection.updateIncollection(newIncollection, publication.getCod());
                            } else {
                                if (typePublication.equals("www")) {
                                    Www newWww = new Www(title, url, ee, note, null, null, null, null, 0);
                                    connection.updateWww(newWww, publication.getCod());
                                } else {
                                    if (typePublication.equals("article")) {
                                        Article newArticle = new Article(title, url, ee, journal, volume, note, number, month, cdrom, startPage, endPage, null, null, null, null, 0);
                                        connection.updateArticle(newArticle, publication.getCod());
                                    } else { //Proceedings
                                        Proceedings newProceedings = new Proceedings(title, url, ee, journal, volume, number, note, month, address, null, null, null, null, isbn, 0);
                                       connection.updateProceedings(newProceedings, publication.getCod());
                                    }
                                }
                            }
                        }
                    }
                }
            }
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Publication</strong> was updated successfully!</p><p>- Click on the box to close it.</p>");

        } catch (PublicationDAOException e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> updating <strong>publication</strong>.</p><p>- Click on the box to close it.</p>");
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
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> deleting <strong>publication</strong>.</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
    }


   private void managePosts(HttpServletRequest request, HttpServletResponse response, int mode)
            throws ServletException, IOException {

        String sCod = (String) request.getParameter("publication");
        double codPublication = Double.parseDouble(sCod);
        Publication pub = null;
        
        try {
            System.out.println("Pegar publicacao: " + sCod);

            pub = connection.getPublication(codPublication);
            switch (mode) {
                //Consulta de posts
                case 0:
                    break;

                case 1:
                    String userLogin = request.getParameter("login");
                    String text = request.getParameter("text");
                    connection.insertPost(codPublication, userLogin, text);
                    request.getSession().setAttribute("type", "success");
                    request.getSession().setAttribute("message", "<p>- The <strong>post</strong> was saved successfully!</p><p>- Click on the box to close it.</p>");
                    break;

            }

            if(pub != null){
                System.out.println("blzura blzuran");
            }else{
                 System.out.println("pepino");
            }
            
            System.out.println("antes posts " + codPublication);
            ArrayList<Post> result = connection.getPosts(codPublication);
            System.out.println("depos post");
            pub.setPosts(result);

            System.out.println(pub.getCod() + " - " + pub.getTitle());

            request.setAttribute("publication", pub);

            rd = request.getRequestDispatcher("/AjaxSearchForum.jsp");
            
        } catch (PublicationDAOException ex) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> saving post.</p><p>- Click on the box to close it.</p>");
            rd = request.getRequestDispatcher("/AjaxSearchResult.jsp");
        }
    }

       private void newOption(HttpServletRequest request, HttpServletResponse response) {
        String newOption = (String) request.getParameter("newOption");
        String nameOption = (String) request.getParameter("nameOption");

        try{
            if(nameOption.equals("Author")){
                connection.insertNewAuthor(newOption);
            }else{
                if(nameOption.equals("Editor")){
                     connection.insertNewEditor(newOption);
                }else{
                    if(nameOption.equals("Publisher")){
                        connection.insertNewPublisher(newOption);
                    }
                }
            }
            request.setAttribute("type", "success");
            request.setAttribute("message", "<p>- The <strong>new " + nameOption + "</strong> was register successfully!</p><p>- Click on the box to close it.</p>");
        }catch(PublicationDAOException ex){
            ex.printStackTrace();
            request.setAttribute("type", "critical");
            request.setAttribute("message", "<p>- <strong>Error</strong> saving new " + nameOption + ".</p><p>- Click on the box to close it.</p>");
        }
        rd = request.getRequestDispatcher("/popupSelectBox.jsp?nameOption=" + nameOption);
    }
}
        
