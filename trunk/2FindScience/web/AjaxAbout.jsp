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
                        <p class="text">
                            2Find Science is a website that enables you to insert, remove
                            and alter scientific publications metadata. It also offers an
                            efficient search mechanism to find publications through their
                            ISBN codes and/or journal titles.
                        </p>
                        <p class="text">
                            When you register on the site it is possible to leave
                            comments about each publication you search. Also, by picking
                            some subjects of your interest during the register phase,
                            you will be able to see the latest publications or events
                            related to your interests on the News column.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Why?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            2Find Science was idealized in a way so it would be
                            possible to manage a large amount of informations about
                            publications through a website, so that the access to
                            scientific information would be easier.
                        </p>
                        <p class="text">
                            Os dados iniciais foram extraídos da base de dados DBLP,
                            que mantém metadados de mais de um milhão de publicações
                            cadastradas.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Where?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            2Find Science was developed in the Universidade
                            Federal de São Carlos (UFSCar) - Campus Sorocaba, as a
                            project for the disciplines 'Web Development', 'Software Engeneering 2'
                            and 'Database Laboratory' of the Bachelor of Computer Science course.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="title">
                        <strong> Who?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            <strong>Developers:</strong>
                        </p>
                        <p class="text">
                            Aline Kaori Takechi - @ - aline.kaori.t@gmail.com<br>
                            Gustavo Henrique Rodrigues Pinto Tomas - @ - seilagu@hotmail.com<br>
                            Katharina Carrapatoso Garcia - @KyohKatha - katharinacg@gmail.com<br>
                            Welington Manoel da Silva - @ - welingtonms@hotmail.com<br>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


