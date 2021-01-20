
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena =
                "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =
                DriverManager.getConnection(cadena , "system" , "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>Plantilla</title>
    </head>
    <body>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
    <main role="main" class="container">

        <div class="starter-template">
          <h1>create departamentos</h1>
          <form method="post">
              <div>
                  <label>Numero :</label>
                  <input type="text" name="cajanumero"
                         class="form-control"/>
              </div>
              <div>
                  <label>Nombre :</label>
                  <input  type="text" name="cajanombre"
                          class="form-control"/>
              </div>    
              <div>
                  <label>Localidad</label>
                  <input type="text" name="cajalocalidad"
                         class="form-control"/>
                         
              </div>
              <div>
                  <button type="sumit" class="btn btn-outline-danger">
                    <svg  width="16" height="16" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
                        <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
                    </svg>
                      Insertar
                  </button>
                   
              </div>
          </form>
          <%
          String cajanumero = request.getParameter("cajanumero");
          String cajanombre = request.getParameter("cajanombre");
          String cajalocalidad = request.getParameter("cajalocalidad");
          if(cajanumero != null){
          int numero = Integer.parseInt(cajanumero);
          String sql = "insert into dept values (?,?,?)";
          PreparedStatement pst =cn.prepareStatement(sql);
          pst.setInt(1,numero);
          pst.setString(2,cajanombre);
          pst.setString(3, cajalocalidad);
          int insertados = pst.executeUpdate();
          cn.close();
          //tenemos dos opciones:
          //mostrar un mensaje al usuario
          //2 llevarnos a otra pagina , por ejemplo , index
          //para hacer redireccionemos en java se utiliza
          //la etiqueta forwar que nos permite poder 
          //redireccionar a otras paginas
          
          %>
          <h2 style="color: blue">insertados</h2>
          <jsp:forward page="web27indexdept.jsp"/>
          <%
          }
          %>
        
        </div>
    </main><!-- /.container -->
    <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>