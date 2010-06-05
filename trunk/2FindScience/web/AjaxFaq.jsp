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
        <link rel = "stylesheet" type = "text/css" href = "style.css"/>
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Frequently Asked Questions</p>
            <table class="maintenance"  cellspacing="15px" >
                <tr>
                    <td>
                        <strong>How can I insert publications?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Firstly you have to have an Academic Profile (you can check this in the <a href="#">Settings</a> tab in your menu after logging in).</p>
                        <p>If your profile is correct, you can check the <a href="#">Publications</a> tab on your menu.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>How can I register?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Click <a href="#">here</a> to register. There's also a link on the top of the page.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Can I change my password?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Yes. Click in the <a href="#">Configurations</a> tab in your menu.</p>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


