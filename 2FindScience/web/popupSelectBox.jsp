<%--
    Document   : popupSelectBox
    Created on : 01/06/2010, 23:46:43
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
        <title>Select <%=nameOption%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

        <script language="JavaScript">
            function closeme() {
                window.close()
            }

            function handleOKPopUp() {
                if (opener && !opener.closed) {
                    top.transferData()
                    opener.dialogWin.returnFunc()
                } else {
                    alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
                }
                closeme()
                return false
            }

            function handleCancelPopUp() {
                closeme()
                return false
            }

            function transferData() {
                if (top.opener && !top.opener.closed) {
                    top.opener.dialogWin.returnedValue = document.getElementById('options').value;
                }
            }
        </script>

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

            <table align="center">
                <tr>
                    <td class="tooltip">
                        <select class="list" size=5 id="listAvailable" style="max-width: 250px; min-width: 250px; ">
                            <option style="color: #ffffff; background-color: #000000">SELECT <%=nameOption.toUpperCase()%> </option>
                            <%
                                                    Vector available = (Vector) session.getAttribute("available");
                                                    Boolean color = false;

                                                    for (int i = 0; i < available.size(); i++) {
                                                        if (color) {%>
                            <option style="background-color: #dddddd"> <%= available.elementAt(i).toString()%> </option>
                            <% } else {%>
                            <option> <%= available.elementAt(i).toString()%> </option>
                            <% }
                                                        color = !color;
                                                    }
                            %>
                        </select>
                        <span><%=nameOption%> available</span></td>
                    <td>
                        <p> <input type="button" class="button" value="Add" name="add" onclick="addOption(document.getElementById('listAvailable'),document.getElementById('listSelected'), '<%=nameOption%>')"/> </p>
                        <p> <input type="button" class="button" value="Remove" name="remove" onclick="removeOption(document.getElementById('listSelected'),document.getElementById('listAvailable'), '<%=nameOption%>')"/> </p>
                    </td>
                    <td class="tooltip">
                        <select id="listSelected" class="list" onchange="" size=5 style="min-width: 250px; max-width: 250px;">
                            <%
                                                    Vector selected = (Vector) session.getAttribute("selected");
                                                    Boolean colorUser = false;

                                                    if (selected != null) {
                                                        for (int j = 0; j < selected.size(); j++) {
                                                            if (colorUser) {%>
                            <option style="background-color: #dddddd"> <%= selected.elementAt(j).toString()%> </option>
                            <% } else {%>
                            <option> <%= selected.elementAt(j).toString()%> </option>
                            <%}
                                                            colorUser = !colorUser;
                                                        }
                                                    }
                            %>
                        </select>
                        <span><%=nameOption%> selected</span></td>
                </tr>

                <tr>
                    <td> <input type="button" class="button" value="Cancel" onclick="handleCancelPopUp()"/> </td>
                    <td> <input type="button" class="button" value="Save Choice" onclick="handleOKPopUp()"/> </td>
                </tr>
            </table>
        <input type="hidden" id="nameOption" value="<%=nameOption%>">
        <input type="hidden" id="options" value="">
    </body>
</html>