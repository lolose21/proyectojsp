<%-- 
   
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>SELECCION MULTIPLE ELEMENTOS</h1>
        <form method="POST">
            <ul>
                <li>
                    <input type="checkbox" name="color"
                           value="verde"/>Verde
                           
                </li>
                <li>
                    <input type="checkbox" name="color"
                           value="amarillo"/>amarillo
                </li>
                <li>
                    <input type="checkbox" name="color"
                           value="rojo"/>rojo
                </li>
            </ul>
            <button type="submit">Mostrar seleccionados</button>
            
        </form>
        <hr/>
        <%
        String[] colores = request.getParameterValues("color");
        if(colores != null){
        for (String color: colores){
        %>
        <h2><%=color%></h2>
        <%
        }
        }
        %>
    </body>
</html>
