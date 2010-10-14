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

            <%!
                String highlightText(String searchText, String inText) {
                    String outText = "";

                    inText = inText.toLowerCase();
                    searchText = searchText.toLowerCase();
                    int sText = inText.indexOf(searchText);
                    int eText = sText + searchText.length() - 1;

                    for (int i = 0; i < inText.length(); i++) {
                        if (i == sText) {
                            outText += "<strong>";
                        } else if (i == eText + 1) {
                            outText += "</strong>";
                        }
                        outText += inText.charAt(i);
                    }
                    return outText;
                }
            %>

            <form id="formBusca" action="#" method="post" onsubmit="return validateFormBusca('normal', event)">
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
                        <td colspan="2">
                        </td>
                        <td  align="center">
                            <input type="submit" class="button" value="Search" name="search" />
                        </td>
                    </tr>
                </table>
            </form>

            <%
                        Vector<Publication> rs = (Vector) session.getAttribute("result");

                        if (rs.size() > 0) {
            %>
            <div id="scroll" style="height: auto">
                <table class="maintenance" align="left" cellspacing="1px">

                    <%
                                                String searchParam = (String) session.getAttribute("parametro");
                                                int resultsPerPage = 6;
                                                int initialPage = Integer.parseInt(session.getAttribute("initpage").toString());
                                                int currentPage = Integer.parseInt(session.getAttribute("currpage").toString());

                                                for (int i = (currentPage - 1) * resultsPerPage; i < currentPage * resultsPerPage && i < rs.size(); i++) {
                                                    String isbn = rs.get(i).getIsbn();
                                                    String title = rs.get(i).getTitle();
                                                    String journal = rs.get(i).getJournal();
                    %>
                    <tr>
                        <%
                                                                            if (user == null) {
                                                                                out.println("<td class=\"guest\" colspan=\"3\">");
                                                                            } else {
                                                                                switch (user.getProfile()) {
                                                                                    case 0:
                                                                                        out.println("<td class=\"admin\" colspan=\"3\">");
                                                                                        break;
                                                                                    case 1:
                                                                                        out.println("<td class=\"academic\" colspan=\"3\">");
                                                                                        break;
                                                                                    case 2:
                                                                                        out.println("<td class=\"common\" colspan=\"3\">");
                                                                                        break;
                                                                                    default:
                                                                                        out.println("<td colspan=\"3\">");
                                                                                        break;
                                                                                }
                                                                            }
                        %>
                    <div id="item" align="justify" style="width: 679px;">
                        <a href="#" onclick="callServlet('PublicationMaintenance?action=managePost&publication=' + <%=rs.get(i).getCod()%> + '&mode=0','AjaxContent')">
                            <%
                                                                                if (isbn != null && journal != null) {
                            %>
                            <p><% out.print(highlightText(searchParam, isbn));%> <i> <% out.print(highlightText(searchParam, journal));%> </i></p>
                            <%
                                                                                                            } else if (isbn != null) {
                            %>
                            <p> <% out.print(highlightText(searchParam, isbn));%> </p>
                            <%
                                                                                                            } else {
                            %>
                            <p><% out.print(highlightText(searchParam, journal));%></p>
                            <%
                                                                                                            }
                            %>
                        </a>
                        <p>
                            <%= title%>
                        </p>
                    </div>
                    <%
                                                                        out.print("</td>");
                    %>
                    </tr>
                    <%
                                                }
                    %>
                </table>
                <table id="paginacao" class="paginacao" align="center">
                    <tr>
                        <%
                                                    int capac = 20;
                                                    int maxPagina = (rs.size() / capac) + 1;
                                                    int cont = 0;

                                                    if (initialPage > 1) {
                                                        out.println("<td class=\"nav\" onclick=\"gerenciarPaginacao(\'<\'," + maxPagina + "," + capac + "," + "'" + searchParam + "'" + ")\"><</td>");
                                                    }

                                                    for (int i = initialPage; i < initialPage + capac; i++) {
                                                        cont++;
                        %>
                        <td class="pagina" id="<%= "pag" + cont%>" onclick="callServlet('Search?action=doRefresh&initpage=' + <%= initialPage%> + '&currpage=' + <%= i%> + '&parametro=' + <%= "'" + searchParam + "'"%>, 'AjaxContent');">
                            <%
                                                                                    out.print(i);
                            %>
                        </td>
                        <%
                                                    }
                                                    if (cont <= maxPagina) {
                                                        out.println("<td class=\"nav\" onclick=\"gerenciarPaginacao(\'>\'," + maxPagina + "," + capac + "," + "'" + searchParam + "'" + ")\">></td>");
                                                    }
                        %>
                    </tr>
                </table>
            </div>

            <%
                                    } else {
            %>
            <p>No results were found for: <strong><%= (String) session.getAttribute("parametro")%></strong></p>
            <%                        }
            %>
        </div>
    </body>
</html>


