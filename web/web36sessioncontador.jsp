<%-- 
    Document   : web36sessioncontador
    Created on : 21-ene-2021, 17:05:27
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
        <h1>Ejemplo simple de session</h1>
        <form method="post">
            <button type="submit">
                Incrementar
            </button>
        </form>
        <%
        int contador = 1;
        //necesitamos un objeto session
        HttpSession sesion = request.getSession();
        //deseamos almacenar el numero de forma permanente
        //por lo que haremos una variable de session
        //pero el contador va a tener dos posibilisades
        //1) que todavia no hemos almacenado informacion
        //2) si hemos almacenado informacion
        if(sesion.getAttribute("contador")!= null){
        //hemos almacenado algo previamente
        contador = Integer.parseInt(sesion.getAttribute("contador").toString());
        }
       
        %>
        <h1 style="color: red">
            
            Contador:<%=contador%>
        </h1>
        <%
        contador++;
         //almacenamos el numero de la sesion
        sesion.setAttribute("contador", contador);
        %>
        
    </body>
</html>
