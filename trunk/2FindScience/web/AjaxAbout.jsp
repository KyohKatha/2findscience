<%--
    Document   : home_academic
    Created on : 25/04/2010, 21:50:03
    Author     : Gustavo Henrique
--%>

<%
            User user = (User) session.getAttribute("user");
%>

<%@page import="Pkg2FindScience.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = "stylesheet" type = "text/css" href = "style.css" />
    </head>
    <body>
        <div id="content" class="content">
            <p class="title">About 2FindScience</p>
            <table class="maintenance" cellspacing="15px">
                <tr>
                    <td colspan="2">
                        <strong> What?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            2Find Science é um site que possibilita inserção, remoção
                            e alteração de publicações, além de oferecer um mecanismo 
                            de busca eficiente para pesquisar títulos de journal e códigos 
                            isbn.
                        </p>
                        <p class="text">
                            Ao realizar seu cadastro, é possível escrever pequenos
                            comentários para cada publicação. Além disso, escolhendo alguns
                            interesses durante o cadastro, a coluna de news passa a
                            ser personalizada, mostrando apenas as últimas atualizações
                            de publicações de interesse do usuário.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Why?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            2Find Science foi idealizado para que fosse possível
                            gerenciar informações  de publicações a partir de uma
                            webpage, facilitando o acesso ao conhecimento científico
                            gerado no meio acadêmico.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong> Where?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            2Find Science é um projeto criado dentro da Universidade
                            Federal de São Carlos (UFSCar) - Campus Sorocaba, para a
                            disciplina 'Desenvolvimento para Web', pertencente ao curso
                            de Bacharelado em Ciência da Computação.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="title">
                        <strong> Who?</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p class="text">
                            <strong>Autores:</strong>
                        </p>
                        <p class="text">
                            Aline Kaori Takechi<br>
                            Gustavo Henrique Rodrigues Pinto Tomas<br>
                            Katharina Carrapatoso Garcia<br>
                            Welington Manoel da Silva<br>
                        </p>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>


