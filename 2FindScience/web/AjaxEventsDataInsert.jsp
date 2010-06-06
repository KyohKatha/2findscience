<%--
    Document   : events_data
    Created on : 27/04/2010, 06:38:15
    Author     : Gustavo Henrique
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Pkg2FindScience.Booktitle" %>
<%@page import="Pkg2FindScience.User" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <div id="msg">
        <fieldset class="information" onclick="closeMessageBox()">
            <legend>Information</legend>
            <p>- All fields with (*) are required.</p>
            <p>- Click on the box to close it.</p>
        </fieldset>
    </div>

    <form id="formEvent" method="post" action="#" onsubmit="return validateFormEvent1()">
        <table class="maintenance" align="center" cellspacing="15px">
            <tr>
                <td>Name (*)</td>
                <td><input type="text" id="name" name="name" value="" size="90" maxlength="255" /></td>
            </tr>
            <tr>
                <td>City </td>
                <td><input type="text" id="city" name="city" value="" size=90" maxlength="50" /></td>
            </tr>
            <tr>
                <td>Period </td>
                <td><input type="button" name="period" value="Select Period" onclick="loadDate(0)"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="submit" class="button" value="Save" name="save"/>
                        <input type="reset" class="button" value="Clear" name="clear" />
                        <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('HomeAdmin.jsp', 'content')"/>
                    </div>
                </td>
            </tr>
        </table>
    </form>

</html>