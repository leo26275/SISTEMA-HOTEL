<%-- 
    Document   : ReporteA
    Created on : Apr 15, 2019, 4:50:59 PM
    Author     : xomet
--%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="Conexion.conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Habitaciones</title>
    </head>
    <body>
         <%
           
          conexion conexion = new conexion();
            File reporfile = new File(application.getRealPath("Reportes/Reporte5.jasper"));
            Map parameter = new HashMap();
            String estado = request.getParameter("estado");
            parameter.put("estado", estado);
            byte[] bytes = JasperRunManager.runReportToPdf(reporfile.getPath(), parameter, conexion.getConexion());
            response.setContentType("application.pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outpouststream = response.getOutputStream();
            outpouststream.write(bytes, 0, bytes.length);
            outpouststream.flush();
            outpouststream.close();
   
        %>
    </body>
</html>
