<%-- 
    Document   : web04titulosdinamicos
    Created on : 11-ene-2021, 17:31:38
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Titulos dinamicos JSP</h1>
        <%
        for (int i = 1; i <=6; i++){
        //cerramos java y abrimos java
            %>
    <h<%=i%> style="color: red">Titulo <%=i%></h<%=i%>>
             <%
        }
        %>
    
        <h1>Titulo1
        </h1>
        <h2>titulo2</h2>
        <h3>titulo 3</h3>
        <h4>Titulo 4</h4>
        <h5>Titulo 5 </h5>
        <h6>Titulo 6</h6>
    </body>
</html>
