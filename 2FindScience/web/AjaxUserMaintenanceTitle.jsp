<%--
    Document   : AjaxEventsTitle
    Created on : 27/05/2010, 21:56:43
    Author     : Kaori
--%>

<%@page import="javax.servlet.http.HttpSession" %>
<%@ page import="Pkg2FindScience.Booktitle"%>
<%@ page import="Pkg2FindScience.User"%>
<%@ page  import="java.util.Vector"%>
<%@ page  import="java.sql.SQLException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    Vector users = (Vector) request.getSession().getAttribute("userVector");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />

    </head>
    <body>
        <select class="list" onchange="javascript:callServlet('MaintenanceUserData?action=show&index=' + (this.selectedIndex + 1),'user_data')" size=10>
            <%
                boolean color = false;
                User u;
                for (int i=0; i< users.size(); i++){
                    u = (User) users.get(i);
                    if (color){
            %>
            <option style="background-color: #dddddd"><%="("+u.getLogin()+") "+u.getName()%> </option>
            <%
                    } else {
            %>
            <option> <%="("+u.getLogin()+") "+u.getName()%> </option>
            <%
                    }
                    color = !color;
                }
            %>
        </select>
    </body>
</html>
