<%--
    Document   : contact
    Created on : 25/04/2010, 21:50:03
    Author     : Welington
--%>
<%
            User user = (User) session.getAttribute("user");
            int profile = -1;

            if (user != null) {
                profile = user.getProfile();
            }

            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
%>
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
            <p class="title">Contact 2FindScience</p>

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
                            } else {%>
                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>-  All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>
                <% }%>
            </div>

            <form id="formContato" action="#" method="post" onsubmit="return validateFormContato()">
                <table class="maintenance" align="center" cellspacing="15px">
                    <tr>
                        <td>Name </td>
                        <td class="tooltip">
                            <input id="nome" name="nome" type="text"  size="70"  maxlength="1000"/>
                            <span>Insert your name</span></td>
                    </tr>
                    <tr>
                        <td>(*)E-mail </td>
                        <td class="tooltip"><input id="email" name="email" type="text" size="70" maxlength="1000"/>
                            <span>Insert your email</span></td>
                    </tr>
                    <tr>
                        <td>Subject </td>
                        <td class="tooltip">
                            <select id="assunto" name="assunto" size="1" id="D1" name="D1">
                                <option value="duvidas">Questions</option>
                                <option value="sugestoes">Sugestions</option>
                                <option value="crÃ­ticas">Critics</option>
                                <option value="novidades">News</option>
                                <option value="outro">Other</option>
                            </select><span>Select subject</span></td>
                    </tr>
                    <tr>
                        <td>(*)Message </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="tooltip">
                            <textarea id="comentario" name="comentario" cols="67" rows="7" ></textarea>
                            <span>Insert your message</span></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="buttonsbox">
                                <input type="submit" class="button" value="Save" name="save"/>
                                <input type="reset" class="button" value="Clear" name="clear"/>
                                <%
                                            switch (profile) {
                                                case ADMIN:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                case COMMON:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeUserCommon.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                case ACADEMIC:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAcademic.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                default:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('Home.jsp', 'AjaxContent')"/>
                                <%
                                            }
                                %>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>