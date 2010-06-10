<%-- 
    Document   : AjaxHomeUserCommon
    Created on : 29/04/2010, 19:19:45
    Author     : 317624
--%>

<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
        <script type="text/javascript" src="AjaxSimple.js"></script>

    </head>
    <body>
        <div id="content" class="content">
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
                            }

                %>
            </div>
            
            <p class="title">Search</p>
            <form id="formBusca" action="#" method="post" onsubmit="return validateFormBusca('normal', event)">
                <table class="search" align="center" cellspacing="15px">
                    <tr>
                        <td align="left" colspan="2"><input class="textBox" type="text" id="parametro" name="parametro" size="80"/></td>
                        <td align="center">
                            <select name="filtro" id="filtro">
                                <option value="both"> ISBN/Journal </option>
                                <option value="isbn"> ISBN </option>
                                <option value="journal"> Journal </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td align="center">
                            <input type="submit" class="button" value="Search" name="search" />
                        </td>
                    </tr>
                </table>
            </form>
            <p class="text">Search Tips:</p>
            <p class="text">On the Home page you will be able to search for the
                registered publications on the website using the search field above.
                It is possible to search for ISBN, journal, or both at the same time.
            </p>
            <p class="text">It isn't necessary to type the exact ISBN or journal title.
                The results displayed will show all the publications with journal and/or
                ISBN that have part of the value informed on the search field.
            </p>
            <p class="text">The searches are ranked by different parameters.
                The ISBN search shows the publication from the author that has more
                publications registered first.
            </p>
            <p class="text">The journal search shows the publication from the journal
                that has more publications registered first.
            </p>
            <p class="text">If you are browsing through the site it isn't necessary
                to return to the main page to search for a publication. It is possible
                to use the 'fast search' field, located on the top of the page, near you menu tab.
                On this search however, it is only possible to search for ISBN
                and journal at the same time.
            </p>
        </div>
    </body>
</html>
