<%-- 
  --rownum solo puede filtrar cuando ya  ha generado los numeros
--primero la consulta, despues contar las filas de la consulta
-- y por ultimo ,haremos la consulta para filtrar todo
select * from
(select rownum as posicion , apellido from
(select apellido from emp) empleados ) consulta
where posicion >= 1 and posicion < (1+5); 
                  6               (6 + 5)
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <style>
            ul#menu li{
                display: inline
            }
        </style>
        <%
        //no tenemos el numero de registros total a dibujar
        String sqlregistros = "select count(emp_no ) as personas from emp ";
        Statement st= cn.createStatement();
        ResultSet rs= st.executeQuery(sqlregistros);
        rs.next();
        int registros = rs.getInt("personas");
        rs.close();
        String sqlemp ="select * from " +
            "(select rownum as posicion , empleados.* from" + 
            "(select apellido , oficio , salario from emp) empleados ) consulta" +
            " where posicion >= ? and posicion < (?)";
        int posicion = 1;
        String dato = request.getParameter("posicion");
        if(dato != null){
        posicion = Integer.parseInt(dato);
        }
        PreparedStatement pst = cn.prepareStatement(sqlemp);
        pst.setInt(1, posicion);
        pst.setInt(2, posicion + 5);
        rs = pst.executeQuery();
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>posicion</th>
                    <th>apellido</th>
                    <th>oficio</th>
                    <th>salario</th>
                </tr>
            </thead>
            <tbody>
    
    <%
    while (rs.next()){
    String pos = rs.getString("posicion");
    String ape = rs.getString("apellido");
    String ofi = rs.getString("oficio");
    String sal = rs.getString("salario");
    %>
    <tr>
        <td><%=pos%></td>
        <td><%=ape%></td>
        <td><%=ofi%></td>
        <td><%=sal%></td>
    </tr>  
   
    <%
    }
rs.close();
cn.close();
    %>
     </tbody>
    </table>
     <hr/>
     <ul id="menu">
         <%
         int numeropagina =1;
         for (int i = 1; i <= registros; i += 5){
         %>
         <li>
             <a href="web26paginaciongrupooracle.jsp?posicion=<%=i%>"><%=numeropagina%>
             </a>
         </li>
         <%
             numeropagina++;
         }
         %>
     </ul>
    </body>
</html>
