<%--
    Document   : upgrade
    Created on : 27/04/2010, 06:12:41
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
            int max = Integer.parseInt(session.getAttribute("max").toString());
%>

<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>2FindScience - Events</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
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

            <p class="text">Here you can request an upgrade for your profile. This means that
                you can contribute to the content of this site with information about
                your own articles and publications.</p>
            <p class="text">If you are an academic and has published something, all
                you have to do is type your password in the text box below, click on "Upgrade" and
                wait for the approval of the administrator.</p>
            <p class="text">You will receive an e-mail informing the result of your request.
                If you don't get your new profile, you can request the upgrade
                again, but the maximum is
                <% //consultar o BD para exibir o número máximo de upgrades por usuário
                out.println(max);
                %>
                times per account.</p>

            <form id="formUpgrade" action="#" method="post" onsubmit="return validateFormRequest2()">
                <table align="center" cellspacing="15px">
                    <tr>
                        <%
                            if (user.getNumTrialUpgrade() >= max) {
                                %>
                                <td style="color: blue">You have reached the maximum limit of requests!</td>
                                <%
                            } else {
                                if (user.getUpgrade() == 1) {
                                %>
                                    <td style="color: blue">You have already requested your upgrade. Please wait the Admin confirm your request!</td>
                                <%
                                } else {
                                    %>
                                        <td>(*)Your password</td>
                                        <td><input type="password" id="password"></td>
                                        <td><input type="submit" class="button" value="Upgrade"></td>
                                    <%
                                }
                            }
                        %>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>