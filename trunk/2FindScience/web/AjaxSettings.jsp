<%--
    Document   : settings
    Created on : 27/04/2010, 05:39:53
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
            Vector subjects = (Vector) request.getSession().getAttribute("subjectVector");
            int sizeVector = subjects.size();
            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
%>

<%@ page import="Pkg2FindScience.BDConnection"%>
<%@ page import="Pkg2FindScience.User"%>
<%@ page import="Pkg2FindScience.Subject"%>
<%@ page  import="java.util.Vector"%>
<%@ page  import="java.sql.ResultSet"%>
<%@ page  import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>2FindScience - Settings</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />

    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Subjects</p>

            <div id="userlist">
                <select class="list" size=10 onclick="saveIndexSubject(selectedIndex, <%=sizeVector%>)">
                    <%
                    boolean color = false;
                    for(int i = 0; i < subjects.size(); i++){
                        if(color){%>
                        <option style="background-color: #dddddd"> <%=subjects.elementAt(i).toString()%> </option>
                    <% }else{ %>
                    <option> <%=subjects.elementAt(i).toString()%> </option>
                    <% } color = !color; } %>
                </select>
            </div>

            <div id="msg">
                <%
                            String message, type;
                            message = (String) session.getAttribute("message");
                            type = (String) session.getAttribute("type");
                            session.removeAttribute("message");
                            session.removeAttribute("type");

                            if (message != null) {
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
                            } else {
                %>
                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>
                <% }%>


            </div>

            <form id="formInsertTheme" action="#" method="post" onsubmit="return validateFormInsertTheme()">
                <table align="center" class="maintenance" cellspacing="15px">
                    <tr>
                        <td>(*) Insert New</td>
                        <td  class="tooltip"><input type="text" id="newTheme" name="newTheme" size="80"/>
                            <span>Insert a new theme for the publications</span>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="buttonsbox">
                                <input type="submit" class="button" value="Save" name="save"/>
                                <input type="reset" class="button" value="Clear" name="clear"/>
                                <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'AjaxContent')"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <hr>
            <p class="title">Upgrade</p>
            <form id="formInsertUpgrade" action="#" onsubmit="return validateFormInsertUpgrade()">
                <table align="center" class="maintenance" cellspacing="15px">
                    <tr>
                        <td>Current maximum amount of upgrade request permitted per user</td>
                        <td>
                            <% 
                                        out.println("<strong>" + request.getSession().getAttribute("upgrade")+ "</strong> upgrade requests.");
                            %>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>New value</td>
                        <td class="tooltip">
                            <input type="text" id="newMaxUpgrade" name="newMaxUpgrade"/>
                            <span>Insert a new value for upgrade requisitions.</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="buttonsbox">
                                <input type="submit" class="button" value="Save" name="save"/>
                                <input type="reset" class="button" value="Clear" name="clear"/>
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
        </div>
    </body>
</html>

