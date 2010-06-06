<%--
    Document   : events_data
    Created on : 27/04/2010, 06:38:15
    Author     : Gustavo Henrique
--%>

<%
            Booktitle b = (Booktitle) request.getSession().getAttribute("selectedEvent");

            int edit = (Integer) request.getSession().getAttribute("edit");
            
            request.getSession().removeAttribute("edit");
            request.getSession().removeAttribute("selectedEvent");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Pkg2FindScience.Booktitle" %>
<%@page import="Pkg2FindScience.User" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <div id="msg">

        <% if (edit == 0) {%>
        <fieldset class="information" onclick="closeMessageBox()">
            <legend>Information</legend>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
        <% } else { %>
        <fieldset class="warning" onclick="closeMessageBox()">
            <legend>Warning</legend>
            <p>-  <strong>Event</strong> loaded for <strong>edition</strong>.</p>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
        <% } %>
    </div>

    <form id="formEvent" method="post" action="#" onsubmit="return validateFormEvent2(<%=b.getCod()%>)">
        <table class="maintenance" align="center" cellspacing="15px">
            <tr>
                <td>Name (*)</td>
                <td><input type="text" id="name" name="name" value="<%=b.getName()%>" size="90" maxlength="255" /></td>
            </tr>
            <tr>
                <td>City </td>
                <td><input type="text" id="city" name="city" value="<%=b.getLocal()%>" size="90" maxlength="50" /></td>
            </tr>
            <tr>
                <td>Start Date </td>
                <td><input type="text" id="startDate" name="startDate" value="<%=b.getStartDate()%>" size="30" maxlength="10" onclick="loadDate(<%=b.getCod()%>)"/></td>
            </tr>
            <tr>
                <td>End Date </td>
                <td><input type="text" id="endDate" name="endDate" value="<%=b.getEndDate()%>" size="30" maxlength="10" onclick="loadDate(<%=b.getCod()%>)"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="submit" class="button" value="Save" name="save"/>
                        <input type="reset" class="button" value="Clear" name="clear" />
                        <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'content')"/>
                    </div>
                </td>
            </tr>
        </table>
    </form>

</html>