<%--
    Document   : AjaxForum
    Created on : 30/04/2010, 00:29:41
    Author     : Welington
--%>

<%@page import="Pkg2FindScience.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
            User user = (User) session.getAttribute("user");
            Publication publication = (Publication) request.getAttribute("publication");

            final int ADMIN = 0;
            final int COMMON = 1;
            final int ACADEMIC = 2;

%>

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">Publication viewing</p>
            <div id="scroll" style="height:170px; border: 1px solid #cccccc;">
                <table align="left" class="maintenance" cellspacing="15px">
                    <tr>
                        <td colspan="3">
                            <strong><%= publication.getTitle()%></strong>
                            <input id="publication" type="hidden" value="<%= publication.getCod()%>" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                        String isbn = publication.getIsbn();
                                        if (isbn != null) {
                            %>
                            ISBN <%= isbn%>
                            <%
                                        }
                                        String journal = publication.getJournal();
                                        if (journal != null) {
                            %>
                            Journal <%= journal%>
                            <%
                                        }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%
                                        String sAuthors = "";
                                        ArrayList<Author> authorlist = publication.getAuthors();
                                        if (authorlist != null) {
                                            ArrayList<Author> authors = publication.getAuthorsForView();
                                            for (int i = 0; i < authors.size(); i++) {
                                                sAuthors += " " + authors.get(i).getName();
                                                if (i < authors.size() - 1) {
                                                    sAuthors += ";";
                                                } else {
                                                    sAuthors += ".";
                                                }
                                            }
                                        } else {
                                            sAuthors = "No authors";
                                        }
                            %>
                            <i>
                                <%= sAuthors%>
                            </i>
                        </td>
                    </tr>
                </table>
            </div>
            <p class="title">Publication forum</p>
            <%
                                ArrayList<Post> result = (ArrayList<Post>) publication.getPosts();
                                int size = 100;

                                if (result != null && !result.isEmpty()) {
                                    if (result.size() > 1) {
                                        size = 150;
                                    }
                                } else {
                                    size = 50;
                                }

                                out.print("<div id=\"scroll\" style=\"height:" + size + "px; border: 1px solid #cccccc;\">");
                                out.print("<table class=\"maintenance\" align=\"left\" cellspacing=\"1px\">");

                                Format formato = new SimpleDateFormat(
                                        "yyyy'/'MM'/'dd hh':'mm");

                                if (result != null && !result.isEmpty()) {
                                    for (int i = 0; i < result.size(); i++) {
            %>
                                        <tr>
                                            <td colspan="3">
                                                <div id="item" align="justify" style="width: 660px;">
                                                    <div id="image">
                                                        <img src="Imagens/sign_post.png" alt="post"/>
                                                    </div>

                                                    <p><%=  result.get(i).getText()%></p>
                                                    <p><b><%=  result.get(i).getUser()%></b>, <%=  formato.format(result.get(i).getDate())%></p>

                                                </div>
                                            </td>
                                        </tr>
            <%
                                }

                                } else if (result != null) {
            %>
                                        <tr>
                                            <td colspan="3">
                                                <ul>
                                                    <p>Be the first one to comment this publication !</p>
                                                </ul>
                                            </td>
                                        </tr>
            <%
                                }
                                out.print("</table>");
                                out.print("</div>");
            %>
                
            <%
                        if (user != null) {
            %>
            <p class="title">DO YOU HAVE SOME COMMENT?</p>

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
                                            } else {%>

                <fieldset class="information" onclick="closeMessageBox()">
                    <legend>Information</legend>
                    <p>- All fields with (*) are required.</p>
                    <p>- Click on the box to close it.</p>
                </fieldset>

                <%                            }
                %>
            </div>
            <form id="formPost" action="#">
                <table class="maintenance" align="center" cellspacing="15px">
                    <tr>
                        <td>(*) Login </td>
                        <td class="tooltip">
                            <label id="nome"><b><%= user.getLogin()%></b></label>
                            <span>This is your login</span>
                        </td>
                    </tr>
                    <tr>
                        <td>(*)Comment </td>
                        <td><div id="count" style="font-size: 11px;"><strong>140</strong> characters are missing</div></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="tooltip">
                            <textarea id="comment" name="comment" cols="80" rows="3" onkeyup="blockTyping(this.value)"></textarea>
                            <span>Insert here your comment</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div id="buttonsbox">
                                <input type="button" class="button" value="Save" name="save" onclick="validateFormPost(<%= publication.getCod()%>, <%= "'" + user.getLogin() + "'"%>, document.getElementById('comment').value)"/>
                                <input type="reset" class="button" value="Clear" name="clear" onmouseup="blockTyping('')"/>
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
                                                            }
                                %>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            <%
                        }
            %>
        </div>
    </body>
</html>

