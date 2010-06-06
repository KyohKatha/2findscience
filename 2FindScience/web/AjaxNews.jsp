<%--
    Document   : AjaxNews
    Created on : 30/05/2010, 14:06:03
    Author     : Kaori
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="Pkg2FindScience.News" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%

            Vector newsVector = (Vector) request.getSession().getAttribute("newsVector");
            request.removeAttribute("newsVector");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> </title>
    </head>
    <table>
        <%
                    if (newsVector != null) {

                        for (int i = 0; i < newsVector.size(); i++) {

                            News n = (News) newsVector.get(i);
        %>
        <tr>
            <td>
                <div id="item" align="center" style="width: 288px;">
                    <%if (n.getType() == 0) {%>

                    <div id="image">
                        <img src="Imagens/sign_pub.png" alt="pub"/>
                    </div>
                    <p><i><a href="http://www.google.com"><%= n.getName()%></a></i></p>
                    <p><%= n.getDate()%></p>
                    <%  } else {%>
                    <div id="image">
                        <img src="Imagens/sign_event.png" alt="eve"/>
                    </div>
                    <p><i><%= n.getName()%></i></p>
                    <p><%= n.getDate()%></p>
                    <%  }
                    %>

                </div>
            </td>
        </tr>
        <%
                                    }
                                } else {

        %>
        <p align="center">
            Loading error
        </p>
        <%}
        %>
    </table>
</html>
