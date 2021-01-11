

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <i class="bi bi-dice-6"></i>
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dice-6" viewBox="0 0 16 16">
  <path d="M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"/>
  <path d="M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
</svg>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Tabla de multiplicar</h1>
        <form method="post">
            <label>
                Numero
            </label>
            <input type="number" name="cajanumero" required/>
            <button type="sumit"> Numero </button>
        </form>
       
            <%
                 String dato = request.getParameter("cajanumero");
                     if (dato != null){
                 int numero = Integer.parseInt(dato);
            %>
            <table border="1" class="table-primay">
             
           
            <%
                 for (int i = 1; i <= 10; i++){
            %>
            <tr>
             
            <td style="color: blue"> 
                <%=numero%> 
            </td>
            <td>
            <%= "x"%>
            </td>
            <td style="color: red">
                <%=i%>
            </td>
            <td>
                <%="="%>
            </td>
            <td style="color: purple">
                <%=numero * i%>
            </td></tr>
            <%  
                }
            %>
            
            </table> 
            <%
                }
             %>
      
    </body>
</html>
