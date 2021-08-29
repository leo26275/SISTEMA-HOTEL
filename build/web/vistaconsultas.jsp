<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="modelo.entidad.Categoria"%>
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
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registro de Categorias</title>
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>
        <link href="resources/tablas/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%    String tipo = String.valueOf(session.getAttribute("tipo"));
        %>

        <%if (tipo.equals("Ordenanza")) {%>
        <%@include file="menuencabezadoempleado.jsp" %>
        <%} else {%>
        <%@include file="menuencabezado.jsp" %>
        <%}%>
        <main class="page-content">
            <div class="row">
                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <!-- left column -->
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3>Listado de Consultas</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <div class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-control-static" style="color: #333; font-size: 15px;">
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Producto con su categoria</label>
                                                <div class="col-sm-3"> 
                                                    <a class="btn btn-success" href="ProductosCategorias.do" >Abrir</a>
                                                </div>

                                                <label class="col-sm-3 control-label">Habitaciones Ocupadas</label>
                                                <div class="col-sm-3"> 
                                                    <a href="HabitacionesOcupadas.do" class="btn btn-success" >Abrir</a>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Habitaciones disponibles</label>
                                                <div class="col-sm-3"> 
                                                    <a class="btn btn-success" href="HabitacionesDisponibles.do" >Abrir</a>
                                                </div>

                                                <label class="col-sm-3 control-label">Informacion de las reserva</label>
                                                <div class="col-sm-3"> 
                                                    <a class="btn btn-success" href="InformacionReservasCosto.do"  >Abrir</a>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">Informacion de los empleados/cargos</label>
                                                <div class="col-sm-3"> 
                                                    <a class="btn btn-success" href="InformacionEmpleadosCargos.do" >Abrir</a>
                                                </div>

                                                <label class="col-sm-3 control-label">Empleados que no tienen acceso al sistema</label>
                                                <div class="col-sm-3"> 
                                                    <a class="btn btn-success" href="EmpleadossinAcceso.do" >Abrir</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>
                            <!-- /.box -->
                            <!-- Input addon -->
                        </div>
                        <!--/.col (left) -->
                    </div>
                    <!-- /.row -->
                </section>
            </div>
        </main>
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/dist/js/myajax.js" type="text/javascript"></script>
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        <script src="resources/dist/js/diseño.js" type="text/javascript"></script>
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
            location.href = "Login.jsp";
        }
    }</script> 