<%-- 
    Document   : AjaxPublicationData
    Created on : 26/05/2010, 02:27:55
    Author     : Gustavo Henrique
--%>

<%
            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;
%>

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
                        String typePublication = request.getParameter("typePublication");

        %>

        <form id="formPublication" action="#" method="post" onsubmit="return validateFormPublication('savePublication')" >
            <table class="maintenance" align="center" cellspacing="15px">
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" id="title" size="90" maxlength="255" /><span>Insert title</span></td>
                </tr>

                <tr>
                    <td>Related subjects :</td>
                    <td class="tooltip"><input type="text" id="subjects" size=90 onclick="openDGDialog('subjects', 'popupSelectBox.jsp?nameOption=Subjects', 950, 200, setPrefs);" readonly="false" > <span>Click here to insert author</span></td>
                </tr>

                <tr>
                    <td>Author:</td>
                    <td class="tooltip"><input type="text" id="author" size=90 onclick="openDGDialog('author', 'popupSelectBox.jsp?nameOption=Author', 950, 200, setPrefs);" readonly="false" > <span>Click here to insert author</span></td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" id="url" size="90" maxlength="255" /><span>Insert url</span></td>
                </tr>

                <%if (typePublication.equals("phdthesis")) {%>
                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type="text" id="number" size="15" /><span>Insert number</span></td>
                </tr>

                <tr
                    <td> Volume:</td>
                    <td class="tooltip"><input type="text" id="volume" size="15" /><span>Insert volume</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" id="month" size="15" maxlength="15" /><span>Insert month</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" id="isbn" size="15" maxlength="30" /><span>Insert ISBN</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" id="ee" size="90" maxlength="255" /> <span>Insert ee</span></td>
                </tr>

                <tr>
                    <td> School: </td>
                    <td class="tooltip"><input type="text" id="school" size="90" maxlength="255" /><span>Insert school</span></td>
                </tr>

                <%} else {
                    if (typePublication.equals("mastersthesis")) {%>
                <tr>
                    <td> School: </td>
                    <td class="tooltip"><input type="text" id="school" size="90" maxlength="255" /><span>Insert school</span></td>
                </tr>
                <% } else {/*Certamente eh um document */%>
                <tr>
                    <td>BookTitle: </td>
                    <td class="tooltip"><input type="text" id="booktitle" size=90 onclick="openDGDialog('booktitle', 'popupSelectBox.jsp?nameOption=BookTitle', 950, 200, setPrefs);" readonly="false" > <span>Click here to insert booktitle</span></td>
                </tr>

                <tr>
                    <td>Editor: </td>
                    <td class="tooltip"><input type="text" id="editor" size=90 onclick="openDGDialog('editor', 'popupSelectBox.jsp?nameOption=Editor', 950, 200, setPrefs);" readonly="false"> <span>Click here to insert editor</span></td>
                </tr>

                <tr>
                    <td>Publisher: </td>
                    <td class="tooltip"><input type="text" id="publisher" size=90 onclick="openDGDialog('publisher', 'popupSelectBox.jsp?nameOption=Publisher', 950, 200, setPrefs);" readonly="false" > <span>Click here to insert publisher</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" id="ee" size="90" maxlength="255" /><span>Insert ee</span></td>
                </tr>

                <% if (typePublication.equals("inproceedings")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type="text" id="cdrom" size="50" maxlength="50" /><span>Insert cdrom</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type="text" id="startPage" size="15" maxlength="15" /><span>Insert number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type="text" id="endPage" size="15" maxlength="15" /><span>Insert number end page</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type=text id=number size="15" maxlength="10" /><span>Insert number</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type="text" id="note" size="90" maxlength="255" /><span>Insert note</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" id="month" size="15" maxlength="15" /><span>Insert month</span></td>
                </tr>
                <% } else {
                     if (typePublication.equals("book")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type="text" id="cdrom" size="50" maxlength="50" /><span>Insert cdrom</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type="text" id="volume" size="15" maxlength="15" /><span>Insert volume</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" id="month" size="15" maxlength="15" /><span>Insert month</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" id="isbn" size="15" maxlength="30" /><span>Insert ISBN</span></td>
                </tr>
                <% } else {
                                         if (typePublication.equals("incollection")) {%>
                <tr>
                    <td> Chapter: </td>
                    <td class="tooltip"><input type=text id=chapter size="15" maxlength="15" /><span>Insert number chapter</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type=text id=startPage size="15" maxlength="15" /><span>Insert number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type=text id=endPage size="15" maxlength="15" /><span>Insert number end page</span></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type=text id=cdrom size=50 maxlength=50 /><span>Insert cdrom</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" id="isbn" size="15" maxlength="30" /><span>Insert ISBN</span></td>
                </tr>

                <% } else {
                                                             if (typePublication.equals("www")) {%>
                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type=text id=note size=90 maxlength=200 /><span>Insert note</span></td>
                </tr>

                <% } else { /*Eh um Research Report*/%>
                <tr>
                    <td> Journal: </td>
                    <td class="tooltip"><input type=text id=journal size=90 maxlength=200 /><span>Insert journal</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type=text id=volume size=15 maxlength=15 /><span>Insert volume</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type=text id=number size=15 maxlength=15 /><span>Insert number</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type=text id=note size=90 maxlength=100 /><span>Insert note</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type=text id=month size=15 maxlength=15 /><span>Insert month</span></td>
                </tr>

                <% if (typePublication.equals("article")) {%>
                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type=text id=cdrom size=50 maxlength=50 /><span>Insert cdrom</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type=text id=startPage size=15 maxlength=15 /><span>Insert number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type=text id=endPage size=15 maxlength=15 /><span>Insert number end page</span></td>
                </tr>

                <%} else { /* Procedings */%>
                <tr>
                    <td> Address: </td>
                    <td class="tooltip"><input type=text id=address size=90 maxlength=80 /><span>Insert address</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" id="isbn" size="15" maxlength="15" /><span>Insert ISBN</span></td>
                </tr>
                <% }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                %>
                <input type="hidden" id="typePublication" value="<%=typePublication%>">

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
