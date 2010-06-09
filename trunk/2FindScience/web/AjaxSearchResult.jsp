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
                    //System.out.println(inText);
                    //System.out.println(outText);
                    return outText;
                }
            %>

            <form id="formBusca" action="#" method="post" onsubmit="return validateFormBusca('normal', event)">
                <%  Vector<Publication> rs = (Vector) session.getAttribute("result");%>
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
                        if (rs.size() > 0) {
                            String searchParam = (String) session.getAttribute("parametro");

                            int size = rs.size() * 69;
                            int capacity = 6;

                            String modo = (String) session.getAttribute("modo");
                            int numResultsPage = Integer.parseInt(session.getAttribute("numResultsPage").toString());
                            int count = 0;
                            int valor_comparacao;
                            if (modo.equals("next")) {
                                valor_comparacao = numResultsPage + capacity;
                                count = numResultsPage;
                            } else {
                                valor_comparacao = numResultsPage;
                                count = numResultsPage - capacity;
                                numResultsPage -= capacity;
                            }

                            if (size > 552) {
                                size = 552;
                            }

                            out.print("<div id=\"scroll\" style=\"height: auto\">");
            %>

            <table class="maintenance" align="left" cellspacing="1px">
                <tr>
                    <%
                                                String messageSearch = "";
                                                if (rs.size() - numResultsPage < capacity) {
                                                    messageSearch = "Results <strong>" + (numResultsPage + 1) + "</strong> to <strong>" + (numResultsPage + rs.size() - numResultsPage) + "</strong>";
                                                } else {
                                                    messageSearch = "Results <strong>" + (numResultsPage + 1) + "</strong> to <strong>" + (numResultsPage + capacity) + "</strong>";
                                                }

                                                messageSearch += " of about <strong>" + rs.size() + "</strong> for: <strong>\"" + searchParam + "\"</strong>";
                    %>
                    <td colspan="3">
                        <%= messageSearch%>
                    </td>
                </tr>
                <%
                                            request.getSession().setAttribute("publication", rs);
                                            while (count < valor_comparacao) {
                                                String isbn = rs.get(count).getIsbn();
                                                String title = rs.get(count).getTitle();
                                                String journal = rs.get(count).getJournal();
                                                count++;
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
                    <a href="#" onclick="callServlet('PublicationMaintenance?action=managePost&publication=' + <%=rs.get(count - 1).getCod()%> + '&mode=0','AjaxContent')">
                        <%
                                                            if (isbn != null && journal != null) {
                        %>
                        <p><% out.print(highlightText(searchParam, isbn)); %> <i> <% out.print(highlightText(searchParam, journal)); %> </i></p>
                        <%
                                                                        } else if (isbn != null) {
                        %>
                        <p> <% out.print(highlightText(searchParam, isbn)); %> </p>
                        <%
                                                                        } else {
                        %>
                        <p><% out.print(highlightText(searchParam, journal)); %></p>
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
                                                if (rs.size() < count + 1) {
                                                    break;
                                                }
                                            }
                %>
            </table>
            <%
                                        out.print("</div>");
                                        if (rs.size() > numResultsPage) {
            %>
            <div id="buttonsbox">
                <%
                                                //out.println("numResultados:" + numResultsPage);
                                                if (count > capacity) {
                                                    out.println("<input class=\"button\" type=\"button\" value=\"Anterior\" onclick=\"callServlet('Search?action=doRefresh&modo=previous&numResultsPage=" + (numResultsPage) + "&parametro=" + session.getAttribute("parametro") + "', 'AjaxContent');\"/>");
                                                }
                                                if (rs.size() >= count + 1) {
                                                    out.println("<input class=\"button\" type=\"button\" value=\"Proxima\" onclick=\"callServlet('Search?action=doRefresh&modo=next&numResultsPage=" + (numResultsPage + capacity) + "&parametro=" + session.getAttribute("parametro") + "', 'AjaxContent');\"/>");
                                                }
                %>
            </div>
            <%
                            }
                        } else {
                            out.println("<p>No results were found for: <strong>\"" + (String) session.getAttribute("parametro") + "\"</strong>");
                        }
            %>
        </div>
    </body>
</html>


