<%--
    Document   : home_admin
    Created on : 24/04/2010, 11:24:18
    Author     : Welington
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
        <title>2FindScience - Administrador</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
        <script type="text/javascript" src="js/mootools-1.2.4-core.js"></script>
        <script type="text/javascript" src="js/mootools-1.2.4.4-more.js"></script>
        <script type="text/javascript" src="js/calendar-eightysix-v1.1.js"></script>
        <link type="text/css" media="screen" href="css/calendar-eightysix-v1.1-vista.css" rel="stylesheet" />

        <script type="text/javascript">
            function loadAjaxAdmin(name){
                current = document.getElementById("currentMenu").value;
                document.getElementById( current ).className="";

                switch (name) {
                    case "Home":
                        document.getElementById("home").className="current";
                        document.getElementById("currentMenu").value="home";
                        callServlet('NewsMaintenance','AjaxNewsContent');
                        callServlet('Filter?action=RequestUpgrade', 'AjaxContent');
                        break;

                    case "Users":
                        document.getElementById("user").className="current";
                        document.getElementById("currentMenu").value="user";
                        loadContent('UserMaintenanceAdmin.jsp', 'AjaxContent');
                        break;

                    case "Publications":
                        document.getElementById("pub").className="current";
                        document.getElementById("currentMenu").value="pub";
                        loadContent('PublicationMaintenance.jsp', 'AjaxContent');
                        break;

                    case "Settings":
                        document.getElementById("set").className="current";
                        document.getElementById("currentMenu").value="set";
                        loadContent('Settings.jsp', 'AjaxContent');
                        callServlet('Filter?action=ThemeUpgradeFilter', 'AjaxContent');
                        break;

                    case "Events":
                        document.getElementById("events").className="current";
                        document.getElementById("currentMenu").value="events";
                        loadContent('Events.jsp', 'AjaxContent');
                        break;

                    case "About":
                        document.getElementById("about").className="current";
                        document.getElementById("currentMenu").value="about";
                        loadContent('About.jsp', 'AjaxContent');
                        break;

                    case "Profile":
                        document.getElementById("prof").className="current";
                        document.getElementById("currentMenu").value="prof";
                        callServlet("MaintenanceUserData?action=consultProfile&profile=admin", 'AjaxContent');
                        break;
                    case "Faq":
                        document.getElementById("faq").className="current";
                        document.getElementById("currentMenu").value="faq";
                        loadContent('Faq.jsp', 'AjaxContent');
                        break;
                }
            }
        </script>
    </head>
    <body onload="loadAjaxAdmin('Home')">
        <div id="loading" class="admin" style="visibility: hidden"></div>
        <div id="header" class="admin">
            <input type="hidden" id="currentMenu" value="home"/>
            <ul>
                <li id="home"> <a href="#" name="Home"onclick="loadAjaxAdmin(name)">Home</a> </li>
                <li id="user"> <a href="#" name="Users" onclick="loadAjaxAdmin(name)">Users</a> </li>
                <li id="pub"> <a href="#" name="Publications" onclick="loadAjaxAdmin(name)">Publications</a> </li>
                <li id="set"> <a href="#" name="Settings" onclick="loadAjaxAdmin(name)"> Settings </a> </li>
                <li id="events"> <a href="#" name="Events" onclick="loadAjaxAdmin(name)">Events</a></li>
                <li id="prof"> <a href="#" name="Profile" onclick="loadAjaxAdmin(name)">Profile</a> </li>
                <li id="about"> <a href="#" name="About" onclick="loadAjaxAdmin(name)">About</a></li>
                <li id="faq"> <a href="#" name="Faq" onclick="loadAjaxAdmin(name)">FAQ</a></li>
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

            <div id="AjaxContent" > 
            </div>

            <div id="footer">
                <p> © 2FindScience Team. All Rights Reserved  </p>
            </div>
        </div>
    </body>
</html>