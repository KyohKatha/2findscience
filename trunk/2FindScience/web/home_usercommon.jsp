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
        <title>2FindScience - Home</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

        <script type="text/javascript">

            function loadAjaxCommon(name){
                current = document.getElementById("currentMenu").value;
                document.getElementById( current ).className="";

                switch (name) {
                    case "Home":
                        document.getElementById("home").className="current";
                        document.getElementById("currentMenu").value="home";
                        callServlet('NewsMaintenance','AjaxNewsContent');
                        loadContent('HomeUserCommon.jsp', 'AjaxContent');
                        break;

                    case "Contact":
                        document.getElementById("cont").className="current";
                        document.getElementById("currentMenu").value="cont";
                        loadContent('Contact.jsp', 'AjaxContent');
                        break;

                    case "About":
                        document.getElementById("about").className="current";
                        document.getElementById("currentMenu").value="about";
                        loadContent('About.jsp', 'AjaxContent');
                        break;

                    case "Profile":
                        document.getElementById("prof").className="current";
                        document.getElementById("currentMenu").value="prof";
                        callServlet("MaintenanceUserData?action=consultProfile&profile=user", 'AjaxContent');
                        break;

                    case "Faq":
                        document.getElementById("faq").className="current";
                        document.getElementById("currentMenu").value="faq";
                        loadFaq();
                        break;
                }
            }
        </script>
    </head>
    <body onload="loadAjaxCommon('Home')">
        <div id="loading" class="user" style="visibility: hidden"></div>
        <div id="header" class="user">
            <input type="hidden" id="currentMenu" value="home"/>

            <ul>
                <li id="home"> <a href="#" name="Home" onclick="loadAjaxCommon(name)">Home</a></li>
                <li id="prof"> <a href="#" name="Profile" onclick="loadAjaxCommon(name)">Profile</a></li>
                <li id="about"> <a href="#" name="About" onclick="loadAjaxCommon(name)">About</a></li>
                <li id="faq"> <a href="#" name="Faq" onclick="loadAjaxCommon(name)">FAQ</a></li>
                <li id="cont"> <a href="#" name="Contact" onclick="loadAjaxCommon(name)">Contact</a></li>
                <li> <a href="logout.jsp">Logout</a></li>
            </ul>
        </div>

        <div id="search">
            <input type="text" id="parametro" name="search" size="47" maxlength="50" onkeypress="return validateFormBusca('rapida', event)" />
        </div>

        <div id="wrapper">
            <div id="welcome">
                Welcome,  <strong><%out.print(user.getName());%></strong>
            </div>

            <div id="news" class="news">
                <p class="title">News</p>
                <marquee id="AjaxNewsContent" height="85%" direction="up" onmouseover="this.stop()" onmouseout="this.start()">
                </marquee>
            </div>

            <div id="AjaxContent" > </div>
            <div id="footer">
                <p> © 2FindScience Team. All Rights Reserved  </p>
            </div>
        </div>
    </body>
</html>


