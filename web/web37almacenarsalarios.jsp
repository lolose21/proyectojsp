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
                <h1>Almacenar</h1>
                <a href="web37mostrarsalarios.jsp">
                    Mostrar salarios
                </a>
                <%
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);


                %>
                <ul class="list-group">
                    <%                  while (rs.next()) {
                            String apellido = rs.getString("apellido");
                            String sal = rs.getString("salario");
                    %>
                    <li class="list-group-item">
                        <a href="web37almacenarsalarios.jsp?salario=<%=sal%>">
                            Almacenar salario <%=apellido%>
                        </a>
                    </li>
                    <%
                        }
                        rs.close();
                        cn.close();
                    %>
                </ul>
                <%
                    //vamos a almacenar cada salario que  venga de forma 
                    //persistente(sesion)
                    int sumasalarial;
                    //preguntamos si ya hemos recibido algun dato
                    //en session
                    if (session.getAttribute("sumasalarial") != null) {
                        //tenemos algo en sesion 
                        sumasalarial = (Integer) session.getAttribute("sumasalarial");
                    } else {
                        //no tenemos nada almacenado y inicializamos
                        //la variable
                        sumasalarial = 0;
                    }
                    String dato = request.getParameter("salario");
                    if (dato != null) {
                        int salario = Integer.parseInt(dato);
                        //nos han mandado un salario y lo sumamos
                        //a la suma salarial
                        sumasalarial += salario;
                        //almacenamos la suma salarial en la sassion
                        //para hacerla persistente
                        session.setAttribute("sumasalarial", sumasalarial);
                %>
                <h1 style="color: blue">Datos almacenados: <%=salario%></h1>
                <%
                    }
                %>
            </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
