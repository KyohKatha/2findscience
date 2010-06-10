/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import Pkg2FindScience.User;

/**
 *
 * @author Katha
 */
public class SendEmail extends HttpServlet {

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

        try {
            String acao = request.getParameter("acao");

            String host = "smtp.gmail.com";
            String to = "";
            String from = "";

            if(acao.equals("contato")){
                to = "2findscience@gmail.com";
                from = (String) request.getAttribute("email");
            } else {
                to = (String) request.getSession().getAttribute("email");
                System.out.println("To:"+to);
                from = "2findscience@gmail.com";
            }
            String password = "bccufscar2010";
            // Get system properties
            Properties props = new Properties();
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.host", "smtp.google.com");
            //props.put("mail.smtp.port", "587");
            props.put("mail.debug", "true");
            props.put("mail.smtps.auth", "true");
            Session session = Session.getInstance(props, null);

            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(from));
            Address toAddress = new InternetAddress(to);
            message.addRecipient(Message.RecipientType.TO, toAddress);
            if(acao.equals("contato")){
                message.setSubject(request.getParameter("assunto"));
                message.setContent("Name: " + request.getParameter("nome") + "\nE-mail: " + request.getParameter("email") + "\n"
                    + "Message: " + request.getParameter("comentario"), "text/plain");
            }else{
                message.setSubject("Upgrade Accepted!");
                message.setContent("Your Upgrade request was accepted!", "text/plain");
            }
            System.out.println("Enviando o email");

            //Transport.send(message);
            Transport t = session.getTransport("smtps");
            try {
                t.connect(host, "2findScience@gmail.com", password);
                t.sendMessage(message, message.getAllRecipients());
            } finally {
                t.close();
            }
            request.getSession().setAttribute("type", "success");
            request.getSession().setAttribute("message", "<p>- The <strong>Message</strong> was sent successfull!</p><p>- Click on the box to close it.</p>");

            RequestDispatcher rd = null;
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                rd = request.getRequestDispatcher("/AjaxHome.jsp");
            } else {
                switch (user.getProfile()) {
                    case 1:
                        rd = request.getRequestDispatcher("/AjaxHomeAcademic.jsp");
                        break;
                    case 2:
                        rd = request.getRequestDispatcher("/AjaxHomeUserCommon.jsp");
                        break;
                    default:
                        rd = request.getRequestDispatcher("/AjaxHome.jsp");
                        break;
                }
            }
            rd.forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("type", "critical");
            request.getSession().setAttribute("message", "<p>- <strong>Error</strong> sendind the message!</p><p>- Click on the box to close it.</p>");
            e.printStackTrace();
            RequestDispatcher rd = null;
            rd = request.getRequestDispatcher("/AjaxContact.jsp");
            rd.forward(request, response);
        } finally {
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
            throws ServletException,
            IOException {
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
            throws ServletException,
            IOException {
        processRequest(request, response);


    }
}
