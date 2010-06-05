<%-- 
    Document   : upgrade
    Created on : 27/04/2010, 06:12:41
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
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

        <script type="text/javascript">
            function upgradeConfirm(){
                if(document.getElementById("password").value == ""){
                    window.alert("You must enter your password");
                    return false;
                }

                if(document.getElementById("password").value == "user"){
                    document.getElementById("upgradeConfirm").innerHTML = "";
                    document.getElementById("upgradeConfirm").innerHTML =
                        "<p class=\"aviso\">" +
                        "Correct password. Your situation will be analysed soon.</p>";
                }
                else{
                    document.getElementById("upgradeConfirm").innerHTML = "";
                    document.getElementById("upgradeConfirm").innerHTML =
                        "<p class=\"aviso\">" +
                        "Incorrect password!" +
                        "<\p>" +

                        "<form id=\"formUpgrade\" action=\"\">" +
                        "<label>Your password:<input type=\"password\" id=\"password\"></label>" +
                        "<input type=\"button\" value=\"Upgrade\" onclick=\"upgradeConfirm()\">" +
                        "</form>" +

                        "<p>You still have 3 upgrade requests.</p>";
                }
            }
        </script>
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Upgrade</p>

            <p class="text">Here you can request an upgrade for your profile. It means that
                you can contribute to the content of this site with informations of
                your own articles and publications.</p>
            <p class="text">If you are an (acadêmico?) and has published an article, all
                you have to do is type you password in the text box below, click on "Upgrade" and
                wait for the approval of an administrator.</p>
            <p class="text">You will receive an e-mail informing the result of your request.
                If you don't get your new profile, you can request the upgrade
                again, but the maximum is
                <% //consultar o BD para exibir o número máximo de upgrades por usuário
                            out.println("3");
                %>
                times per account.</p>
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
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>

                <%                            }
                %>
            </div>
            <form id="formUpgrade" action="">
                <table align="center" cellspacing="15px">
                    <tr>
                        <td>(*)Your password</td>
                        <td><input type="password" id="password"></td>
                        <td><input type="button" class="button" value="Upgrade" onclick="upgradeConfirm()"></td>
                    </tr>
                </table>
            </form>
            <p>You still have 3 upgrade requests.</p>
        </div>
    </body>
</html>