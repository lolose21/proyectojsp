


<%@page import="java.sql.Statement"%>
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
          <%
          Statement st =
          cn.createStatement();
          String sqldept ="select * from dept";
          //declarar un resultset???
          ResultSet rs = st.executeQuery(sqldept);
          while (rs.next()){
          String num = rs.getString("dept_no");
          String nom = rs.getString("dnombre");
          %>
          <li>
              <a href="web10empleadosdptlinks.jsp?deptno=<%=num%>"><%=nom%></a>
          </li>  
            <%
          }
        rs.close();
          %>
        </ul>
        <%
        String dato = request.getParameter("deptno");
        if (dato != null){
        int deptno = Integer.parseInt(dato);
        String sql = "select * from emp where dept_no=?";
        PreparedStatement pst = cn.prepareStatement(sql);
        pst.setInt(1,deptno);
        rs = pst.executeQuery();
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
