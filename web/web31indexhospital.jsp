

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

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOSPITALES</title>

    </head>
    <body>
        <%
        String eliminar =request.getParameter("eliminar");
        if(eliminar != null){
        int numero =Integer.parseInt(eliminar);
        String sqldelete= "delete from hospital where hospital_cod=?";
        PreparedStatement pst = cn.prepareStatement(sqldelete);
        pst.setInt(1, numero);
        pst.executeUpdate();
        }
        %>
        <jsp:include page="includes/webmenuhospitales.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="Stater-template" >
                    <h1>INDEX HOSPITALES</h1>
                    <%
                        //CONSULTA
                        String sql = "select * from hospital ";
                  
                        //recuperamos la consulta con Statement por que no tiene parametros
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        //creamos la cabecera de la tabla donde leeremos los datos
                    %>
                    <table border="1">
                        <thead>
                            <tr>
                               
                                <th>HOSPITAL_COD</th>
                                <th>NOMBRE</th>
                                <th>DIRECCION</th>
                                <th>TELEFONO</th>
                                <th>NUM_CAMAS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                //recuperamos los datos que deseamos leer en
                                //el cuerpo y les ponemos nombre para poder 
                                //llamarlos
                                while (rs.next()) {
                                    String num = rs.getString("hospital_cod");
                                    String nom = rs.getString("nombre");
                                    String direc = rs.getString("direccion");
                                    String tel = rs.getString("telefono");
                                    String cama = rs.getString("num_cama");
                                    
                                    //hacemos los td para rellenar el cuerpo.
                                    //cerramos java y abrimos java dentro del 
                                    //while, para poder recorrer los datos
%>
                            <tr>
                       
                        <td><%=num%></td>
                        <td><%=nom%></td>
                        <td><%=direc%></td>
                        <td><%=tel%></td>
                        <td><%=cama%></td>
                        <td>
                            <a class="btn btn-primary"
                               href="web34detailshospital.jsp?hospitalcod=<%=num%>"
                                <span class="navbar-toggler-icon"></span>
                                <svg  width="16" height="16" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
                                <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
                                 </svg> 
                               DETALLES 
                            </a>
                                <a class="btn btn-primary" border="1" 
                                   href="web33updatehospital.jsp?hospitalcod=<%=num%>"
                                   <span style="color: red" class="navbar-toggler-icon" ></span>
                                    <svg  style="color: red" width="16" height="16" fill="currentColor:red" class="bi bi-github" viewBox="0 0 16 16">
                                    <path style="color: red" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
                                    </svg> 
                                   Modificar
                                </a>  
                        </td>
                        <td>
                            <a href="web31indexhospital.jsp?eliminar=<%=num%>"
                               class="btn-outline-danger" onclick="eliminar()">
                                ELIMINAR
                                </a>
                        </td>
                        </tr>
                        <%
                            }
                            //cerramos los cursores
                            rs.close();
                            cn.close();
                        %>
                        </tbody>

                    </table>   
                </div>
            </main>
        </section>
                         <script>
             $(document).ready(function eliminar() {
    $("#botonp").click(function eliminar() {
                            swal({
  title: "quieres borrar?",
  text: "uno borrado, !",
  icon: "peligro",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    swal("Poof! tu imajina que has borrado una fila!", {
      icon: "success",
    });
  } else {
    swal(" borro!");
  }
});
    });
    });
    
      </script>

        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
