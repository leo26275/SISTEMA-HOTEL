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
                                <hr>
                                <div class="box-header with-border">
                                    <h3>Listado de Reportes</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <div class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Detalle de Reserva</label>
                                            <div class="col-sm-2"> 
                                                <a class="btn btn-success" href="ViewsReports/Detalles de reserva.jsp" target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-2 control-label">Empleados que poseen usuario</label>
                                            <div class="col-sm-1"> 
                                                <a href="ViewsReports/Empleados con Usurios.jsp" class="btn btn-success" target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-3 control-label">Gasto por Clientes</label>
                                            <div class="col-sm-1"> 
                                                <a class="btn btn-success" href="ViewsReports/Gastos de cada cliente.jsp" target="target">Abrir</a>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Informacion de los Empleados</label>
                                            <div class="col-sm-2"> 
                                                <a class="btn btn-success" href="ViewsReports/Informacion de empleados.jsp"  target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-2 control-label">Clientes sin reservas </label>
                                            <div class="col-sm-1"> 
                                                <a class="btn btn-success" href="ViewsReports/Ingresos por empleado.jsp" target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-3 control-label">Planilla de Empleados</label>
                                            <div class="col-sm-1"> 
                                                <a class="btn btn-success" href="ViewsReports/Planilla de empleados.jsp" target="target">Abrir</a>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Lista de Productos</label>
                                            <div class="col-sm-2"> 
                                                <a class="btn btn-success" href="ViewsReports/Productos existentes.jsp" target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-2 control-label">Productos mas Consumidos</label>
                                            <div class="col-sm-1"> 
                                                <a class="btn btn-success" href="ViewsReports/Productos más consumidos.jsp" target="target">Abrir</a>
                                            </div>

                                            <label class="col-sm-3 control-label">Nuevas Reservas</label>
                                            <div class="col-sm-1"> 
                                                <a class="btn btn-success" href="ViewsReports/Reservas de hoy.jsp" target="target">Abrir</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>

                                <hr>
                                <div class="box-header with-border">
                                    <h3>Reportes con Parametros</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <div class="form-horizontal">
                                    <div class="box-body">
                                        <form action="ViewsReports/Habitaciones estado.jsp" method="post" target="target">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Estado de Habitaciones</label>
                                                <div class="col-sm-2"> 
                                                    <select class="form-control" name="estado">
                                                        <option selected="selected" value=" ">Seleccione</option>
                                                        <option value="Disponible">Disponible</option>
                                                        <option value="Ocupada">Ocupada</option>
                                                        <option value="Mantenimiento">Mantenimiento</option>
                                                    </select>
                                                </div>
                                                <div  class="col-sm-1">
                                                    <button class="btn btn-info" type="submit" value="Abrir" target="target">Abrir</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <hr>
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
        <!-- page script -->
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