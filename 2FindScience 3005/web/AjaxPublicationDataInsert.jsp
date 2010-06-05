<%-- 
    Document   : AjaxPublicationDataInsert
    Created on : 26/05/2010, 02:27:55
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
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
    </head>

    <body>

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
                        String typePublication = (String) request.getAttribute("typePublication");
        %>

        <form id="formPublication" action="#" method="post" onsubmit="return validateFormPublication('savePublication')" >
            <table class="maintenance" align="center" cellspacing="15px">
                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" /></td>
                </tr>

                <tr>
                    <td>Author:</td>
                    <td> <table class="maintenance" align="center" cellspacing="15px">
                            <tr>
                                <td class="tooltip">
                                    <select class="list" size=5 id="listAvailableAuthor" >
                                        <option style="color: #ffffff; background-color: #000000">SELECT AUTHORS </option>
                                        <%
                                                                Vector authorsAvailable = (Vector) request.getAttribute("authorsAvailable");
                                                                Boolean color = false;

                                                                for (int i = 0; i < authorsAvailable.size(); i++) {
                                                                if (color) {%>
                                        <option style="background-color: #dddddd"> <%= authorsAvailable.elementAt(i).toString()%> </option>
                                        <% } else {%>
                                        <option> <%= authorsAvailable.elementAt(i).toString()%> </option>
                                        <% }
                                                                color = !color;
                                                                }
                                                                %>
                                    </select>
                                    <span>Authors available</span></td>
                                <td>
                                    <p> <input type="button" class="button" value="Add" name="add" onclick="addOption(document.getElementById('listAvailableAuthor'),document.getElementById('listSelectedAuthor'), 'author')"/> </p>
                                    <p> <input type="button" class="button" value="Remove" name="remove" onclick="removeOption(document.getElementById('listSelectedAuthor'),document.getElementById('listAvailableAuthor'), 'author')"/> </p>
                                </td>
                                <td class="tooltip">
                                    <select id="listSelectedAuthor" class="list" onchange="" size=5 style="min-width: 150px;">
                                        <%
                                                                Vector authorsPub = (Vector) request.getAttribute("authorsPub");
                                                                Boolean colorUser = false;

                                                                if (authorsPub != null) {
                                                                for (int j = 0; j < authorsPub.size(); j++) {
                                                                if (colorUser) {%>
                                        <option style="background-color: #dddddd"> <%= authorsPub.elementAt(j).toString()%> </option>
                                        <% } else {%>
                                        <option> <%= authorsPub.elementAt(j).toString()%> </option>
                                        <%}
                                                                colorUser = !colorUser;
                                                                }
                                                                }
                                        %>
                                    </select>
                                    <span>Authors selected</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" /></td>
                </tr>

                <%if (typePublication.equals("phdThesis")) {%>
                <tr>
                    <td> Number: </td>
                    <td><input type="text" name="number" size="10" maxlength="10" /></td>
                </tr>

                <tr
                    <td> Volume:</td>
                    <td><input type="text" name="volume" size="10" maxlength="10" /></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type="text" name="month" size="15" maxlength="15" /></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" /> </td>
                </tr>

                <%} else {
                    if (typePublication.equals("mastersThesis")) {%>
                <tr>
                    <td> School: </td>
                    <td><input type="text" name="school" size="90" maxlength="100" /></td>
                </tr>
                <% } else {/*Certamente eh um document */%>
                <tr>
                    <td>BookTitle: </td>
                    <td> <table class="maintenance" align="center" cellspacing="15px">
                            <tr>
                                <td class="tooltip">
                                    <select class="list" size=5 id="listAvailableBookTitle" >
                                        <option style="color: #ffffff; background-color: #000000"> SELECT BOOKTITLE </option>
                                        <%
                                                                Vector bookTitleAvailable = (Vector) request.getAttribute("bookTitleAvailable");
                                                                color = false;

                                                                for (int k = 0; k < bookTitleAvailable.size(); k++) {
                                                                if (color) {%>
                                        <option style="background-color: #dddddd"> <%= bookTitleAvailable.elementAt(k).toString()%> </option>
                                        <% } else {%>
                                        <option> <%= bookTitleAvailable.elementAt(k).toString()%> </option>
                                        <% }
                                                                color = !color;
                                                                }
                                                                %>
                                    </select>
                                    <span>BookTitles available</span></td>
                                <td>
                                    <p> <input type="button" class="button" value="Add" name="add" onclick="addOption(document.getElementById('listAvailableBookTitle'),document.getElementById('listSelectedBookTitle'), 'bookTitle')"/> </p>
                                    <p> <input type="button" class="button" value="Remove" name="remove" onclick="removeOption(document.getElementById('listSelectedBookTitle'),document.getElementById('listAvailableBookTitle'), 'bookTitle')"/> </p>
                                </td>
                                <td class="tooltip">
                                    <select id="listSelectedBookTitle" class="list" onchange="" size=5 style="min-width: 150px;">
                                        <%
                                                                Vector bookTitlePub = (Vector) request.getAttribute("bookTitlePub");
                                                                colorUser = false;

                                                                if (authorsPub != null) {
                                                                for (int q = 0; q < bookTitlePub.size(); q++) {
                                                                if (colorUser) {%>
                                        <option style="background-color: #dddddd"> <%= bookTitlePub.elementAt(q).toString()%> </option>
                                        <% } else {%>
                                        <option> <%= bookTitlePub.elementAt(q).toString()%> </option>
                                        <% }
                                                                colorUser = !colorUser;
                                                                }
                                                                }
                                        %>
                                    </select>
                                    <span>BookTitles selected</span></td>
                            </tr>
                        </table>
                    </td>

                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" /></td>
                </tr>

                <% if (typePublication.equals("inprocedings")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td><input type="text" name="cdrom" size="90" maxlength="50" /></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type="text" name="startPage" size="15" maxlength="15" /></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type="text" name="endPage" size="15" maxlength="15" /></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td><input type="text" name="note" size="90" maxlength="100" /></td>
                </tr>
                <% } else {
                     if (typePublication.equals("book")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td><input type="text" name="cdrom" size="90" maxlength="50" /></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type="text" name="volume" size="10" maxlength="10" /></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type="text" name="month" size="15" maxlength="15" /></td>
                </tr>
                <% } else {
                                         if (typePublication.equals("incollection")) {%>
                <tr>
                    <td> Chapter: </td>
                    <td><input type=text name=chapter size=15 maxlength=15 /></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type=text name=startPage size=15 maxlength=15 /></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type=text name=endPage size=15 maxlength=15 /></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td><input type=text name=cdrom size=90 maxlength=50 /></td>
                </tr>

                <% } else {
                                           if (typePublication.equals("www")) {%>
                <tr>
                    <td> Note: </td>
                    <td><input type=text name=note size=90 maxlength=100 /></td>
                </tr>

                <% } else { /*Eh um Research Report*/%>
                <tr>
                    <td> Journal: </td>
                    <td><input type=text name=journal size=90 maxlength=100 /></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type=text name=volume size=10 maxlength=10 /></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td><input type=text name=number size=10 maxlength=10 /></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td><input type=text name=note size=90 maxlength=100 /></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type=text name=month size=15 maxlength=15 /></td>
                </tr>

                <% if (typePublication.equals("article")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td><input type=text name=cdrom size=90 maxlength=50 /></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type=text name=startPage size=15 maxlength=15 /></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type=text name=endPage size=15 maxlength=15 /></td>
                </tr>

                <%} else { /* Procedings */%>
                <tr>
                    <td> Address: </td>
                    <td><input type=text name=address size=90 maxlength=80 /></td>
                </tr>
                <% }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                %>


                <input type="hidden" id="typePublication" value=" <%= typePublication %>">
                <input type="hidden" id="author" value="">
                <input type="hidden" id="bookTitle" value="">
                <tr>
                    <td colspan="2">
                        <div id="buttonsbox">
                            <input type="submit" class="button" value="Save" name="save" />
                            <input type="reset" class="button" value="Clear" name="clear" />
                            <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('PublicationMaintenance.jsp', 'content')"/>
                        </div>
                    </td>
                </tr>
            </table>
         <% }%>
    </form>
    </body>
</html>
