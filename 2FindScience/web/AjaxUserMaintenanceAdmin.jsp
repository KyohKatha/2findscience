<%--
    Document   : UserMaintenance
    Created on : 24/04/2010, 11:22:47
    Author     : Welington
--%>
<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
            User user = (User) session.getAttribute("user");
            boolean upgrade = true;
            String sUpgrade = "";
%>

<html>
    <head>
        <title>2FindScience - User Maintenance</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <body>
        <div id="content" class="content">
            <p class="title">User Maintenance</p>

            <div id="fastsearch">
                <table align="center">
                    <tr>
                        <td  class="tooltip" align="left" colspan="3">
                            <input class="textBox" type="text" name="parametro" size="112" onkeyup="javascript:callServlet('Filter?action=UserFilter&parameter=' + this.value,'userlist')"/>
                            <span>TYPE THE USER</span>
                        </td>
                    </tr>
                </table>
            </div>

            <%
                        if (upgrade) {
                            sUpgrade = "true";
                        } else {
                            sUpgrade = "false";
                        }
            %>

            <div id="userlist">
                <select class="list" onchange="javascript:callServlet('MaintenanceUserData?action=show&index=' + (this.selectedIndex + 1),'user_data')" size=10>
                </select>
            </div>
            <div id="user_data">
                <!-- Div preenchida via Ajax -->
            </div>
        </div>
    </body>
</html>
