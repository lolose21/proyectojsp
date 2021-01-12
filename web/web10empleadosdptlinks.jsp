

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =
DriverManager.getConnection(cadena ,"system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>EMPLEADOS DEPARTAMENTO LINKS</h1>
        <ul>
            <li>
                
                <a href="web10empleadosdptlinks.jsp?deptno=10">Contabilidad</a>
            </li>
            <li>
                <a href="web10empleadosdptlinks.jsp?deptno=20">Investigacion</a>
            </li>
            <li>
                <a href="web10empleadosdptlinks.jsp?deptno=30">Ventas</a>
            </li>
            
        </ul>
        <%
        String dato = request.getParameter("deptno");
        if (dato != null){
        int deptno = Integer.parseInt(dato);
        String sql = "select * from emp where dept_no=?";
        PreparedStatement pst = cn.prepareStatement(sql);
        pst.setInt(1,deptno);
        ResultSet rs = pst.executeQuery();
          %>
          <ul>
          <%   
              while (rs.next()){
              String ape = rs.getString("apellido");
              %>
              <li><%=ape%></li>
              <%
              }
            %>
          </ul>
          <%
        rs.close();
        cn.close();
        }
        %>
    </body>
</html>
