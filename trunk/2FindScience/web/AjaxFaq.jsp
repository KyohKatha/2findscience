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
                        <strong>How can I register?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>There's a link 'Register' on the top of the page, near the 'Home' tab.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Can I change my password?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Yes. Click on the 'Profile' tab in your menu.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Can I change my password?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Yes. Click on the 'Profile' tab in your menu.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>How can I insert publications?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Firstly you have to have an Academic Profile, which have a green banner.</p>
                        <p>If your profile is correct, you can check the 'Publications' tab on your menu.</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>My profile has an orange banner(Common Profile)! How can I acquire an Academic Profile?</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Click on the 'Profile' tab in your menu. Then, click on the 'Upgrade!' button, below your profile informations.</p>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


