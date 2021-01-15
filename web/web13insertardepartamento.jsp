<%-- 
    Dibujamos tres cajas para insertar un departamento.
    Veremos una tabla con todos los datos de todos los departamento.
    Al insertar, veremos los cambios y un mensaje informativo.
--%>
    <i class="bi bi-dice-6"></i>
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dice-6" viewBox="0 0 16 16">
  <path d="M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"/>
  <path d="M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
  </svg>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--importaremos los driver --%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");

%>
<!DOCTYPE html >
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insertar</title>
    </head>
    <body>
        
        <%--  <main class="main bg-dark">
          
            <iframe class="iframe-preview" width="100%" src="imagen/1.jpg"></iframe>
          
       </main> --%>
        <h1>Insertar Departamentos</h1>
     
    <form method="post" >
        <label> deptno </label>
        <%-- creamos el boton del campo que quiero insertar y 
        le ponemos un nombre para poder llamarlo y con
        sumit lo mandamos al servidor--%> 
        <input type="number" name="cajanumero" required/>
        
        <%--repetimos la operacion cambiando la llamada para poder insertar 
        otro campo distinto--%>
        <label> Nombre</label>
        <input type="text" name="cajanombre" required/>
        <%-- misma operacion para loc--%>
        <label>Localidad </label>
        <input type="text" name="cajaloc" required/>
        
        <button type="sumit" > insert dept</button>
    </form>
       
            <%
                //valido las cajas , capturo los datos
                String dato = request.getParameter("cajanumero");
                String nom = request.getParameter("cajanombre");
                String loc = request.getParameter("cajaloc");
                int insertado = -1;
                //realizamos la consulta , en este caso el insert.
                if (dato != null){
                    int numero = Integer.parseInt(dato);
                  String sqldeptinser = "insert into dept values(?,?,?)";
            //como tiene parametros  necesitaremos un preparedStatemen
            PreparedStatement pst = cn.prepareStatement(sqldeptinser);
            pst.setInt(1,numero);
            pst.setString(2,nom);
            pst.setString(3, loc);
            insertado = pst.executeUpdate();
                }
          
        
            %>
        <table border="1">
            <thead>
            <td>Departamento</td>
            <td>Nombre</td>
            <td>Localidad</td>
            </thead>
            <%
            String sqldept = "select * from dept";
            Statement st = 
                            cn.createStatement();
            ResultSet rs = st.executeQuery(sqldept);
            while (rs.next()){
            String deptno = rs.getString("dept_no");
            String dnombre = rs.getString("dnombre");
            String localidad = rs.getString("loc");
            %>
            <tr>
            <td><%=deptno%></td>
            <td><%=dnombre%></td>
            <td><%=localidad%></td>
            </tr>
            <%
            }
            rs.close();
            %>
        </table>
            <%
                if (dato != null){
                %>
                <h1 style="color: green">Insertado Nuevo departamento
                    <%=insertado%></h1>
                <%
                }
        cn.close();
                %>  
                
 </body>
</html>
