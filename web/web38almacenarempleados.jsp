
<%@page import="java.util.ArrayList"%>
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
                <a href="web38mostrarempleados.jsp">
                    MOSTRAR ALMACENADOS
                </a>
                <h1>Almacenar empleados</h1>
                <%
                    //necesitamos almacenar varios id de enpleado
                    //vamos  a recibir un id y lo almacenamos en 
                    //un arraylist al recibirlo
                    String dato = request.getParameter("idempleado");
                    if (dato != null){
                         int idempleado = Integer.parseInt(dato);
                         ArrayList<Integer>empleados;
                         //preguntamos si ya tenemos empleados almacenados
                         if (session.getAttribute("empleados") != null){
                         //recuperamos los empleados
                         empleados = (ArrayList)session.getAttribute("empleados");
                         }else{
                         //creamos una coleccion para almacenar los empleados
                         empleados = new ArrayList();
                         }
                         //almacenamos el idempleado que viene en la peticion
                         empleados.add(idempleado);
                         //guardamos los nuevos datos en la session
                         session.setAttribute("empleados", empleados);
                         %>
                         <h1 style="color: blue">Empleados almacenados <%=empleados.size()%></h1>
                        <%
                    }
                    
                    String sql = "SELECT * FROM EMP";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                %>
                <ul class="list-group">
                    <%
                        while (rs.next()) {
                            String ape = rs.getString("apellido");
                            String empno = rs.getString("emp_no");
                    %>
                    <li class="list-group-item">
                        <a href="web38almacenarempleados.jsp?idempleado=<%=empno%>">
                            Almacenar <%=ape%>
                        </a>
                    </li>
                    <%
                        }
                        rs.close();
                        cn.close();
                    %>
                </ul>
            </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
