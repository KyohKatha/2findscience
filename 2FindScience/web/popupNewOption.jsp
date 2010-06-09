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
        <%
                    String message, type;
                    message = (String) request.getAttribute("message");
                    type = (String) request.getAttribute("type");
                    request.removeAttribute("message");
                    request.removeAttribute("type");

                    if (message != null) {
                        out.println("<div id=\"msg\">");
                        out.println("<fieldset class=\"" + type + "\">");
                        String legend = "Undefined";
                        if (type == "information") {
                            legend = "Information";
                        } else if (type == "critical") {
                            legend = "Error";
                        } else if (type == "success") {
                            legend = "Success";
                        } else if (type == "warning") {
                            legend = "Warning";
                        }

                        out.println("<legend>" + legend + "</legend>");
                        out.println(message);
                        out.println("</fieldset>");
                        out.println("</div>");
                    }
        %>

        <form action="#" method="post">
            <table align="center">
                <tr>
                    <td> Name new <%=nameOption%>: </td>
                    <td> <input type="text" maxlength="255"> </td>
                </tr>

                
                <tr>
                    <td> <input type="button" class="button" value="Save" onclick="handleOKPopUp()"/> </td>
                    <td> <input type="button" class="button" value="Cancel" onclick="handleCancelPopUp()"/> </td>
                </tr>
            </table>
            <input type="hidden" id="nameOption" value="<%=nameOption%>">
        </form>

    </body>
</html>
