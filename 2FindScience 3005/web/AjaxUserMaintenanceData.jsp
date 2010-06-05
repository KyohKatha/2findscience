<%--
    Document   : events_data
    Created on : 27/04/2010, 06:38:15
    Author     : Gustavo Henrique
--%>

<%
            User u = (User) request.getSession().getAttribute("selectedUser");
            String type = (String) request.getSession().getAttribute("type");
            String message = (String) request.getSession().getAttribute("message");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Pkg2FindScience.User" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>

    <% if (u == null) {%>
    <div id="msg">
        <fieldset class="critical" onclick="closeMessageBox()">
            <legend>Error</legend>
            <p>-  No user found.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
    </div>
    <% } else {
         if (type == null) {%>
    <div id="msg">
        <fieldset class="warning" onclick="closeMessageBox()">
            <legend>Warning</legend>
            <p>-  User loaded for edition.</p>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
    </div>
    <% } else {%>
    <div id="msg">
        <fieldset class="critical" onclick="closeMessageBox()">
            <legend>Error</legend>
            <p>- Error <strong>connection</strong> with database </p>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
    </div>
    <%       }
                }
    if(u != null){ %>

    <form id="formUser" method="post" action="#" onsubmit="validateFormUser('save')">
        <table class="maintenance" align="center" cellspacing="15px">
            <tr>
                <td>Login:</td>
                <% if (u == null) {%>
                <td><input type="text" id="login" value="" name="login" size="25" maxlength="25" disabled/></td>
                    <%} else {%>
                <td><input type="text" id="login" value="<%=u.getLogin()%>" name="login" size="25" maxlength="25" disabled/></td>
                    <%}%>
            </tr>
            <tr>
                <td>(*)Name:</td>
                <% if (u == null) {%>
                <td><input type="text" id="name" value="" name="name" size="60" maxlength="60" /></td>
                    <%} else {%>
                <td><input type="text" id="name" value="<%=u.getName()%>" name="name" size="60" maxlength="60" /></td>
                    <%}%>
            </tr>
            <tr>
                <td>Email:</td>
                <% if (u == null) {%>
                <td><input type="text" id="email" value="" name="email" size="60" maxlength="40" /></td>
                    <%} else {%>
                <td><input type="text" id="email" value="<%=u.getEmail()%>" name="email" size="60" maxlength="40" /></td>
                    <%}%>
            </tr>
            <tr>
                <td>Profile:</td>
                <%if (u.getProfile() == 2) {%>
                <td><input disabled type="text" id="profile" value="Common" name="profile" size="10" maxlength="40" /></td>
                    <%} else if (u.getProfile() == 1) {%>
                <td><input disabled type="text" id="profile" value="Academic" name="profile" size="10" maxlength="40" /></td>
                    <%} else {%>
                <td><input disabled type="text" id="profile" value="Admin" name="profile" size="10" maxlength="40" /></td>
                    <%}%>
            </tr>

            <tr>
                <td>Personal page (Ex.: Lattes) </td>
                <% if (u == null) {%>
                <td><input type="text" value="" id="page" name="page" size="30" maxlength="50" /></td>
                    <%} else {%>
                <td><input type="text" value="<%=u.getPage()%>" id="page" name="page" size="30" maxlength="50" /></td>
                    <%}%>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="submit" class="button" value="Save" name="save" />
                        <%if (u.getProfile() == 2) {%>
                        <input type="button" class="button" value="Upgrade!" name="upgrade" onclick="updateUpgrade('<%=u.getLogin()%>', 1)"/>
                        <%}%>
                        <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'content')"/>
                    </div>
                </td>
            </tr>
        </table>
    </form>
                        <%}%>
</html>