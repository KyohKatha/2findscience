<%-- 
    Document   : AjaxPublicationDataSelect
    Created on : 26/05/2010, 10:27:21
    Author     : 317624
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
    </head>

    <body>
        <div id="content" class="content">
            <%
                        String message, type;
                        message = (String) session.getAttribute("message");
                        type = (String) session.getAttribute("type");
                        session.removeAttribute("message");
                        session.removeAttribute("type");

                        if (message != null) {
                            out.println("<div id=\"msg\">");
                            out.println("<fieldset class=\"" + type + "\" onclick=\"closeMessageBox()\">");
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
                        } else {
            %>
            <div id="msg">
                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>
            </div>

            <table class="maintenance" align="center" cellspacing="15px">
                <tr>
                    <td>Select the type of the new publication </td>
                    <td> <select id="selectType" style="background:black;color:white;text-transform:uppercase" title="Select the type of the new publication" onchange="selectTypePublication(this[selectedIndex].value)">
                            <option value="#" >Select the type</option>
                            <option value="article" style="background:white;color:black;text-transform:none">Article</option>
                            <option value="book" style="background:white;color:black;text-transform:none">Book</option>
                            <option value="incollection" style="background:white;color:black;text-transform:none">Incollection</option>
                            <option value="inproceedings" style="background:white;color:black;text-transform:none">Inproceedings</option>
                            <option value="mastersthesis" style="background:white;color:black;text-transform:none">Master Thesis</option>
                            <option value="phdthesis" style="background:white;color:black;text-transform:none">Phd Thesis</option>
                            <option value="proceedings" style="background:white;color:black;text-transform:none">Proceedings</option>
                            <option value="www" style="background:white;color:black;text-transform:none">Www</option>
                        </select>
                    </td>
                </tr>
            </table>
            <div id="AjaxPublicationData">  </div>
            <% }%>
        </div>
    </body>
</html>

