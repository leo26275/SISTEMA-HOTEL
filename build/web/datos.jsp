<%-- 
    Document   : datos
    Created on : 16/04/2019, 05:36:42 AM
    Author     : Sony
--%>

<%@page import="modelo.entidad.Cargos"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-control", "must-revalidate");
    response.addHeader("Cache-control", "no-cache");
    response.addHeader("Cache-control", "no-store");
    response.setDateHeader("Expires", 0);
    try {
        if (session.getAttribute("user") == null) {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    } catch (Exception e) {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="box-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Nombres</th>
                        <th>Salario</th>
                        <th>Acciones</th>
                        <th>Mensaje</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Cargos> lstCargos = (List<Cargos>) request.getAttribute("listaDeCargos");

                        for (Cargos c : lstCargos) {
                    %>
                    <tr>
                        <td><%= c.getNombre()%></td>
                        <td><%= c.getSalario()%></td>
                    </tr>
                    <%}%>

                </tbody>
            </table>
        </div>
    </body>
</html>
<script type="text/javascript"> var idleTime = 0;
    $(document).ready(function () {
        var idleInterval = setInterval(timerIncrement, 600); // 1 minute //Zero the idle timer on mouse movement.
        $(this).mousemove(function (e) {
            idleTime = 0;
        });
        $(this).keypress(function (e) {
            idleTime = 0;
        });
    });
    function timerIncrement() {
        idleTime = idleTime + 1;
        if (idleTime > 50) { // 20 minutes 
            location.href="Login.jsp";
        }
    }</script> 