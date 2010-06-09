<%-- 
    Document   : Home
    Created on : 24/04/2010, 11:17:08
    Author     : Welington
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>2FindScience - Home</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <link rel="shortcut icon" type="image/x-icon" href="Imagens/favicon.ico">
        <script type="text/javascript" src="AjaxSimple.js"></script>

        <script type="text/javascript">

            function loadAjaxHome(name){

                current = document.getElementById("currentMenu").value;
                document.getElementById( current ).className="";

                switch (name) {
                    case "Home":
                        document.getElementById("home").className="current";
                        document.getElementById("currentMenu").value="home";
                        callServlet('NewsMaintenance','AjaxNewsContent');
                        loadContent('Home.jsp', 'AjaxContent');
                        break;
                    case "Register":
                        document.getElementById("reg").className="current";
                        document.getElementById("currentMenu").value="reg";
                        callServlet("MaintenanceUserData?action=consultRegister", 'AjaxContent');
                        break;
                    case "About":
                        document.getElementById("about").className="current";
                        document.getElementById("currentMenu").value="about";
                        loadContent('About.jsp', 'AjaxContent');
                        break;
                    case "Faq":
                        document.getElementById("faq").className="current";
                        document.getElementById("currentMenu").value="faq";
                        loadContent('Faq.jsp', 'AjaxContent');
                        break;
                    case "Contact":
                        document.getElementById("cont").className="current";
                        document.getElementById("currentMenu").value="cont";
                        loadContent('Contact.jsp', 'AjaxContent');
                        break;
                }
            }
        </script>
    </head>

    <body onload="loadAjaxHome('Home')">
        <div id="loading" class="guest" style="visibility: hidden"></div>
        <div id="headerbg">
            <div id="header">
                <input type="hidden" id="currentMenu" value="home"/>
                <ul>
                    <li id="home"> <a href="#" name="Home" onclick="loadAjaxHome(name)">Home</a></li>
                    <li id="reg"> <a href="#" name="Register" onclick="loadAjaxHome(name)">Register</a></li>
                    <li id="about"> <a href="#" name="About" onclick="loadAjaxHome(name)">About</a></li>
                    <li id="faq"> <a href="#" name="Faq" onclick="loadAjaxHome(name)">FAQ</a></li>
                    <li id="cont"> <a href="#" name="Contact" onclick="loadAjaxHome(name)">Contact</a></li>
                </ul>

                <div id="login">
                    <form action="Login" method="post">
                        <p> <label>Login:</label> <input class="textBox" type="text" name="login" />
                            <label>Senha:</label> <input class="textBox" type="password" name="password" />
                            <input class="button" type="submit" value="Login" /> </p>
                    </form>
                </div>
            </div>

            <div id="search">
                <input type="text" id="parametro" name="search" size="47" maxlength="50" onkeypress="return validateFormBusca('rapida', event)" />
            </div>
        </div>

        <div id="wrapper">
            <div id="news" class="news">
                <p class="title">News</p>
                <marquee id="AjaxNewsContent" height="85%" direction="up" onmouseover="this.stop()" onmouseout="this.start()">
                </marquee>
            </div>

            <div id="AjaxContent">

            </div>
            <div id="footer">
                <p> © 2FindScience Team. All Rights Reserved  </p>
            </div>
        </div>
    </body>
</html>
