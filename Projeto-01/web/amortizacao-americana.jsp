<%-- 
    Document   : Soma
    Created on : 02/03/2020, 15:53:44
    Author     : a
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AA</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Amortização Americana</h1>
        <h3>Insira as informações abaixo:</h3>
        <form action="" method="get">
            <p>Insira o valor total: </p>
            <input type="number" name="total" required=""/> <!-- atributo required para tornar o campo obrigatorio -->
            <p>Insira o valor dos juros: </p>
            <input type="number" name="taxa" required=""/>
            <p>Insira a quantia de parcelas: </p>
            <input type="number" name="parcela" required=""/>
            <input type="submit" name="somar" value="Calcular"/>
        </form>
        <%
            if(!"".equals(request.getParameter("somar")) && request.getParameter("somar") != null){ //verifica se o botao calcular foi acionado
                DecimalFormat df = new DecimalFormat("#,##0.00"); //arredonda os numeros e formata para real
                double total = Double.parseDouble(request.getParameter("total"));
                float taxa = Float.parseFloat(request.getParameter("taxa"));
                int parcela = Integer.parseInt(request.getParameter("parcela"));
                double porc = (taxa / 100) * total;
                double last = (parcela * porc) + total;
                int semilast = parcela - 1;
                %>
                <%=semilast%> parcelas de <%=df.format(porc)%> e a ultima de <%=df.format(last)%>
                <%
            }
        %>
        <p>
            
        </p>
    </body>
</html>
