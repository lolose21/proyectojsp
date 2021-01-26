<!-- create view empleadoshospital
as 
select empleado_no as idempleado,
apellido , funcion , hospital_cod
from plantilla
union
select doctor_no , apellido
, especialidad , hospital_cod
from doctor;-->
<%@page  import="java.sql.PreparedStatement"%>
<%@page  import="java.sql.ResultSet"%>
<%@page  import="java.sql.Statement"%>
<%@page  import="java.sql.Connection"%>
<%@page  import="oracle.jdbc.OracleDriver"%>
<%@page  import="java.sql.DriverManager"%>
<%@page  contentType="text/html" pageEncoding="UTF-8"%>
<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn
            = DriverManager.getConnection(cadena, "system", "oracle");
%>


<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>Plantilla</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
    <main role="main" class="container">
        
        <div class="starter-template">
          <h1>EMPLEADOS</h1>
          <%
          //RECIBIMOS UN CODIGO (HOSPITAL)
          //Y BUSCAMOS LOS EMPLEADOS DE ESE HOSPITAL
          //Y LOS DIBUJAMOS
          String dato = request.getParameter("hospital");
          if(dato != null){
          //transformamos el texto a numero
          int num = Integer.parseInt(dato);
          String sql ="select * from empleadoshospital where hospital_cod =?";
          //recuperamos los datos con preparedStatement por q tiene parametros
          PreparedStatement pst = cn.prepareStatement(sql);
          //recuperamos el dato que recibimos un numero y lo capturamos 
          pst.setInt(1, num);
          ResultSet rs = pst.executeQuery();
          
          %>
          <table border="1" style="color: blue">
              <thead>
                  <tr>
                      <th style="color: grey">EMPLEADOS</th>
                  </tr>
          <%
          while (rs.next()){
          String idem = rs.getString("idempleado");
          
           %>
           <tr>
               <td>
                    <%=rs.getString("apellido")%>   
               </td>
               <td>
                   <a href="web39detallesempleado.jsp?empleado=<%=idem%>&hospital=<%=dato%>"
                      class="btn btn-primary">
                        <span class="navbar-toggler-icon"></span>
                            <svg  width="16" height="16" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
                            <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
                        </svg> 
                     DETALLES
                   </a>
               </td>
           </tr>
         
              <%
          }
         
          
          //idempleado,
          //apellido , funcion , hospital_cod
          rs.close();
          }
           
          cn.close();

          %>
            </thead>
          </table>
        </div>
    </main><!-- /.container -->
    <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
