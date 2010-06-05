<%-- 
    Document   : AjaxGetHint
    Created on : 16/05/2010, 14:56:15
    Author     : Welington
--%>

<%@page import="javax.servlet.http.HttpSession" %>
<%@ page import="Pkg2FindScience.Publication"%>
<%@ page import="Pkg2FindScience.User"%>
<%@ page  import="java.util.Vector"%>
<%@ page  import="java.sql.SQLException"%>

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
        <select class="list" id="listPublications" onchange="javascript:callServletPublication(selectedIndex)" size=10>
            <%
            Boolean color = false;
            Vector rs = (Vector) session.getAttribute("publications");
            User user = (User) session.getAttribute("user");

            if(user.getProfile() != 0){ %>
            <option style="color: #ffffff; background-color: #000000">INSERT A NEW PUBLICATION...</option>
            <%} %>
            <%for (int i = 0; i < rs.size(); i++) {
                                            Publication publication = (Publication) rs.elementAt(i);
                                            if (color) {%>
            <option style="background-color: #dddddd"> <%=publication.getTitle()%> </option>
            <%} else {%>
            <option> <%=publication.getTitle()%> </option>
            <%}
                            color = !color;
                        }
             
            %>
        </select>

    </body>
</html>
