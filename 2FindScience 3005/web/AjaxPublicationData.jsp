<%-- 
    Document   : publication_data
    Created on : 25/04/2010, 13:19:37
    Author     : Gustavo Henrique
--%>

<%@page import="Pkg2FindScience.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
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
                        String indexSelected = (String) request.getAttribute("indexSelected");
                        int opcao = -1;
                        PhdThesis phdThesis = null;
                        MasterThesis masterThesis = null;
                        Inproceedings inproceedings = null;
                        Book book = null;
                        Incollection incollection = null;
                        Www www = null;
                        Article article = null;
                        Proceedings procedings = null;

                        if (typePublication.equals("phdThesis")) {
                            phdThesis = (PhdThesis) request.getAttribute("phdThesis");
                            opcao = 0;
                        } else {
                            if (typePublication.equals("mastersThesis")) {
                                masterThesis = (MasterThesis) request.getAttribute("masterThesis");
                                opcao = 1;
                            } else {
                                if (typePublication.equals("inprocedings")) {
                                    inproceedings = (Inproceedings) request.getAttribute("inproceedings");
                                    opcao = 2;
                                } else {
                                    if (typePublication.equals("book")) {
                                        book = (Book) request.getAttribute("book");
                                        opcao = 3;
                                    } else {
                                        if (typePublication.equals("incollection")) {
                                            incollection = (Incollection) request.getAttribute("incollection");
                                            opcao = 4;
                                        } else {
                                            if (typePublication.equals("www")) {
                                                www = (Www) request.getAttribute("www");
                                                opcao = 5;
                                            } else {
                                                if (typePublication.equals("article")) {
                                                    article = (Article) request.getAttribute("article");
                                                    opcao = 6;
                                                } else {
                                                    procedings = (Proceedings) request.getAttribute("procedings");
                                                    opcao = 7;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
        %>
        <div id="msg">
            <fieldset class="information" onclick="closeMessageBox()">
                <legend>Information</legend>
                <p>- All fields with (*) are required.</p>
                <p>- Click on the box to close it.</p>
            </fieldset>
        </div>

        <form id="formPublication" method="post" action="#" onsubmit="return validateFormPublication('updatePublication')">
            <table class="maintenance" align="center" cellspacing="15px">
                <%switch (opcao) {
                                    case 0: /*phdThesis*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + phdThesis.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + phdThesis.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td><input type="text" name="number" size="10" maxlength="10" value=<%=phdThesis.getNumber()%> /> </td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type="text" name="volume" size="10" maxlength="10" value=<%=phdThesis.getVolume()%> /> </td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type="text" name="month" size="15" maxlength="15" value=<%= "'" + phdThesis.getMonth() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>" + "<td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + phdThesis.getEe() + "'"%> /> </td>
                </tr>

                <% break;
                    case 1: /*MasterThesis*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + masterThesis.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + masterThesis.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> School: </td>
                    <td><input type="text" name="school" size="90" maxlength="100" value=<%= "'" + masterThesis.getSchool() + "'"%> /> </td>
                </tr>
                <% break;

                    case 2: /*Inproceedings*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + inproceedings.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + inproceedings.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + inproceedings.getEe() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type="text" name="startPage" size="15" maxlength="15" value=<%= inproceedings.getStartPage()%> /> </td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type="text" name="endPage" size="15" maxlength="15" value=<%= inproceedings.getEndPage()%> /> </td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td><input type="text" name="cdrom" size="90" maxlength="50" value=<%= "'" + inproceedings.getCdrom() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td><input type="text" name="note" size="90" maxlength="100" value=<%= "'" + inproceedings.getNote() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td><input type=text name=number size=10 maxlength=10 value=<%= inproceedings.getNumber()%> /> </td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type="text" name="month" size="15" maxlength="15" value=<%= "'" + inproceedings.getMonth() + "'"%> /> </td>
                </tr>

                <% break;

                    case 3: /*Book*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + book.getTitle() + "'"%> /> </td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + book.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + book.getEe() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td><input type="text" name="cdrom" size="90" maxlength="50" value=<%= "'" + book.getCdrom() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type="text" name="volume" size="10" maxlength="10" value=<%= book.getVolume()%> /> </td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type="text" name="month" size="15" maxlength="15" value=<%= book.getMonth()%> /> </td>
                </tr>
                <% break;

                    case 4: /*Incollection*/%>

                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + incollection.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + incollection.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + incollection.getEe() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Chapter: </td>
                    <td><input type=text name=chapter size=15 maxlength=15 value=<%= "'" + incollection.getChapter() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type=text name=startPage size=15 maxlength=15 value=<%= incollection.getStartPage()%> /> </td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type=text name=endPage size=15 maxlength=15 value=<%= incollection.getEndPage()%>  /> </td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td><input type=text name=cdrom size=90 maxlength=50  value=<%= "'" + incollection.getCdrom() + "'"%> /> </td>
                </tr>

                <% break;

                    case 5: /*Www*/%>

                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + www.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + www.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + www.getEe() + "'"%> /> </td>
                </tr>


                <tr>
                    <td> Note: </td>
                    <td><input type=text name=note size=90 maxlength=100 value=<%= "'" + www.getNote() + "'"%> /> </td>
                </tr>

                <% break;

                    case 6: /*Article*/%>

                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + article.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<% if (article.getUrl() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getUrl() + "'");
                            }%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<% if (article.getEe() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getEe() + "'");
                            }%> /> </td>
                </tr>

                <tr>
                    <td> Journal: </td>
                    <td><input type=text name=journal size=90 maxlength=100 value=<% if (article.getJournal() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getJournal() + "'");
                            }%> /> </td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type=text name=volume size=10 maxlength=10 value=<% if (article.getVolume() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getVolume() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td><input type=text name=number size=10 maxlength=10 value=<% if (article.getNumber() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getNumber() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td><input type=text name=note size=90 maxlength=100 value=<% if (article.getNote() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getNote() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type=text name=month size=15 maxlength=15 value=<% if (article.getMonth() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getMonth() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td><input type=text name=cdrom size=90 maxlength=50 value=<% if (article.getCdrom() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getCdrom() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td><input type=text name=startPage size=15 maxlength=15 value=<% if (article.getStartPage() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getStartPage() + "'");
                            }%>  /> </td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td><input type=text name=endPage size=15 maxlength=15 value=<% if (article.getEndPage() == null) {
                                out.println("' '");
                            } else {
                                out.println("'" + article.getEndPage() + "'");
                            }%>  /> </td>
                </tr>

                <%break;

                    case 7:%>

                <tr>
                    <td>(*)Title:</td>
                    <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + procedings.getTitle() + "'"%> /> </td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td><input type="text" name="url" size="90" maxlength="255" value=<%= "'" + procedings.getUrl() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td><input type="text" name="ee" size="90" maxlength="255" value=<%= "'" + procedings.getEe() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Journal: </td>
                    <td><input type=text name=journal size=90 maxlength=100 value=<%= "'" + procedings.getJournal() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td><input type=text name=volume size=10 maxlength=10 value=<%= procedings.getVolume()%> /> </td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td><input type=text name=number size=10 maxlength=10 value=<%= procedings.getNumber()%> /> </td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td><input type=text name=note size=90 maxlength=100 value=<%= "'" + procedings.getNote() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td><input type=text name=month size=15 maxlength=15 value=<%= "'" + procedings.getMonth() + "'"%> /> </td>
                </tr>

                <tr>
                    <td> Address: </td>
                    <td><input type=text name=address size=90 maxlength=80 value=<%= "'" + procedings.getAddress() + "'"%> /> </td>
                </tr>
                <% break;
                                }
                %>

                <input type="hidden" id="typePublication" value="<%=typePublication%>">
                <input type="hidden" id="indexSelected" value="<%=indexSelected%>">
                <tr>
                    <td colspan="2">
                        <div id="buttonsbox">
                            <input type="submit" class="button" value="Save" name="save"/>
                            <input type="button" class="button" value="Delete" name="delete" onclick="deletePublication()"/>
                            <input type="reset" class="button" value="Clear" name="clear" />
                            <input type="button" class="button" value="Cancel" name="cancel" onclick="loadContent('PublicationMaintenance.jsp', 'content')"/>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
        <% }%>
    </body>
</html>