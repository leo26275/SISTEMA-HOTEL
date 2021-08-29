<%-- 
    Document   : Empleados con Usurios
    Created on : 04-19-2019, 02:41:28 PM
    Author     : leo_g
--%>

<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="Conexion.conexion"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados con usuarios</title>
    </head>
    <body>
         <%
            conexion con = new conexion();
            File reporfile = new File(application.getRealPath("Reportes/Reporte9.jasper"));
            Map<String, Object> parameter = new HashMap<String, Object>();
            byte[] bytes = JasperRunManager.runReportToPdf(reporfile.getPath(), parameter, con.getConexion());
            response.setContentType("application.pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outpouststream = response.getOutputStream();
            outpouststream.write(bytes, 0, bytes.length);
            outpouststream.flush();
            outpouststream.close();
        %>
    </body>
</html>
