<%--
    Document   : events_data
    Created on : 27/04/2010, 06:38:15
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
            Booktitle b = (Booktitle) request.getSession().getAttribute("selectedEvent");

            String type = (String) request.getSession().getAttribute("type");
            String message = (String) request.getSession().getAttribute("message");

            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
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
        <% if (b == null) {%>
        <fieldset class="information" onclick="closeMessageBox()">
            <legend>Information</legend>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
        <% } else {
            if (type == null) {%>
        <fieldset class="warning" onclick="closeMessageBox()">
            <legend>Warning</legend>
            <p>-  <strong>Event</strong> loaded for <strong>edition</strong>.</p>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
        <% } else {%>
        <fieldset class="critical">
            <legend>Error</legend>
            <p>- Error <strong>connection</strong> with database </p>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>

        <%       }
                }%>
    </div>
    <form id="formEvent" method="post" action="#" onsubmit="return validateFormEvent()">
        <table class="maintenance" align="center" cellspacing="15px">
            <tr>
                <td>Name (*)</td>
                <% if (b == null) {%>
                <td><input type="text" id="name" name="name" value="" size="90" maxlength="25" /></td>
                    <% } else {%>
                <td><input type="text" id="name" name="name" value="<%=b.getName()%>" size="90" maxlength="25" /></td>
                    <% }%>
            </tr>
            <tr>
                <td>City </td>
                <% if (b == null) {%>
                <td><input type="text" id="city" name="city" value="" size="90" maxlength="25" /></td>
                    <% } else {%>
                <td><input type="text" id="city" name="city" value="<%=b.getLocal()%>" size="90" maxlength="25" /></td>
                    <% }%>
            </tr>
            <tr>
                <td>Start Date </td>
                <% if (b == null) {%>
                <td><input type="text" id="startDate" name="startDate" value="" size="30" maxlength="30" /></td>
                    <% } else {%>
                <td><input type="text" id="startDate" name="startDate" value="<%=b.getStartDate()%>" size="30" maxlength="30" /></td>
                    <% }%>
            </tr>
            <tr>
                <td>End Date </td>
                <% if (b == null) {%>
                <td><input type="text" id="endDate" name="endDate" value="" size="30" maxlength="30" /></td>
                    <% } else {%>
                <td><input type="text" id="endDate" name="endDate" value="<%=b.getEndDate()%>" size="30" maxlength="30" /></td>
                    <% }%>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="submit" class="button" value="Save" name="save"/>
                        <input type="reset" class="button" value="Clear" name="clear" />
                        <%
                                            switch (user.getProfile()) {
                                                case ADMIN:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                case COMMON:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeUserCommon.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                case ACADEMIC:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAcademic.jsp', 'AjaxContent')"/>
                                <%
                                                    break;
                                                default:
                                %>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('Home.jsp', 'AjaxContent')"/>
                                <%
                                            }
                                %>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</html>