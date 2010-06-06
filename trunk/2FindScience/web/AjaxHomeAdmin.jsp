<%--
    Document   : AjaxHomeAdmin
    Created on : 29/04/2010, 10:39:39
    Author     : Welington
--%>

<%@page import="java.util.ArrayList" %>
<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
    </head>
    <body>
        <div id="content" class="content">
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
            <p class="title">Search</p>
            <form id="formBusca" action="#" method="post" onsubmit="return validateFormBusca()">
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
            <%
                        ArrayList<User> result = (ArrayList<User>) request.getAttribute("result");

                        if (result != null && !result.isEmpty()) {
                            out.print("<p class=\"title\">Upgrade requests</p>");
                            // height 60px para 1 item
                            int size = result.size();
                            if (size > 9) {
                                out.print("<div id=\"scroll\" style=\"height:594px; border: 1px solid #666666;\">");
                            } else {
                                out.print("<div id=\"scroll\" style=\"height:" + 60 * size + "px; border: 1px solid #666666;\">");
                            }

            %>

            <table class="maintenance" align="left" cellspacing="5px">
                <%
                                            for (int i = 0; i < size; i++) {
                %>
                <tr>
                    <td>
                        <a href=#><img src="Imagens/Upgrade.png" alt="Upgrade" align="right" onclick="updateUpgrade(document.getElementById(<%= "'" + result.get(i).getLogin() + "'"%>).value, 1)"></a>
                    </td>
                    <td>
                        <a href=#><img src="Imagens/Refuse.png" alt="Refuse" align="right" onclick="updateUpgrade(document.getElementById(<%= "'" + result.get(i).getLogin() + "'"%>).value, 0)"></a>
                    </td>
                    <td>
                        <a href=#><img src="Imagens/Profile.png" alt="Profile" align="right"></a>
                    </td>
                    <td colspan="2">
                        <p><strong><%= result.get(i).getName()%></strong>,</p>
                    </td>
                    <td colspan="2">
                        <%
                                                                            String url = result.get(i).getPage();
                                                                            out.println("<a href=\"" + url + "\">" + url + "</a>");
                        %>
                    </td>
                    <td><input id="<%=result.get(i).getLogin()%>" type="hidden" value="<%=result.get(i).getLogin()%>"></td>
                </tr>
                <%
                                            }
                %>
            </table>
            <%
                            out.print("</div>");
                        }
            %>

        </div>
    </body>
</html>
