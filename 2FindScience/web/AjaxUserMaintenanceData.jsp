<%-- 
    Document   : user_data
    Created on : 27/04/2010, 07:05:58
    Author     : Gustavo Henrique
--%>

<%          //CONSULTAR OS DADOS DO USUARIO NO BANCO
            //COLOCA RETORNO DO RESULTSET nos value
            String upgrade = request.getParameter("upgrade");
            String login = request.getParameter("login");

            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
%>

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
        <script type="text/javascript" src="AjaxSimple.js"></script>
    </head>
    <div id="msg">
        <%
                    if (upgrade.equals("true")) {
        %>
        <fieldset class="information" onclick="closeMessageBox()">
            <legend>Information</legend>
            <p>-  All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
        <%                            }
        %>
    </div>
    <form id="formUser" action="RegisterUser" method="post" onsubmit="">
        <table align="center" class="maintenance" cellspacing="15px">
            <tr>
                <td>(*)Login:</td>
                <td><input type="text" id="login" value=<%out.print(login);%> name="login" size="25" maxlength="25" /></td>
            </tr>
            <tr>
                <td>(*)Password:</td>
                <td><input type="password" id="password" name="password" size="15" maxlength="15" /></td>
            </tr>
            <tr>
                <td>(*)Password Confirmation:</td>
                <td><input type="password" id="passwordConfirmation" name="passwordConfirmation" size="15" maxlength="15" /></td>
            </tr>
            <tr>
                <td>(*)Name:</td>
                <td><input type="text" id="name" value="TESTENAME" name="name" size="60" maxlength="60" /></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="text" id="email" value="aa@hotmail.com"name="email" size="60" maxlength="40" /></td>
            </tr>
            <tr>
                <td>(*)Profile:</td>
                <td>
                    <select size="1" name="profile">
                        <option value="0">Common</option>
                        <option value="1">Academic</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Personal page (Ex.: Lattes) </td>
                <td><input type="text" value="http://" name="page" size="30" maxlength="50" /></td>
            </tr>
            <tr>
                <td>Newsletter: </td>
                <td>
                    <input type="radio" name="newsletter" id="newsYes" value="0" /> Yes
                    <input type="radio" name="newsletter" id="newsNo" value="1" checked="yes"/> No
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="button" class="button" value="Save" name="save" onclick="btClickSave()"/>
                        <input type="button" class="button" value="Upgrade!" name="upgrade" onclick="alert('Upgrade approved from this user');"/>
                        <input type="reset" class="button" value="Clear" name="clear" />
                        <%
                                            switch (user.getProfile()) {
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
</html>