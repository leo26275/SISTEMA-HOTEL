<%-- 
    Document   : index
    Created on : 14/04/2019, 06:20:36 AM
    Author     : Sony
--%>

<%@page import="modelo.entidad.Habitacion"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dao.DaoReserva"%>
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
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hotel Notre Dame</title>

        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>

    </head>


    <body>
        <%    String tipo = String.valueOf(session.getAttribute("tipo"));
        %>
        
        <%if(tipo.equals("Ordenanza")){%>
        <%@include file="menuencabezadoempleado.jsp" %>
        <%}else{%>
        <%@include file="menuencabezado.jsp" %>
        <%}%>

        <main class="page-content">
            <div class="row">
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="box">
                                <div class="box-header">
                                    <h3 class="box-title" style="text-align: center;">Listado de <b>Habitaciones</b></h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">
                        <!--Aqui el for para generar las habitaciones-->
                        <%                            
                            List<Habitacion> lsthabitacion = (List<Habitacion>) request.getAttribute("listahabitaciones");
                            for (Habitacion h : lsthabitacion) {
                        %>
                        
                        <%if(h.getEstado().equals("Disponible")){%>
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-habitaciondisponible">
                                <div class="inner">
                                    <h3><%= h.getNumero() %></h3>

                                    <p><%= h.getEstado()%></p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-bed"></i>
                                </div>
                                <a href="#" class="small-box-footer"><%= h.getTipohabitacion()%> <i class="fa fa-th"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <%}else if(h.getEstado().equals("Ocupada")){%>
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-habitacionocupada">
                                <div class="inner">
                                    <h3><%= h.getNumero() %></h3>

                                    <p><%= h.getEstado()%></p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-bed"></i>
                                </div>
                                <a href="#" class="small-box-footer"><%= h.getTipohabitacion()%> <i class="fa fa-th"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <%}else if(h.getEstado().equals("Mantenimiento")){%>
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-habitacionmantenimiento">
                                <div class="inner">
                                    <h3><%= h.getNumero() %></h3>

                                    <p><%= h.getEstado()%></p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-bed"></i>
                                </div>
                                <a href="#" class="small-box-footer"><%= h.getTipohabitacion()%> <i class="fa fa-th"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <%}%>
                        
                        <%}%>
                                </div>
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </section>
            </div>


        </main>
        <!-- page-content" -->
        <!--footer exportado-->
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        <script src="resources/dist/js/diseño.js" type="text/javascript"></script>
        <script src="resources/dist/js/reloj.js" type="text/javascript"></script>
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