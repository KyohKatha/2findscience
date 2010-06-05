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
    Vector event = (Vector) request.getSession().getAttribute("eventVector");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <title> </title>
    </head>
    <body>
        <select class="list" onchange="javascript:callServlet('EventMaintenance?action=show&index=' + this.selectedIndex,'events_data')" size=10>
            <option style="color: #ffffff; background-color: #000000">
                INSERT A NEW EVENT...
            </option>
            <%
                boolean color = false;
                Booktitle b;
                for (int i=0; i<event.size(); i++){
                    b = (Booktitle) event.get(i);
                    if (color){
            %>
            <option style="background-color: #dddddd"> <%=b.getName()%> </option>
            <%
                    } else {
            %>
            <option> <%=b.getName()%> </option>
            <%
                    }
                    color = !color;
                }
            %>
        </select>
    </body>
</html>

