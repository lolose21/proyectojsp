

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena= "jdbc:oracle:thin:@LOCALHOST:1521:XE"; 
Connection cn =  DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>EMPLEADOS DEPARTEMENTOS SELECT</h1>
        <form method="post">
        <select name="selectdeptno">
            <%
            String sqldept="select * from dept";
            Statement st = cn.createStatement();
            ResultSet rs= st.executeQuery(sqldept);
            while (rs.next()){
            String nombre = rs.getString("dnombre");
            String deptno = rs.getString("dept_no");
            %>
            <option value="<%=deptno%>"><%=nombre%></option>
            <%
            }
            rs.close();
            %>
            
        </select>
            <button type="submit">Mostrar empleados</button>
    </form>
    <hr/>
    <table border="1">
        <thead>
            <tr>
                <th>apellido</th>
                <th>oficio</th>
                <th>departamento</th>
            </tr>
        </thead>
        <tbody>
            <%
            String dato = request.getParameter("selectdeptno");
            if(dato != null){
            int num = Integer.parseInt(dato);
            String sqlemp ="select * from emp where dept_no=?";
            PreparedStatement pst = cn.prepareStatement(sqlemp);
            pst.setInt(1 , num);
            rs = pst.executeQuery();
            while (rs.next()){
            String ape = rs.getString("apellido");
            String ofi = rs.getString("oficio");
            String numero = rs.getString("dept_no");
            %>
            <tr>
                <td><%=ape%></td>
                <td><%=ofi%></td>
                <td><%=numero%></td>
            </tr>
            <%
            }
rs.close();
            }
cn.close();
            %>
        </tbody>
    </table>
    </body>
</html>
