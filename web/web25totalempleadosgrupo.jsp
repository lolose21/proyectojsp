<%-- 
Realizar una vista en ORACLE llamada TODOSEMPLEADOS para poder mostrar apellido, 
oficio/funcion/especialidad y salario de todos los empleados de la bbdd. 
(Doctor, plantilla y emp)
Paginar dicha vista en grupo.

create view todosempleados
as
select (apellido) as apellidos ,(oficio) as trabajo , (salario) as sueldos from emp
union
select apellido , funcion , salario from plantilla
union 
select apellido , especialidad , salario from doctor;
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena =
                "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =
                DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TODOS</title>
        <style>
            ul#menu li {
                display: inline-table;
            }
        </style>
    </head>
    <body>
        <h1>TODOS empleados</h1>
        <form method="post">
            <label> Introduzca salario</label>
            <input type="number" name="cajasalario" required/>
            <button type="submit">
                Mostrar empleados
            </button>
                
        </form>
        <%
      
        String sql="";
        int posicion= 1;
        String dato = request.getParameter("posicion");
        if (dato != null){
        posicion =Integer.parseInt(dato);
        }

        if (request.getParameter("cajasalario")== null){
        sql ="select * from todosempleados";
        posicion =1;
        }else{
        sql="select * from todosempleados where sueldos >="
                + request.getParameter("cajasalario");
        }
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE , 
                ResultSet.CONCUR_READ_ONLY);
        
        ResultSet rs = st.executeQuery(sql);
  
       
        //averiguamos el numero de registros 
        rs.last();
        int numregistros = rs.getRow();
        //posicionamos el cursor en la fila de la posicion 
        rs.absolute(posicion);
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Apellidos</th>
                    <th>Trabajo</th>
                    <th>Sueldos</th>
                </tr>
            </thead>
            <tbody>
                <%
                //recorremos los registros de tres en tres
                for (int i = 1; i <=5 && !rs.isAfterLast(); i++){
                %>
                <tr>
                    <td><%=rs.getString("apellidos")%></td>
                    <td><%=rs.getString("trabajo")%></td>
                    <td><%=rs.getString("sueldos")%></td>
                </tr>
                <%
                    rs.next();
                }
                    rs.close();
                    cn.close();
                %>
            </tbody>
        </table>
            <ul id="menu">
                <%
                //necesitamos saber el numero de pagina
                int numeropagina = 1;
                //recorremos los registros se tres en tres
                for (int i= 1; i <= numregistros; i+=5){
                    String cajasalario = request.getParameter("cajasalario");
                    if(cajasalario == null){
                    //no recibimos salario y pintamos solo la posicion
                    %>
                <li>
                    <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>">
                    Tabla <%=numeropagina%>
                    </a>
                </li>
                <%
                    }else{
                        //pintamos la posicion y la caja salario
                %>
                <li>
                    <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>&cajasalario=<%=cajasalario%>">
                    Tabla <%=numeropagina%>
                    </a>
                </li>
                <%
                    }
              
                    numeropagina +=1;
                }
                %>
            </ul>
        
    </ul>
    </body>
</html>
