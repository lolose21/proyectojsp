<%-- 
  
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = 
            DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Paginacion grupo</h1>
        <%
        String sql ="select * from emp order by apellido";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE , ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        String dato = request.getParameter("posicion");
        int posicion = 1;
        if (dato != null){
        posicion =Integer.parseInt(dato);
        }
        //avarriguamos el numero de registros
        rs.last();
        int numregistros = rs.getRow();
        //posicionamos el cursor en la fila de la posicion
        rs.absolute(posicion);
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>apellido</th>
                    <th>oficio</th>
                    <th>salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                    //recorremos los registros de tres en tres
                for (int i = 1; i <=3 && !rs.isAfterLast(); i++){
                %>
                <tr>
                <td><%=rs.getString("apellido")%></td>
                <td><%=rs.getString("oficio")%></td>
                <td><%=rs.getString("salario")%></td>
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
                    int numeropagina =1;
                    //recorremos los registros de tres en tres
                for (int i =1; i <= numregistros; i+=3){
                %>
                <li>
                    <a href="web23paginaciongrupo.jsp?posicion=<%=i%>">
                        Página <%=numeropagina%>
                    </a>
                </li>
                <%
                    numeropagina +=1;
                }
                %>
                <%--
                <li>
                    <a href="web23paginaciongrupo.jsp?posicion=1">Página 1</a>
                </li>
                <li>
                    <a href="web23paginaciongrupo.jsp?posicion=4">Pagina 2</a>
                </li>
                <li>
                    <a href="web23paginaciongrupo.jsp?posicion=7">Página 3</a>
                </li>--%>
            </ul>
    </body>
</html>
