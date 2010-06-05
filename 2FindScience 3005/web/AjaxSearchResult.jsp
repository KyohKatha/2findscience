<%--
    Document   : home_academic
    Created on : 25/04/2010, 21:50:03
    Author     : Gustavo Henrique
--%>



<%@page import="Pkg2FindScience.User" %>
<%@page import="Pkg2FindScience.Publication" %>
<%@page import="java.util.Vector" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Random" %>
<%@page import="java.lang.Math" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            User user = (User) session.getAttribute("user");

            //User user = new User();

            int numResultados = 5;
            Random random = new Random();

            final int ADMIN = 0;
            final int ACADEMIC = 1;
            final int COMMON = 2;

            //user.setProfile(ACADEMIC);
%>

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Search</p>
            <div id="msg">
                <%
                            String message, type;
                            message = (String) session.getAttribute("message");
                            type = (String) session.getAttribute("type");
                            session.removeAttribute("message");
                            session.removeAttribute("type");

                            if (message != null) {
                                out.println("<fieldset class=\"" + type + "\" onclick=\"closeMessageBox()\">");
                                String legend = "Undefined";
                                if (type == "information") {
                                    legend = "Information";
                                } else if (type == "critical") {
                                    legend = "Error";
                                } else if (type == "success") {
                                    legend = "Success";
                                } else if (type == "warning") {
                                    legend = "Warning";
                                }

                                out.println("<legend>" + legend + "</legend>");
                                out.println(message);
                                out.println("</fieldset>");
                            }

                %>
            </div>
            <form id="formBusca" action="Search" method="post" onsubmit="validateFormBusca()">
                <table class="search" align="center" cellspacing="15px">
                    <tr>
                        <td align="left" colspan="2"><input class="textBox" type="text" id="parametro" name="parametro" size="80"/></td>
                        <td align="center">
                            <select name="filtro" id="filtro">
                                <option value="both"> ISBN/Journal </option>
                                <option value="isbn"> ISBN </option>
                                <option value="journal"> Journal </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td  align="center">
                            <input type="submit" class="button" value="Search" name="search" />
                        </td>
                    </tr>
                </table>
            </form>

            <p class="title">Search results for " <%out.println((String) session.getAttribute("parametro"));%> "</p>
            <table align="center" class="maintenance" cellspacing="5px">
                <thead>
                    <tr><th align="left">
                            <%
                                        Vector<Publication> rs = (Vector) session.getAttribute("result");
                                        //rs.last();
                                        //int rowCount = rs.getRow();
                                        out.print(rs.size());%> results found
                        </th></tr>
                </thead>
                <tr>
                    <td>
                        <%
                                    //           Vector rs2 = (Vector) session.getAttribute("resultAuthors");
                                    //rs.beforeFirst();
                                    if (rs.size() > 0) {
                                        String modo = (String) session.getAttribute("modo");
                                        int numResultsPage = Integer.parseInt(session.getAttribute("numResultsPage").toString());
                                        int count = 0;
                                        int valor_comparacao;
                                        if (modo.equals("next")) {
                                            valor_comparacao = numResultsPage + 5;
                                            count = numResultsPage;
                                        } else {
                                            valor_comparacao = numResultsPage;
                                            count = numResultsPage - 5;
                                            numResultsPage -= 5;
                                        }
                                        if (rs.size() - numResultsPage < 5) {
                                            out.print("<p>Results " + numResultsPage + " to " + (numResultsPage + rs.size() - numResultsPage) + "</p>");
                                        } else {
                                            out.print("<p>Results " + numResultsPage + " to " + (numResultsPage + 5) + "</p>");
                                        }
                                        //int i = count * 4;
                                        request.getSession().setAttribute("publication", rs);
                                        
                                        while (count < valor_comparacao) {
                                            String isbn = rs.get(count).getIsbn();
                                            String title = rs.get(count).getTitle();
                                            String journal = rs.get(count).getJournal();
                                            count++;
                                            //i += 4;
                                            out.println("<tr>");
                                            out.println("<td>"); %>
                                            
                                            <a href="#" onclick="callServlet('PublicationMaintenance?action=managePost&publication=' + <%=rs.get(count-1).getCod()%> + '&position=' + <%=(count-1)%> + '&mode=0','AjaxContent')"/>
                                           <% if (user == null) {
                                                out.println("<ul class=\"guest\">");
                                            } else {
                                                switch (user.getProfile()) {
                                                    case 0:
                                                        out.println("<ul class=\"admin\">");
                                                        break;
                                                    case 1:
                                                        out.println("<ul class=\"academic\">");
                                                        break;
                                                    case 2:
                                                        out.println("<ul class=\"common\">");
                                                        break;
                                                    default:
                                                        out.println("<ul>");
                                                        break;
                                                }
                                            }
                                            //
                                            out.println("<li class=\"title\">" + title + "</li>");
                                            if (isbn != null) {
                                                out.println("<li>ISBN " + isbn + "</li>");
                                            }
                                            if (journal != null) {
                                                out.println("<li>Journal " + journal + "</li>");
                                            }
                                            out.println("</ul>");
                                            out.println("</td>");
                                            out.println("</tr>");

                                            if (rs.size() < count + 1) {
                                                break;
                                            }
                                        }
                                        if (rs.size() > numResultsPage) {
                                            //out.println("numResultados:" + numResultsPage);
                                            if (count > 5) {
                                                out.println("<td  align=\"left\">");
                                                out.println("<input class=\"button\" type=\"button\" value=\"Anterior\" onclick=\"callServlet('Search?action=doRefresh&modo=previous&numResultsPage=" + (numResultsPage) + "&parametro=" + session.getAttribute("parametro") + "', 'AjaxContent');\"/>");
                                                out.println("</td>");
                                            }
                                            if (rs.size() >= count + 1) {
                                                out.println("<td></td>");
                                                out.println("<td></td>");
                                                out.println("<td  align=\"left\">");
                                                out.println("<input class=\"button\" type=\"button\" value=\"Proxima\" onclick=\"callServlet('Search?action=doRefresh&modo=next&numResultsPage=" + (numResultsPage + 5) + "&parametro=" + session.getAttribute("parametro") + "', 'AjaxContent');\"/>");
                                                out.println("</td>");
                                            }
                                        }
                                    }
                        %>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


