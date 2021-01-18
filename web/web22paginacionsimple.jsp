<%-- 
 
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena , "system" , "oracle");
%>
<link href="css/bootstrap-reboot.min.css" rel="stylesheet" type="text/css"/>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="css/evo-calendar.royal-navy.css" rel="stylesheet" type="text/css"/>
<link href="css/evo-calendar.royal-navy.min.css" rel="stylesheet" type="text/css"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <nav>
        <style>
            ul#menu li {
                display:inline;
            }
        </style>
    </nav>
    </head>
    <body>
        <h1>Paginacion simple</h1>
        <%
        String sql = "select * from emp";
        Statement st =
                    cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE ,
                            ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        //necesitamos realizar las variables para el 
        //mavimiento
        int siguiente , anterior ,ultimo;
        //el ultimo es fijo , seran el numero de elementos
        //que tiene la consulta
        rs.last();
        //averiguamos la posicion de la fila
        ultimo = rs.getRow();
        //necesitamos saber la posicion en la que deseamos
        //el cursor
        int posicion =1;
        if (request.getParameter("posicion")==null){
        siguiente = posicion +1;
        anterior =1 ;
        
        }else{
        String dato = request.getParameter("posicion");
        posicion = Integer.parseInt(dato);
        //comprobamos la posicion para no pasarnos
        if( posicion == 1){
                anterior =1;
                
        }else{
        anterior = posicion -1;
        }
        if(posicion == ultimo){
        siguiente = ultimo;
        }else{
        siguiente = posicion +1;
        }
        }
        //ponemos el cursor en la posicion
        rs.absolute(posicion);
        %>
        <dl>
            <dt>Apellido : <b><%=rs.getString("apellido")%> </b></dt>
            <dd>Oficio: <%=rs.getString("oficio")%></dd>
            <dd>salario <%=rs.getString("salario")%> </dd>
                    
        </dl>
            <h2 style="color:blue">
                Registro <%=posicion%> de <%=ultimo%>
            </h2>
            <%
            rs.close();
            cn.close();
            %>
            <hr/>
            <ul id="menu">
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=1">Primero</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=siguiente%>">Siguiente</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=anterior%>">Anterior</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=ultimo%>">Ultimo</a>
                </li>
            </ul>
  
    <script src="js/Chart.bundle.min.js" type="text/javascript"></script>

<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="js/sweetalert2.all.min.js" type="text/javascript"></script>
<script src="js/funciones.js" type="text/javascript"></script>
  </body>
</html>