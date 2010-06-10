<%--
    Document   : update_user
    Created on : 25/04/2010, 21:37:52
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
            String profile = (String) request.getAttribute("profile");
            String hiddenSubjects = (String) request.getAttribute("hiddenSubjects");

            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
%>

<%@page import="Pkg2FindScience.Subject" %>
<%@page import="java.util.Vector" %>
<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>2FindScience - Profile</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Update your information</p>

            <div id="msg">
                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>- You <strong>cannnot</strong> edit the <strong>login</strong> field.</p>
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>
            </div>

            <form id="formUser"  action="#" method="post" onsubmit="return validateFormUser('EditProfile')">
                <table class="maintenance" align="center" cellspacing="15px">
                    <tr>
                        <td>(*)Login:</td>
                        <td class="tooltip"><input type="text" id="login" name="login" size="25" maxlength="25" value="<%= user.getLogin()%>" readonly="true"/><span>You cannot edit your login</span></td>
                    </tr>
                    <tr>
                        <td>(*)Password:</td>
                        <td class="tooltip"><input type="password" id="password" name="password" size="15" maxlength="15" value="<%= user.getPassword()%>"/><span>Update your password</span></td>
                    </tr>
                    <tr>
                        <td>(*)Password Confirmation:</td>
                        <td class="tooltip"><input type="password" id="passwordConfirmation" name="passwordConfirmation" size="15" maxlength="15" value="<%= user.getPassword()%>"/><span>Insert your password again</span></td>
                    </tr>
                    <tr>
                        <td>(*)Name:</td>
                        <td class="tooltip"><input type="text" id="name" name="name" size="60" maxlength="60" value="<%= user.getName()%>"/><span>Update your name</span></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <% if (user.getEmail() != null) {%>
                        <td class="tooltip"><input type="text" id="email" name="email" size="70" maxlength="40" value="<%= user.getEmail()%>"/><span>Update your email</span></td>
                            <%} else {%>
                        <td class="tooltip"><input type="text" id="email" name="email" size="70" maxlength="40"/><span>Update your email</span></td>
                            <%}%>
                    </tr>
                    <tr>
                        <td>Personal page (Ex.: Lattes): </td>
                        <% if (user.getPage() != null) {%>
                        <td class="tooltip"><input type="text" name="page" size="30" maxlength="50" value="<%= user.getPage()%>"/><span>Update your email</span></td>
                            <%} else {%>
                        <td class="tooltip"><input type="text" name="page" size="30" maxlength="50"/><span>Update your page</span></td>
                            <%}%>

                    </tr>
                    <tr>
                        <td>Subjects available: </td>
                        <td class="tooltip">
                            <div id="userlist" >
                                <select class="list" size=5 id="listAvailableSubjectsProfile" >
                                    <option style="color: #ffffff; background-color: #000000">SELECT SUBJECT</option>
                                    <%
                                                Vector subjects = (Vector) request.getAttribute("subjects");
                                                Boolean color = false;

                                                for (int i = 0; i < subjects.size(); i++) {
                                                    Subject subject = (Subject) subjects.elementAt(i);
                                                    if (color) {
                                                        out.println("<option style=\"background-color: #dddddd\">" + subject.getName() + "</option>");
                                                    } else {
                                                        out.println("<option>" + subject.getName() + "</option>");
                                                    }
                                                    color = !color;
                                                }

                                    %>
                                </select>
                            </div>
                            <span>Select the subjects of your interest</span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="button" class="button" value="Add" name="add" onclick="addOption(document.getElementById('listAvailableSubjectsProfile'),document.getElementById('listSelectedSubjectsProfile'), 'subjects')"/>
                            <input type="button" class="button" value="Remove" name="remove" onclick="removeOption(document.getElementById('listSelectedSubjectsProfile'),document.getElementById('listAvailableSubjectsProfile'), 'subjects')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Your subjects</td>
                        <td class="tooltip">
                            <div id="userlist">
                                <select id="listSelectedSubjectsProfile" class="list" onchange="" size=5>
                                    <%
                                                Vector subjectsUser = (Vector) request.getAttribute("subjectsUser");
                                                Boolean colorUser = false;

                                                for (int j = 0; j < subjectsUser.size(); j++) {
                                                    Subject subjectUser = (Subject) subjectsUser.elementAt(j);
                                                                if (colorUser) {%>
                                    <option style="background-color: #dddddd"> <%=subjectUser.getName()%> </option>
                                    <% } else {%>
                                    <option> <%= subjectUser.getName()%> </option>
                                    <%}
                                                    colorUser = !colorUser;
                                                }

                                    %>
                                </select>
                            </div>
                            <span>Your subjects</span></td>
                    </tr>
                </table>

                <input type="hidden" id="profile" value="<%=profile%>" >
                <input type="hidden" id="options" value="<%=hiddenSubjects%>">

                <div id="buttonsbox">
                    <input type="submit" class="button" value="Save" name="save" />
                    <% if (profile.equals("user")) {%>
                    <input type="button" class="button" value="Upgrade!" name="upgrade" onclick="callServlet('MaintenanceUserData?action=getMaxUpgrade', 'AjaxContent')"/>
                    <% }%>
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
            </form>
        </div>
    </body>
</html>


