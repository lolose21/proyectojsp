<%-- 
  Mediante Java, mostrar una lista con los 20 primeros números pares.  <ul><li>
Incluir una caja de texto y pedir el número final hasta que deseemos dibujar los números pares.
Realizar la acción al pulsar un botón.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Numeros Pares</h1>
        <form method="post">
            <label>Numero</label>
            <input type="number" name="cajafinal" required
                   class="form-control"/>
            <button type="sumit" id="botonpares"
                    class="btn-primary">
                Mastrar pares
            </button>
        </form>
        <%
            String dato = request.getParameter("cajafinal");
            if (dato != null) {
                int numero = Integer.parseInt(dato);

        %> 

        <ul>
            <%                  for (int i = 2; i <= numero; i += 2) {
            %>
            <li>

                <%=i%>
            </li>
            <%
                }
            %>
        </ul>
        <%
            }
        %>

    </body>
</html>
