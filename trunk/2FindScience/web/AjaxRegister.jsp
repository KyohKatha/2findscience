<%--
    Document   : register
    Created on : 24/04/2010, 22:37:26
    Author     : Gustavo Henrique
--%>

<%@page import="Pkg2FindScience.Subject" %>
<%@page import="java.util.Vector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Creating a new account</p>

            <div id="msg">
                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>
            </div>

            <form id="formUser"  action="#" method="post" onsubmit="return validateFormUser('Register')">
                <table class="maintenance" align="center" cellspacing="15px">
                    <tr>
                        <td>(*)Login:</td>
                        <td class="tooltip"><input type="text" id="login" name="login" size="25" maxlength="25" /><span>Insert your login</span></td>
                    </tr>
                    <tr>
                        <td>(*)Password:</td>
                        <td class="tooltip"><input type="password" id="password" name="password" size="15" maxlength="15" /><span>Insert your password</span></td>
                    </tr>
                    <tr>
                        <td>(*)Password Confirmation:</td>
                        <td class="tooltip"><input type="password" id="passwordConfirmation" name="passwordConfirmation" size="15" maxlength="15" /><span>Insert your password again</span></td>
                    </tr>
                    <tr>
                        <td>(*)Name:</td>
                        <td class="tooltip"><input type="text" id="name" name="name" size="60" maxlength="60" /><span>Insert your name</span></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td class="tooltip"><input type="text" id="email" name="email" size="60" maxlength="40" /><span>Insert your email</span></td>
                    </tr>
                    <tr>
                        <td>Personal page (Ex.: Lattes):</td>
                        <td class="tooltip"><input type="text" value="http://" id="page" name="page" size="30" maxlength="50" /><span>Insert your personal page ('http://www.page.com')</span></td>
                    </tr>

                    <tr>
                        <td>Interests available: </td>
                        <td class="tooltip">
                            <div id="userlist" >
                                <select class="list" size=5 id="listAvailableSubjects" >
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
                        <span>Select your subjects</span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="button" class="button" value="Add" name="add" onclick="addOption(document.getElementById('listAvailableSubjects'),document.getElementById('listSelectedSubjects'), 'subjects')"/>
                            <input type="button" class="button" value="Remove" name="remove" onclick="removeOption(document.getElementById('listSelectedSubjects'),document.getElementById('listAvailableSubjects'), 'subjects')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Your interests</td>
                        <td>
                            <div id="userlist">
                                <select id="listSelectedSubjects" class="list" onchange="" size=5>
                                 
                                </select>
                            </div>
                        </td>
                    </tr>
                </table>

                <input id="options" type="hidden" value="">
                <div id="buttonsbox">
                    <input type="submit" class="button" value="Save" name="save" />
                    <input type="reset" class="button" value="Clear" name="clear" />
                    <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('Home.jsp', 'content')"/>
                </div>
            </form>
        </div>
    </body>
</html>
