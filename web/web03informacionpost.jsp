

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Informacion post</h1>
        <form method="post">
            <label>
                Nombre:
            </label>
            <input type="text" name="cajanombre"/>
            <button type="submit"> Enviar informacion </button>
        </form>
        <%
        String dato= request.getParameter("cajanombre");
        //debemos comprobar si hemos recibido el dato antes
        //de pintarlo
        if(dato != null){
        //debemos pintar codigo HTML
        //de java entre html
        //debemos cerrar java y abrir java
        %>
        <h1 style="color:red">
            <%=dato%>
        </h1>
        <%
        }
        %>
      
    </body>
</html>
