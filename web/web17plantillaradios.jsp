<%-- 
 
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>PLANTILLA RADIOS</h1>
        <form method="checked">
            <ul>
             <%
             String sqlfuncion = "select distinct funcion from plantilla";
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(sqlfuncion);
             //necesitamos saber si nos ha mandado algun dato el usuario
             String seleccionado = request.getParameter("funcion");
             while (rs.next()){
             String fun = rs.getString("funcion");
                %>
             <li>
                 <input type="radio" name="funcion" value="<%=fun%>"/><%=fun%>
             </li>
            
                 <%

             if (seleccionado == null){
                 %>
             <li>
                 <input type="radio" name="funcion" value="<%=fun%>"/><%=fun%>
             </li>
            
                <%
             //no seleccionamos
             }else{
                 //comparamos
             if(seleccionado.equals(fun)){
                %>
             <li>
                 <input type="radio" name="funcion" value="<%=fun%>"/><%=fun%>
             </li>
            
                <%
             }else{
             //no seleccionamos
                %>
             <li>
                 <input type="radio" name="funcion" value="<%=fun%>"/><%=fun%>
             </li>
            
                 <%
             }
             }
           
                  
             }
             rs.close();
             %>
            </ul>
            <button type="submit">MOSTRAR PLANTILLA</button>
         
            </form>
            <hr/>
             <%
            String funcion = request.getParameter("funcion");
            if (funcion != null ){
            String sqlplantilla = "select * from plantilla where funcion=?";
            PreparedStatement pst = cn.prepareStatement(sqlplantilla);
            pst.setString(1,funcion);
            rs = pst.executeQuery();
            %>
            <table border="1">
                   
            <%
            while(rs.next()){
            String ape = rs.getString("apellido");
            String sal = rs.getString("salario");
            
            %>
                 <tr>
                    <td><%=ape%></td>
                    <td><%=sal%></td>
                 </tr>
            <%
            }
            rs.close();
            %>
            </table>
            <%
            }
            cn.close();
            %>
    </body>
</html>
