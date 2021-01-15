<%-- 
    Document   : web20doctoreshospital
    Created on : 15-ene-2021, 17:14:14
    Author     : Usuario
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.net.nt.ConnectDescription"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena =
"jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =DriverManager.getConnection(cadena , "system" , "oracle");
String[] datosseleccionados = request.getParameterValues("hospital");
ArrayList<String>listaseleccion =new ArrayList<>();
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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Doctores hospital</h1>
        <form method="post">
        <ul>
            <%
            String sqlhospital = "select * from hospital";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqlhospital);
            while (rs.next()){
            String nombre = rs.getString("nombre");
            String codigo = rs.getString("hospital_cod");
            
            if (listaseleccion.size() == 0){
            //no seleccionamos
              %>
            <li>
                <input type="checkbox" name="hospital"
                       value="<%=codigo%>"/><%=nombre%>
                       
            </li>
             <%
            }else{
            //buscamos los datos seleccionados en listaseleccion
            if (listaseleccion.contains(codigo)){
            //seleccionamos
             %>
            <li>
                <input type="checkbox" name="hospital"
                       value="<%=codigo%>" checked/><%=nombre%>
                       
            </li>
            <%
            }else{
            //no seleccionamos
             %>
            <li>
                <input type="checkbox" name="hospital"
                       value="<%=codigo%>"/><%=nombre%>
                       
            </li>
            <%
                    }
                 }

            }
        rs.close();
            %>
            
        </ul>
            <button type="submit">Mostrar doctores</button>
            </form>
            <hr/>
            <%
            String[] hospitales = request.getParameterValues("hospital");
            if(hospitales != null){
            //separamos todos los hospitales por comas en un string
            //18 , 19
            //quiero que valores sea (?,?)
            //tantas interrogaciones como hospitales
            String valores = "(";
            for(String h: hospitales){
            valores += "?,";
            }
            //debemos quitar la ultima coma
            //vamos a coger la cadena desde 0 hasta antes de la coma
            //recuperamos la posicion
            int ultimacoma = valores.lastIndexOf(",");
            valores = valores.substring(0 , ultimacoma);
            valores += ")";
              //select * from doctor where hospital_cod in (18 , 19)
            String sqldoctores ="select * from doctor where hospital_cod in"
                    + valores;
                 
            PreparedStatement pst = cn.prepareStatement(sqldoctores);
            //pasamos los parametros al preparedStatement
            int posicion = 1;
            //recorremos todos los parametros
            for (String h: hospitales){
            //convertimos cada texto hospital a numero hospital
            int hospitalcod = Integer.parseInt(h);
            pst.setInt(posicion, hospitalcod);
            posicion++;
            }
           rs = pst.executeQuery();
            %>
            <table border="1">
                <thead>
                    <tr>
                        <th>
                            apellido
                        </th>
                        <th>especialidad</th>
                        <th>salario</th>
                    </tr>
            <%
            while(rs.next()){
            String ape= rs.getString("apellido");
            String espe = rs.getString("especialidad");
            String sal = rs.getString("salario");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=espe%></td>
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
