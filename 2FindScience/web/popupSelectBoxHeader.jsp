<%-- 
    Document   : popupSelectBoxHeader
    Created on : 06/10/2010, 15:47:05
    Author     : 317624
--%>

<%
            String nameOption = (String) request.getParameter("nameOption");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                closeme();
                return false
            }

            function handleCancelPopUp() {
                closeme();
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
        <div id="contentPop" class="content">
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
        </div>

        <div id="contentPop" class="content">
            <table align="center" class="popup">
                <tr>
                    <td colspan="3" align="center">
                        Select initial letter:
                        <% for (char c = 'a'; c <= 'z'; c++) {%>
                        <a href="#" onclick="callServlet('Filter?action=popupInsert&redirect=yes&mode=' + '<%=nameOption%>' + '&letter=' + '<%=c%>', 'popList')">  <%=c%>  </a>
                        <% }%>
                    </td>
                </tr>
            </table>
            
            <div id="popList" >

            </div>

        </div>
    </body>
</html>
