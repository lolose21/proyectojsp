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
Connection cn =
    DriverManager.getConnection(cadena,"system","oracle");
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOSPITALES</title>
    </head>
    <body>
        <%
        String cajanumero = request.getParameter("cajanumero");
        String cajanombre = request.getParameter("cajanombre");
        String cajadireccion =request.getParameter("cajadireccion");
        String cajatelefono =request.getParameter("cajatelefono");
        String cajanumcama =request.getParameter("cajanumcama");
        if (cajanumero != null){
        int numero = Integer.parseInt(cajanumero);
        int tel = Integer.parseInt(cajatelefono);
        int cama = Integer.parseInt(cajanumcama);
        String sqlupdate ="update hospital set nombre =? , direccion = ? ,"
                + "telefono =? , num_cama =? where hospital_cod =?";
        PreparedStatement pst = cn.prepareStatement(sqlupdate);
        pst.setString(1, cajanombre);
        pst.setString(2, cajadireccion);
        pst.setInt(3, tel);
        pst.setInt(4, cama);
        pst.setInt(5,numero);
        pst.executeUpdate();
        cn.close();
        %>
        <jsp:forward page="web31indexhospital.jsp"/>
        <%
        }
        %>
         <jsp:include page="includes/webmenuhospitales.jsp"/>
         <section>
             <main role="main" class="container">
                 <div class="Stater-template" >
                      <h1>UPDATE HOSPITAL</h1>
                     <a href="web31indexhospital.jsp" class="btn btn-outline-danger">
                            <svg  width="16" height="16" fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
                            <path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
                            </svg>
                          Volver a Index</a>
                      <%
                      String dato = request.getParameter("hospitalcod");
                      if(dato != null){
                      int numero = Integer.parseInt(dato);
                      String sqlselect = "select * from hospital where hospital_cod=?";
                      PreparedStatement pst =cn.prepareStatement(sqlselect);
                      pst.setInt(1, numero);
                  
                      ResultSet rs = pst.executeQuery();
                      rs.next();
                      String nombre = rs.getString("nombre");
                      String dir = rs.getString("direccion");
                      String tel = rs.getString("telefono");
                      String cama = rs.getString("num_cama");
                      rs.close();
                      cn.close();
                      %>
                      <div>
                      <form method="post">
                          <input type="hidden" value="<%=numero%>" name="cajanumero"/>
                        </div>
                        <div>
                          <label>Nombre</label>
                          <input type="text" name="cajanombre" 
                                 value="<%=nombre%>" class="form-control"/><br/>
                        </div>
                        <div>
                          <label>direccion</label>
                          <input type="text" name="cajadireccion"
                                 value=" <%=dir%>" class="form-control"/><br/>
                        </div>
                        <div>
                          <label>Telefono</label>
                          <input type="text" name="cajatelefono"
                                 value="<%=tel%>" class="form-control"/><br/>
                        </div>
                        <div>
                          <label>Numcama</label>
                          <input type="text" name="cajanumcama"
                                 value="<%=cama%>" class="form-control"/><br/>
                        </div>
                        
                          <button type="submit" class="btn-info">
                              Modificar
                          </button>
                      </form>
                      <%
                      }
                      %>
                 </div>
        </main>
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
