<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="modelo.entidad.Reserva"%>
<%@page import="modelo.entidad.Habitacion"%>
<%@page import="modelo.entidad.Producto"%>
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
        <title>Informacion de Reservas</title>
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>
        
        <link href="resources/bootstrapvalidator/dist/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/bootstrapvalidator/src/css/bootstrapValidator.css" rel="stylesheet" type="text/css"/>
        
        <link href="resources/tablas/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
                                <div class="box-header col-sm-11">
                                    <h3 class="box-title">Informacion de las reservas realizadas</h3>
                                </div>
                                <div class="col-sm-1"> 
                                    <a name="borrar" href="vistaconsultas.jsp" class="btn btn-primary"><span class="fa fa-arrow-circle-left"></span></a>
                                </div>
                                
                                <br><br><br><br>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <table id="example1" class="table data-table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Habitacion</th>
                                                <th>Caracteristicas</th>
                                                <th>Descripcion</th>
                                                <th>Cliente</th>
                                                <th>Tipo de reserva</th>
                                                <th> Fecha de la reserva</th>
                                                <th> Fecha del ingreso</th>
                                                <th> Fecha de salida</th>
                                                <th>Precio diario</th>
                                                <th>Total a Pagar</th>
                                                <th>Estado</th>
                                                <th>Empleado que realizo la reserva</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Reserva> lstre = (List<Reserva>) request.getAttribute("listareserva");

                                                for (Reserva h : lstre) {
                                            %>
                                            <tr>
                                                <td><%= h.getHabitacion().getNumero() %></td>
                                                <td><%= h.getHabitacion().getCaracteristicas() %></td>
                                                <td><%= h.getHabitacion().getDescripcion()%></td>
                                                <td><%= h.getClientes().getNombres() +" "+h.getClientes().getApellidos() %></td>
                                                
                                                <td><%= h.getTiporeserva()%></td>
                                                <td><%= h.getFechareserva()%></td>
                                                <td><%= h.getFechaingresada()%></td>
                                                <td><%= h.getFechasalida()%></td>
                                                <td><%= h.getHabitacion().getPreciodiario() %></td>
                                                <td><%= h.pagohabitacion()%></td>
                                                <td><%= h.getEstado()%></td>
                                                <td><%= h.getEmpleado().getNombres()+" "+h.getEmpleado().getApellidos() %></td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
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
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/dist/js/myajax.js" type="text/javascript"></script>
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <script src="resources/bootstrapvalidator/dist/js/bootstrapValidator.min.js" type="text/javascript"></script>
        
        <script src="resources/sweetalert-master/docs/assets/sweetalert/sweetalert.min.js" type="text/javascript"></script>
        <script src="resources/tablas/scrolltable.js" type="text/javascript"></script>
        <script src="resources/tablas/datatables.net/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="resources/tablas/datatables.net-bs/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        
        <script src="resources/dist/js/diseño.js" type="text/javascript"></script>
        <script src="resources/dist/js/validacionesformularios.js" type="text/javascript"></script>
        <!-- page script -->
        <script>
            $(function () {
                $('#example1').DataTable()
                $('#example2').DataTable({
                    'paging': true,
                    'lengthChange': false,
                    'searching': false,
                    'ordering': true,
                    'info': true,
                    'autoWidth': false
                });
            });
        </script>
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