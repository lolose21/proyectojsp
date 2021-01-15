<%-- 
 
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] ingredientes = new String[]
{"sal","azucar","leche","mandarinas", "cacao"};
//RECUPERAMOS LOS ELEMENTOS SELECCIONADOS
String[] datosseleccionados = request.getParameterValues("ingrediente");
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null) {
for (String dato: datosseleccionados){
listaseleccion.add(dato);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ingredientes </h1>
        <form method="post">
             <ul>
            
            <%
            for (String ing: ingredientes ){
             if(listaseleccion.size() == 0 ){
             //dibujamos sin seleccionar
              %>
            <li>
                <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
            </li>
             <%
             }else{
             //preguntamos si existe algun dato en la lista de seleccion
             if(listaseleccion.contains(ing)){
             //seleccionados
            %>
            <li>
                <input type="checkbox" name="ingrediente" value="<%=ing%>" checked/><%=ing%>
            </li>
            <%
             }else{
                //sin seleccion
            %>
            <li>
                <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
            </li>
            <%
                    }
                }   
           
            }
            %>
        </ul>
        <button type="submit">Mostrar seleccionados</button>
        </form>
       <hr/>
       <%
       String[] datos = request.getParameterValues("ingrediente");
       if (datos != null){
       for (String dato : datos){
       %>
       <h3 style="color:blue"><%=dato%></h3>
       <%
       }
       }
       %>
    </body>
</html>
