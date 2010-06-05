<%-- 
    Document   : logout
    Created on : 25/04/2010, 12:29:19
    Author     : Gustavo Henrique
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    session.removeAttribute("user");
    response.sendRedirect("home.jsp");
%>
