<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
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
                        <td  align="center">
                            <input type="submit" class="button" value="Search" name="search" />
                        </td>
                    </tr>
                </table>
            </form>
            <p class="text">Dicas de Busca:</p>
            <p class="text">Na página inicial, você poderá buscar pelas publicações
                cadastradas no site a partir do campo de pesquisa acima. É possível
                realizar buscar por isbn, journal ou pelos dois ao mesmo tempo.</p>
            <p class="text">Não é necessário digitar o valor exato do isbn ou o nome
                inteiro do journal. Os resultados exibidos serão todas as publicações
                com journal e/ou isbn que possuem o valor informado em alguma parte de
                seu valor original.</p>
            <p class="text">Ao realizar uma busca por isbn, o resultado desta busca
                é ordenado pela relevância da publicação, ou seja, os primeiros
                resultados exibidos serão os que pertencem a autores com os maiores
                números de publicações cadastradas.</p>
            <p class="text">Realizando a busca por journal, os resultados também serão
                ordenados pela sua relevância, o que significa que os journals
                com mais publicações cadastradas serão os primeiros a serem exibidos.</p>
            <p class="text">Se você estiver navegando pelo site, não é preciso retornar
                para a página inicial para realizar uma busca. É possível utilizar o
                campo de 'busca rápida', que se encontra perto do menu do site.
                Nesta busca, só é possível buscar por isbn e journal ao mesmo tempo.</p>
        </div>
    </body>
</html>

