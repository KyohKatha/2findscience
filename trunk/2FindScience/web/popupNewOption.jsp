<%--
    Document   : popupNewOption
    Created on : 08/06/2010, 01:01:33
    Author     : Gustavo Henrique
--%>

<%
            String nameOption = (String) request.getParameter("nameOption");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>New <%=nameOption%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
    </head>

    <body>
        <div id="msg">
            <fieldset class="information" onclick="closeMessageBox()">
                <legend>Information</legend>
                <p>- All fields with (*) are required.</p>
                <p>- Click on the box to close it.</p>
            </fieldset>
        </div>

        <form action="PublicationMaintenance" method="post" onsubmit="return validateFormNewOption()" >
            <table align="center">
                <tr>
                    <td> Name new <%=nameOption%>: </td>
                    <td> <input type="text" id="newOption" name="newOption" maxlength="255"> </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div id="buttonsbox">
                            <input type="submit" class="button" value="Save"/>
                            <input type="button" class="button" value="Cancel" onclick="javascript: document.location = 'popupSelectBox.jsp?nameOption=' + '<%=nameOption%>';"/>
                        </div>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="nameOption" name="nameOption" value="<%=nameOption%>">
            <input type="hidden" id="action" name="action" value="newOption">
        </form>
    </body>
</html>
