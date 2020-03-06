<%-- 
    Document   : tabela-price
    Created on : 05/03/2020, 20:40:47
    Author     : Daniel
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lnag="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Price</title>
    </head>
    <body>
        <style>
            input{
                margin-bottom: 1%;
            }
            table{
                text-align: center;
             
            }
            form{
                float: left;
                margin-right: 5%;
            }
        </style>
        <%@include file='WEB-INF/jspf/menu.jspf' %>
        <h1>Tabela Price</h1>
        <form action="" method="get">
            <label for="valor-div">Valor: </label>
            <input type="number" name="valor_div" step="any" placeholder="Digite o valor da divida."><br>
            <label for="valor_juros">Taxa de juros: </label>
            <input type="number" name="valor_juros" step="any" placeholder="Digite o valor de juros. Ex: 2"><br>
            <label for="parcelas">Quantidade de parcelas: </label>
            <input type="number" name="qt_parcelas" placeholder="Digite a quantidade de parcelas."><br>
            <input type="submit" value="Calcular">
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>Mês</th>
                    <th>Juros ($)</th>
                    <th>Amortização ($)</th>
                    <th>Prestação ($)</th>
                    <th>Dívida ($)</th>
                </tr>
            </thead>
            <tbody>
            <%
                if(request.getParameter("valor_div") != null && request.getParameter("valor_juros") != null && request.getParameter("qt_parcelas") != null && !"".equals(request.getParameter("valor_div")) && !"".equals(request.getParameter("valor_juros")) && !"".equals(request.getParameter("qt_parcelas"))){
                DecimalFormat df = new DecimalFormat("#,##0.00");
                    
                double valor = Double.parseDouble(request.getParameter("valor_div"));
                double juros = Double.parseDouble(request.getParameter("valor_juros"))/100;
                double parcelas = Double.parseDouble(request.getParameter("qt_parcelas"));
                double vl_juros = 0;
                double amortizacao = 0;
                double meses = parcelas;
                double total_juros = 0, total_amortizacao = 0;
                double prestacao = valor/meses;
                if(juros != 0){
                    prestacao = valor * (((Math.pow(1+juros, meses))*juros)/(Math.pow(1+juros, meses)-1));   
                }
                for (int i = 0; i <= meses; i++) {
                    if(i == 0){
                        %>
                        <tr>
                            <td><%=i%></td>
                            <td><%=juros*100%>%</td>
                            <td>-</td>
                            <td>-</td>
                            <td><%=df.format(valor)%></td>
                        </tr>
                        <% 
                    }
                    else{
                    vl_juros = valor * juros;
                    amortizacao = prestacao - vl_juros;
                    valor -= amortizacao;
                    total_juros += vl_juros;
                    total_amortizacao += amortizacao;
            %>
            
                <tr>
                    <td><%=i%></td>
                    <td><%=df.format(vl_juros)%></td>
                    <td><%=df.format(amortizacao)%></td>
                    <td><%=df.format(prestacao)%></td>
                    <td><%=df.format(valor)%></td>
                </tr>
            <%
                if(i == meses){
                    %>
                     <tr>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                    <tr>
                        <td>Total</td>
                        <td><%=df.format(total_juros)%></td>
                        <td><%=df.format(total_amortizacao)%></td>
                        <td><%=df.format(prestacao*meses)%></td>
                        <td><%=df.format(valor*valor)%></td>
                    </tr>
                </tbody>
            
            <%
                }
                }
                }
                
                }
            %>
        </table>
    </body>
</html>
