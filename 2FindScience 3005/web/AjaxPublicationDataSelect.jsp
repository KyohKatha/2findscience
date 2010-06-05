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
                    <td>Select type of new publication </td>
                    <td> <select id="selectType" onchange="javascript:callServlet('Filter?action=selectTypePublication&type=' + this[selectedIndex].value + '&parameter=a', 'AjaxPublicationDataInsert')" >
                            <option value="article">Article</option>
                            <option value="book">Book</option>
                            <option value="incollection">Incollection</option>
                            <option value="inprocedings">Inprocedings</option>
                            <option value="mastersThesis">Master Thesis</option>
                            <option value="phdThesis">Phd Thesis</option>
                            <option value="proceedings">Proceedings</option>
                            <option value="www">Www</option>
                        </select>
                    </td>
                </tr>
            </table>

            <div id="AjaxPublicationDataInsert">  </div>

            <% }%>
        </div>
    </body>
</html>

