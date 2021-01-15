<%-- 
Tendremos una caja de texto para pedir el ID del empleado 
(EMP_NO) y un botón de mostrar detalles.
Al pulsar, mostramos los detalles del empleado, su apellido, oficio, salario...
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<i class="bi bi-dice-6"></i>
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dice-6" viewBox="0 0 16 16">
  <path d="M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"/>
  <path d="M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
  </svg>

<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="oracle.jdbc.connector.OracleConnectionManager"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Detalles empleado</h1>
        <form method="post">
            <label>Introduzca Id empleado</label>
            <select name="cajaidempleado">
                <%
                String sql = "select * from emp";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()){
                    String apellido = rs.getString("APELLIDO");
                    String empno = rs.getString("EMP_NO");
                    %>
                    <option value="<%=empno%>"><%=apellido%></option>
                    <%
                }
                rs.close();
                %>
            </select>
            <button type="submit">Buscar empleado</button>
        </form>
        <%
        String dato = request.getParameter("cajaidempleado");
        if (dato != null){
            int idempleado = Integer.parseInt(dato);
            String sqldetalles = "select * from emp where emp_no=?";
            PreparedStatement pst = cn.prepareStatement(sqldetalles);
            pst.setInt(1, idempleado);
            rs = pst.executeQuery();
            if (rs.next()){
                String ape = rs.getString("APELLIDO");
                String ofi = rs.getString("OFICIO");
                String sal = rs.getString("SALARIO");
                %>
                <h1><%=ape%></h1>
                <h2>Oficio: <%=ofi%></h2>
                <h2>Salario: <%=sal%></h2>
                <%
            }else {
                //NO EXISTE EMPLEADO
                %>
                <h1 style="color:red">No existe empleado con id: <%=dato%></h1>
                <%
            }
            rs.close();
            cn.close();
        }
        %>
    </body>
</html>