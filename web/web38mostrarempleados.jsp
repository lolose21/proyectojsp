
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
                <A href="web38almacenarempleados.jsp">
                    MOSTRAR Empleados
                </A>
                <h1> Empleados almacenados</h1>
                <%
                    //session.setAttribute("empleados", null);
                    String dato = request.getParameter("eliminar");
                    if(dato != null){
                    int idempleado = Integer.parseInt(dato);
                    ArrayList<Integer>idempleados = (ArrayList)
                            session.getAttribute("empleados");
                    //debemos eliminar el empleado que ha venido
                    idempleados.remove((Integer)idempleado);
                    //
                    if (idempleados.size()==0){
                    session.setAttribute("empleados", null);
                    }else{
                 
                    //refrescamos los valores de la session
                    session.setAttribute("empleados", idempleados);
                    }
                    }
                    if (session.getAttribute("empleados") == null) {
                        //no existe
                %>
                <h1 style="color: red">No existen empleados almacenados</h1>
                <%
                    } else {
                        //recuperamos los empleados almacenados
                        ArrayList<Integer> empleados
                                = (ArrayList) session.getAttribute("empleados");
                        //tenemos multiples ides de empleados
                        //debemos hacer una consulta para buscar todos
                        //los empleados por su id
                        //vamos aseparar los empleados por , para
                        //hacer una consulta in()
                        //select * from emp where emp_no in (111,111)
                        //para poder usar join y separar un string  por comas
                        //es necesario tener un array , nosotros tenemos una coleccion
                        //convertir la coleccion en array de string
                        String datos = "";
                        for (int id: empleados){
                        datos += id + ",";
                        }
                        int ultimacoma = datos.lastIndexOf(",");
                        datos = datos.substring(0 , ultimacoma);
                       
                            String sqlselect =
                            "select * from emp where emp_no in ("+ datos + ")";
                            Statement st = cn.createStatement();
                            ResultSet rs = st.executeQuery(sqlselect);
                            %>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>APELLIDO</th>
                                        <th>OFICIO</th>
                                        <th>SALARIO</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                           
                            <%
                            while (rs.next()){
                            String ape = rs.getString("apellido");
                            String ofi = rs.getString("oficio");
                            String sal = rs.getString("salario");
                            String id= rs.getString("emp_no");
                            %>
                            <tr>
                                <td><%=ape%></td>
                                <td><%=ofi%></td>
                                <td><%=sal%></td>
                                <td>
                                    <a class="btn btn-danger"
                                        href="web38mostrarempleados.jsp?eliminar=<%=id%>">
                                    Quitar
                                    </a>
                                </td>
                            </tr>
                            <%
                                
                            }
                        rs.close();
                        cn.close();
                    }
                   
                %>
            </tbody>
            </table>
            </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
