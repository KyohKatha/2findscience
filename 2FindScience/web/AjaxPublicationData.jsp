<%-- 
    Document   : publication_data
    Created on : 25/04/2010, 13:19:37
    Author     : Gustavo Henrique
--%>

<%
    User user = (User) session.getAttribute("user");

    final int ADMIN = 0;
    final int COMMON = 1;
    final int ACADEMIC = 2;
%>

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

                if (typePublication.equals("phdthesis")) {
                    phdThesis = (PhdThesis) request.getAttribute("phdthesis");
                    opcao = 0;
                } else {
                    if (typePublication.equals("mastersthesis")) {
                        masterThesis = (MasterThesis) request.getAttribute("mastersthesis");
                        opcao = 1;
                    } else {
                        if (typePublication.equals("inproceedings")) {
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
                                            procedings = (Proceedings) request.getAttribute("proceedings");
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
            <fieldset class="information">
                <legend>Information</legend>
                <p>-  All fields with (*) are required.</p>
                <p>- Click on the box to close it.</p>
            </fieldset>
        </div>

        <form id="formPublication" method="post" action="#" onsubmit="return validateFormPublication('updatePublication')">
            <table class="maintenance" align="center" cellspacing="15px">
                <%switch (opcao) {
                            case 0: /*phdThesis*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + phdThesis.getTitle() + "'"%> /><span>Update title</span></td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(phdThesis.getUrl() == null) out.println("' '"); else out.println("'" + phdThesis.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type="text" name="number" size="15" maxlength="15" value=<% if(phdThesis.getNumber() == null) out.println("' '"); else out.println("'" + phdThesis.getNumber() + "'");%> /><span>Update number</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type="text" name="volume" size="15" maxlength="15" value=<% if(phdThesis.getVolume() == null) out.println("' '"); else out.println("'" + phdThesis.getVolume() + "'");%> /> <span>Update volume</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" name="month" size="15" maxlength="15" value=<% if(phdThesis.getMonth() == null) out.println("' '"); else out.println("'" + phdThesis.getMonth() + "'");%> /> <span>Update month</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(phdThesis.getEe() == null) out.println("' '"); else out.println("'" + phdThesis.getEe() + "'");%> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" name="isbn" size="15" maxlength="30" value=<% if(phdThesis.getIsbn() == null) out.println("' '"); else out.println("'" + phdThesis.getIsbn() + "'");%> /><span>Update ISBN</span></td>
                </tr>

                <tr>
                    <td> School: </td>
                    <td class="tooltip"><input type="text" name="school" size="90" maxlength="255" value=<% if(phdThesis.getSchool() == null) out.println("' '"); else out.println("'" + phdThesis.getSchool() + "'");%> /> <span>Update school</span></td>
                </tr>

                <% break;
    case 1: /*MasterThesis*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + masterThesis.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(masterThesis.getUrl() == null) out.println("' '"); else out.println("'" + masterThesis.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> School: </td>
                    <td class="tooltip"><input type="text" name="school" size="90" maxlength="255" value=<% if(masterThesis.getSchool() == null) out.println("' '"); else out.println("'" + masterThesis.getSchool() + "'");%> /> <span>Update school</span></td>
                </tr>
                <% break;

    case 2: /*Inproceedings*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + inproceedings.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(inproceedings.getUrl() == null) out.println("' '"); else out.println("'" + inproceedings.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(inproceedings.getEe() == null) out.println("' '"); else out.println("'" + inproceedings.getEe() + "'");%> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type="text" name="startPage" size="15" maxlength="15" value=<% if(inproceedings.getStartPage() == null) out.println("' '"); else out.println("'" + inproceedings.getStartPage() + "'");%> /> <span>Update number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type="text" name="endPage" size="15" maxlength="15" value=<% if(inproceedings.getEndPage() == null) out.println("' '"); else out.println("'" + inproceedings.getEndPage() + "'");%> /> <span>Update number end page</span></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type="text" name="cdrom" size="50" maxlength="50" value=<% if(inproceedings.getCdrom() == null) out.println("' '"); else out.println("'" + inproceedings.getCdrom() + "'");%> /> <span>Update cdrom</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type="text" name="note" size="90" maxlength="255" value=<% if(inproceedings.getNote() == null) out.println("' '"); else out.println("'" + inproceedings.getNote() + "'");%> /> <span>Update note</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type=text name=number size=15 maxlength=15 value=<% if(inproceedings.getNumber() == null) out.println("' '"); else out.println("'" + inproceedings.getNumber() + "'");%> /> <span>Update number</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" name="month" size="15" maxlength="15" value=<% if(inproceedings.getMonth() == null) out.println("' '"); else out.println("'" + inproceedings.getMonth() + "'");%> /> <span>Update month</span></td>
                </tr>

                <% break;

    case 3: /*Book*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + book.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(book.getUrl() == null) out.println("' '"); else out.println("'" + book.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(book.getEe() == null) out.println("' '"); else out.println("'" + book.getEe() + "'");%> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type="text" name="cdrom" size="50" maxlength="50" value=<% if(book.getCdrom() == null) out.println("' '"); else out.println("'" + book.getCdrom() + "'");%> /> <span>Update cdrom</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type="text" name="volume" size="15" maxlength="15" value=<% if(book.getVolume() == null) out.println("' '"); else out.println("'" + book.getVolume() + "'");%> /> <span>Update volume</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type="text" name="month" size="15" maxlength="15" value=<% if(book.getMonth() == null) out.println("' '"); else out.println("'" + book.getMonth() + "'");%> /> <span>Update month</span></td>
                </tr>

                 <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" name="isbn" size="15" maxlength="30" value=<% if(book.getIsbn() == null) out.println("' '"); else out.println("'" + book.getIsbn() + "'");%> /><span>Update ISBN</span></td>
                </tr>
                <% break;

    case 4: /*Incollection*/%>
                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + incollection.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(incollection.getUrl() == null) out.println("' '"); else out.println("'" + incollection.getUrl() + "'"); %> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(incollection.getEe() == null) out.println("' '"); else out.println("'" + incollection.getEe() + "'"); %> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> Chapter: </td>
                    <td class="tooltip"><input type=text name=chapter size=15 maxlength=15 value=<% if(incollection.getChapter() == null) out.println("' '"); else out.println("'" + incollection.getChapter() + "'"); %> /> <span>Update chapter</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type=text name=startPage size=15 maxlength=15 value=<% if(incollection.getStartPage() == null) out.println("' '"); else out.println("'" + incollection.getStartPage() + "'"); %> /> <span>Update number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type=text name=endPage size=15 maxlength=15 value=<% if(incollection.getEndPage() == null) out.println("' '"); else out.println("'" + incollection.getEndPage() + "'"); %>  /> <span>Update number end page</span></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type=text name=cdrom size=50 maxlength=50  value=<% if(incollection.getCdrom() == null) out.println("' '"); else out.println("'" + incollection.getCdrom() + "'"); %> /> <span>Update cdrom</span></td>
                </tr>

                 <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" name="isbn" size="15" maxlength="30" value=<% if(incollection.getIsbn() == null) out.println("' '"); else out.println("'" + incollection.getIsbn() + "'");%> /><span>Update ISBN</span></td>
                </tr>

                <% break;

    case 5: /*Www*/%>

                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + www.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(www.getUrl() == null) out.println("' '"); else out.println("'" + www.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(www.getEe() == null) out.println("' '"); else out.println("'" + www.getEe() + "'");%> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type=text name=note size=90 maxlength=255 value=<% if(www.getNote() == null) out.println("' '"); else out.println("'" + www.getNote() + "'");%> /> <span>Update note</span></td>
                </tr>

                <% break;

    case 6: /*Article*/%>

                <tr>
                    <td>(*)Title:</td>
                    <td class="tooltip"><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + article.getTitle() + "'"%> /> <span>Update title</span></td>
                </tr>
                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(article.getUrl() == null) out.println("' '"); else out.println("'" + article.getUrl() + "'"); %> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(article.getEe() == null) out.println("' '"); else out.println("'" + article.getEe() + "'"); %> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> Journal: </td>
                    <td class="tooltip"><input type=text name=journal size=90 maxlength=200 value=<% if(article.getJournal() == null) out.println("' '"); else out.println("'" + article.getJournal() + "'"); %> /> <span>Update journal</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type=text name=volume size=15 maxlength=15 value=<% if(article.getVolume() == null) out.println("' '"); else out.println("'" + article.getVolume() + "'"); %>  /> <span>Update volume</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type=text name=number size=15 maxlength=15 value=<% if(article.getNumber() == null) out.println("' '"); else out.println("'" + article.getNumber() + "'"); %>  /> <span>Update number</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type=text name=note size=90 maxlength=255 value=<% if(article.getNote() == null) out.println("' '"); else out.println("'" + article.getNote() + "'"); %>  /> <span>Update note</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type=text name=month size=15 maxlength=15 value=<% if(article.getMonth() == null) out.println("' '"); else out.println("'" + article.getMonth() + "'"); %>  /> <span>Update month</span></td>
                </tr>

                <tr>
                    <td> CdRom: </td>
                    <td class="tooltip"><input type=text name=cdrom size=50 maxlength=50 value=<% if(article.getCdrom() == null) out.println("' '"); else out.println("'" + article.getCdrom() + "'"); %>  /> <span>Update cdrom</span></td>
                </tr>

                <tr>
                    <td> Start Page: </td>
                    <td class="tooltip"><input type=text name=startPage size=15 maxlength=15 value=<% if(article.getStartPage() == null) out.println("' '"); else out.println("'" + article.getStartPage() + "'"); %>  /> <span>Update number start page</span></td>
                </tr>

                <tr>
                    <td> End Page: </td>
                    <td class="tooltip"><input type=text name=endPage size=15 maxlength=15 value=<% if(article.getEndPage() == null) out.println("' '"); else out.println("'" + article.getEndPage() + "'"); %>  /> <span>Update number end page</span></td>
                </tr>

                <%break;

    case 7:%>

               <tr>
                  <td>(*)Title:</td>
                  <td><input type="text" name="title" size="90" maxlength="255" value=<%= "'" + procedings.getTitle() + "'"%> /> </td>
                </tr>

                <tr>
                    <td>Url:</td>
                    <td class="tooltip"><input type="text" name="url" size="90" maxlength="255" value=<% if(procedings.getUrl() == null) out.println("' '"); else out.println("'" + procedings.getUrl() + "'");%> /> <span>Update url</span></td>
                </tr>

                <tr>
                    <td> Ee: </td>
                    <td class="tooltip"><input type="text" name="ee" size="90" maxlength="255" value=<% if(procedings.getEe() == null) out.println("' '"); else out.println("'" + procedings.getEe() + "'");%> /> <span>Update ee</span></td>
                </tr>

                <tr>
                    <td> Journal: </td>
                    <td class="tooltip"><input type=text name=journal size=90 maxlength=200 value=<% if(procedings.getJournal() == null) out.println("' '"); else out.println("'" + procedings.getJournal() + "'");%> /> <span>Update journal</span></td>
                </tr>

                <tr>
                    <td> Volume: </td>
                    <td class="tooltip"><input type=text name=volume size=15 maxlength=15 value=<% if(procedings.getVolume() == null) out.println("' '"); else out.println("'" + procedings.getVolume() + "'");%> /> <span>Update volume</span></td>
                </tr>

                <tr>
                    <td> Number: </td>
                    <td class="tooltip"><input type=text name=number size=15 maxlength=15 value=<% if(procedings.getNumber() == null) out.println("' '"); else out.println("'" + procedings.getNumber() + "'");%> /> <span>Update number</span></td>
                </tr>

                <tr>
                    <td> Note: </td>
                    <td class="tooltip"><input type=text name=note size=90 maxlength=200 value=<% if(procedings.getNote() == null) out.println("' '"); else out.println("'" + procedings.getNote() + "'");%> /> <span>Update note</span></td>
                </tr>

                <tr>
                    <td> Month: </td>
                    <td class="tooltip"><input type=text name=month size=15 maxlength=15 value=<% if(procedings.getMonth() == null) out.println("' '"); else out.println("'" + procedings.getMonth() + "'");%> /> <span>Update month</span></td>
                </tr>

                <tr>
                    <td> Address: </td>
                    <td class="tooltip"><input type=text name=address size=90 maxlength=80 value=<% if(procedings.getAddress() == null) out.println("' '"); else out.println("'" + procedings.getAddress() + "'");%> /> <span>Update address</span></td>
                </tr>

                <tr>
                    <td> ISBN: </td>
                    <td class="tooltip"><input type="text" name="isbn" size="15" maxlength="30" value=<% if(procedings.getIsbn() == null) out.println("' '"); else out.println("'" + procedings.getIsbn() + "'");%> /><span>Update ISBN</span></td>
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
        <% }%>
    </body>
</html>