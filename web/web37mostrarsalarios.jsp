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
                <h1>Mostrar</h1>
                <a href="web37mostrarsalarios.jsp">
              
                    ALMACENAR SALARIOS
                </a>
                <a href="web37mostrarsalarios.jsp?eliminar=ok"
                   class="btn btn-danger"
                   >Borrar todos los datos</a>
                <%
                    if (request.getParameter("eliminar")!= null){
                    session.setAttribute("sumasalarial",null);
                    }
                    if (session.getAttribute("sumasalarial") == null) {
                        //no hay nada en la session
                %>
                <h1 style="color: red">No hay datos en la session</h1>
                <%
                } else {
                    //tenemos datos
                    String datos
                            = session.getAttribute("sumasalarial").toString();
                %>
                <h1 style="color: blue">Suma salarial <%=datos%></h1>
                <%
                    }


                %>
            </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
