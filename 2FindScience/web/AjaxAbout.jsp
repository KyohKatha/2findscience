<%--
    Document   : home_academic
    Created on : 25/04/2010, 21:50:03
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
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">About 2FindScience</p>
            <table class="maintenance" cellspacing="15px">
                <tr>
                    <td colspan="2">
                        <strong> What?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        2Find Science is a project...
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Why?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        2Find Science is a project...
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Where?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        2Find Science is a project...
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="title">
                        <strong> Who?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        2Find Science is a project...
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


