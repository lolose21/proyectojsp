<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
Buscar los empleados que escribamos y tengan un oficio.
Dibujar una lista o una tabla...

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena="jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
    DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oficios</title>
    </head>
    <body style=background-image:url("images/ofice.jpg") >
      
       
        <h1 style="text-shadow: 2px 2px 5px red">Buscar Oficio</h1>
        <form method="post">
            <label>Oficio</label>
            <input type="text" name="cajaoficio" required>
            <button type="sumit" style="color: blue"> BUSCAR OFICIO</button> 
        </form>
        <%
        String dato = request.getParameter("cajaoficio");
        if(dato != null){
        String sql = "select * from emp where upper(oficio) =upper( ?)";
        PreparedStatement pst =cn.prepareStatement(sql);
        pst.setString(1 , dato);
        ResultSet rs = pst.executeQuery();
        %>
        <table border="1">
        <%
            while(rs.next()){
            String apellido = rs.getString("apellido");
            String oficio = rs.getString("oficio");
            %>
            <tr>
                <td><%=apellido%></td> 
                <td><%=oficio%></td>
                <%
            }
            %>
            </table>
            <%
                rs.close();
                cn.close();
        }
        %>
    </body>
</html>
