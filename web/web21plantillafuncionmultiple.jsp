<%-- 
 Dibujar checkbox por cada funcion de la plantilla.
Los checkbox deben quedar seleccionados al buscar.
Mostraremos la plantilla de las funciones seleccionadas en una tabla.
Hacerlo primero concatenando y después con parámetros.
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
String[] datosseleccionados = request.getParameterValues("plantilla");
ArrayList<String>listaseleccion = new ArrayList<>();
if(datosseleccionados != null){
for (String dato : datosseleccionados){
    listaseleccion.add(dato);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plantilla</title>
    </head>
    <body>
        <h1>Mostrar plantilla</h1>
        <form method="post">
            <ul>
                <%
                String sqlplantilla = "select distinct funcion from plantilla";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlplantilla);
                while (rs.next()){
               
                String func = rs.getString("funcion");
               
                           if(listaseleccion.size()==0){
                            //no seleccionamos
                %>
                <li>
                    <input type="checkbox" name="plantilla" value="<%=func%>"/>
                    <%=func%>
                </li>
                <%
                            
                            }else{
                           //buscamos los datos seleccionados en listaseleccion
                           if(listaseleccion.contains(func)){
                           //seleccionamos
                %>
                <li>
                    <input type="checkbox" name="plantilla" value="<%=func%>"/>
                    <%=func%>
                </li>
                <%
                           }else{
                                //no seleccionamos
                %>
                <li>
                    <input type="checkbox" name="plantilla" value="<%=func%>"/>
                    <%=func%>
                </li>
                <%
                                }
                           }
              
                    }
                    rs.close();
                %>
                
            </ul>
                <button type="submit">funciones</button>
        </form>
                <hr/>
                <%
                String[] funciones = request.getParameterValues("plantilla");
                if (funciones != null){
                //seperamos todas las funciones por comas en un string
                //quiero que valores sea (?,?)
                //tantas interrogaciones como funciones
                String valores = "(";
                for (String p : funciones){
                    valores += "?,";
                    
                    }
                //debemos quitar la ultima coma
                //recuperamos la posicion
                int ultimacoma = valores.lastIndexOf(",");
                valores = valores.substring(0 , ultimacoma);
                valores += "(";
                //select * from plantilla where lower(funcion) 
                // in ('enfermero' , 'enfermera');
                String sqlfunciones ="select * from plantilla where lower(funcion) in "
                 + valores;
                PreparedStatement pst = cn.prepareStatement(sqlfunciones);
                //preparamos los parametros al preparedstatement
                int posicion= 1;
                //recorremos todos los parametros
                for (String p: funciones){
                   
                 pst.setString(posicion, p);
                    posicion++;
                    }
                rs = pst.executeQuery();
                %>
                <table border="1">
                    <thead>
                        <tr>
                            <th style="color: purple">
                                hospital_cod
                            </th>
                                <th style="color: green">
                                    sala_cod
                                </th>
                                    <th style="color: red">
                                        Empleado_no
                                    </th>
                                    <th style="color: tomato">
                                        Apellido
                                    </th>
                              
                            <th style="color: fuchsia">
                                Turno
                            </th>
                        <th style="color: navy">
                            Salario
                        </th>
                        </tr>
                <%
                while (rs.next()){
                String hosp = rs.getString("hospital_cod");
                String sala = rs.getString("sala_cod");
                String emp  = rs.getString("empleado_no");
                String ape  = rs.getString("apellido");
              
                String turn = rs.getString("turno");
                String sal  = rs.getString("salario");
                %>
                <tr>
                    <td><%=hosp%></td>
                    <td><%=sala%></td>
                    <td><%=emp%></td>
                    <td><%=ape%></td>
                   
                    <td><%=turn%></td>
                    <td><%=sal%></td>
                </tr>
                <%
                }
                %>
                    </thead>
                </table>
                <%
                    rs.close();
                    cn.close();
                } 
                %>
    </body>
</html>
