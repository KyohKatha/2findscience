<%--
    Document   : events
    Created on : 27/04/2010, 06:26:10
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
        <title>2FindScience - Events</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />

    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Event Maintenance</p>
            <div id="fastsearch">
                <table align="center">
                    <tr>
                        <td  class="tooltip" align="left" colspan="3">
                            <input class="textBox" type="text" name="parametro" size="112" onkeyup="javascript:callServlet('Filter?action=EventFilter&parameter=' + this.value,'userlist')"/>
                            <span>TYPE THE EVENT</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="userlist">
                <select class="list" onchange="javascript:callEventInsert(this.selectedIndex)" size=10>
                    <option style="color: #ffffff; background-color: #000000">INSERT A NEW EVENT...</option>
                </select>
            </div>

            <div id="events_data">
            </div>
        </div>
    </body>
</html>

