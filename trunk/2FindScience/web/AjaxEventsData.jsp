<%--
    Document   : events_data
    Created on : 27/04/2010, 06:38:15
    Author     : Gustavo Henrique
--%>

<%
            String edit =  (String) request.getAttribute("edit");
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

    </head>
    <body>
        <div id="msg">
            <% if (edit == null || edit.equals("update")) {%>
            <fieldset class="warning" onclick="closeMessageBox()">
                <legend>Warning</legend>
                <p>-  <strong>Event</strong> loaded for <strong>editing</strong>.</p>
                <p>- All fields with (*) are required.</p>
                <p>- Click on the box to close it.</p>
            </fieldset>
            <% } else {%>
            <fieldset class="information" onclick="closeMessageBox()">
                <legend>Information</legend>
                <p>- All fields with (*) are required.</p>
                <p>- Click on the box to close it.</p>
            </fieldset>
            <% }%>
        </div>

        <form id="formEvent" method="post" action="#" onsubmit="return validateFormEvent('<%=edit%>')">
            <table class="maintenance" align="center" cellspacing="15px">

                <% if (edit.equals("insert")) {%>
                <tr>
                    <td>(*)Name</td>
                    <td class="tooltip"><input type="text" id="name" name="name" value="" size="90" maxlength="255" />
                    <span>Insert event's name</span></td>
                </tr>

                <tr>
                    <td>Related subjects :</td>
                    <td class="tooltip"><input type="text" id="Subjects" size=90 onclick="openDGDialog('Subjects', 'popupSelectBox.jsp?nameOption=Subjects', 950, 200, setPrefs);" readonly="false" > <span>Click here to insert author</span></td>
                </tr>

                <tr>
                    <td>City </td>
                    <td class="tooltip"><input type="text" id="city" name="city" value="" size=90" maxlength="50" />
                    <span>Insert event's local</span></td>
                </tr>
                 <tr>
                    <td>Start Date </td>
                    <td class="tooltip"><input type="text" id="startDate" name="startDate" size="30" maxlength="30"/>
                    <span>Insert event's inicial date</span></td>
                </tr>
                <tr>
                    <td>End Date </td>
                    <td class="tooltip"><input type="text" id="endDate" name="endDate" size="30" maxlength="30"/>
                    <span>Insert event's final date</span></td>
                </tr>

                <%} else {
                    Booktitle b = (Booktitle) request.getAttribute("selectedEvent");
%>
                <tr>
                    <td>(*)Name</td>
                    <td class="tooltip"><input type="text" id="name" name="name" value="<%=b.getName()%>" size="90" maxlength="255" />
                    <span>Insert event's name</span></td>
                </tr>
                <tr>
                    <td>City </td>
                    <td class="tooltip"><input type="text" id="city" name="city" value="<%=b.getLocal() %>" size="90" maxlength="50" />
                    <span>Insert event's local</span></td>
                </tr>
                <tr>
                    <td>Start Date </td>
                    <td class="tooltip"><input type="text" id="startDate" name="startDate" size="30" maxlength="30">
                    <span>Insert event's inicial date</span></td>
                </tr>
                <tr>
                    <td>End Date </td>
                    <td class="tooltip"><input type="text" id="endDate" name="endDate" size="30" maxlength="30"/>
                    <span>Insert event's final date</span></td>
                </tr>

                <input type="hidden" id="endDataHidden" value=<%=b.getEndDate()%> >
                <input type="hidden"  id="startDateHidden" value=<%=b.getStartDate()%> >
                <input type="hidden"  id="codBookTitle" value=<%=b.getCod()%> >
                <% }%>
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
    </body>
</html>