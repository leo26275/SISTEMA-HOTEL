<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="Adicionales.NoEliminacion"%>
<%@page import="modelo.entidad.Clientes"%>
<%@page import="modelo.entidad.Habitacion"%>
<%@page import="java.util.List"%>
<%@page import="modelo.entidad.Reserva"%>
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
        <title>Habilitar reservas en mantenimiento</title>
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <!--validator-->
        <link href="resources/bootstrapvalidator/dist/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/bootstrapvalidator/src/css/bootstrapValidator.css" rel="stylesheet" type="text/css"/>
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>
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
                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <!-- left column -->
                        <div class="col-md-12">
                            <!-- general form elements -->
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3>Formulario de Habitaciones en Mantenimiento a Disponobles</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-habilitar" action="AbilitarAbitaciones.do" method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Habitacion</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" name="habitacion" id="numerohabitacion" required readonly="readonly">
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#modalreserva">
                                                    <span class="fa fa-building"></span>
                                                </button>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" name="idhabitacion" id="idhabita" style="display: none;" >
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Estado Habitacion</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="estado" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <option value="Disponible">Disponible</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-7">
                                                <button  type="submit" class="btn btn-success pull-right"><span class="fa fa-eye"></span> Habilitar Habitación</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                </form>
                            </div>
                            <!-- /.box -->

                            <!-- Input addon -->
                        </div>
                        <!--/.col (left) -->
                    </div>
                    <!-- /.row -->
                </section>
                <br>
                <br>
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="box">
                                <div class="box-header">
                                    <h3 class="box-title">Listado de Habitaciones Disponibles</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <table id="example1" class="table data-table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Numero</th>
                                                <th>Piso</th>
                                                <th>Caracteristicas</th>
                                                <th>Descricpcion</th>
                                                <th>Tipo Habitacion</th>
                                                <th>Precio Diario</th>
                                                <th>Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Habitacion> lsthabitacion = (List<Habitacion>) request.getAttribute("listahabitaciones");
                                                for (Habitacion h : lsthabitacion) {
                                            %>
                                            <tr>
                                                <td><%= h.getNumero()%></td>
                                                <td><%= h.getPiso()%></td>
                                                <td><%= h.getCaracteristicas()%></td>
                                                <td><%= h.getDescripcion()%></td>
                                                <td><%= h.getTipohabitacion()%></td>
                                                <td><%= h.getPreciodiario()%></td>
                                                <td><%= h.getEstado()%></td>
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

            <!--Modal content-->
            <div class="modal fade" id="modalreserva">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Listado de Habitaciones en Mantenimiento</h4>
                        </div>
                        <div class="box-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="box">
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <table id="example" class="table data-table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Acción</th>
                                                <th>Numero</th>
                                                <th>Piso</th>
                                                <th>Caracteristicas</th>
                                                <th>Descricpcion</th>
                                                <th>Tipo Habitacion</th>
                                                <th>Precio Diario</th>
                                                <th>Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Habitacion> lstman = (List<Habitacion>) request.getAttribute("listamantenimiento");
                                                for (Habitacion h : lstman) {
                                            %>
                                            <tr id="<%= h.getIdhabitacion() %>">
                                                <td>
                                                    <a data-role="add" data-id="<%= h.getIdhabitacion() %>" class="btn btn-success"><span class="fa fa-hotel"></span></a>
                                                </td>
                                                <td data-target="numero"><%= h.getNumero()%></td>
                                                <td data-target="piso"><%= h.getPiso()%></td>
                                                <td data-target="caracteristicas"><%= h.getCaracteristicas()%></td>
                                                <td data-target="descripcion"><%= h.getDescripcion()%></td>
                                                <td data-target="tipohabitacion"><%= h.getTipohabitacion()%></td>
                                                <td data-target="preciodiario"><%= h.getPreciodiario()%></td>
                                                <td data-target="estado"><%= h.getEstado()%></td>
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
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
        </main>
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        <!--validator-->
        <script src="resources/bootstrapvalidator/dist/js/bootstrapValidator.min.js" type="text/javascript"></script>
        <script src="resources/dist/js/validacionesformularios.js" type="text/javascript"></script>

        <!--sweet alert-->
        <script src="resources/sweetalert-master/docs/assets/sweetalert/sweetalert.min.js" type="text/javascript"></script>
        <script src="resources/tablas/datatables.net/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="resources/tablas/datatables.net-bs/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        <script src="resources/dist/js/diseño.js" type="text/javascript"></script>
        <script src="resources/tablas/scrolltable.js" type="text/javascript"></script>
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

        <script>
            /*pasando por parametros los datos de la fila de la tabla a los input correspondientes*/
            $(document).ready(function () {
                $(document).on('click', 'a[data-role=add]', function () {
                    var id = $(this).data('id');/*id de la habitacion*/
                    var numero = $('#' + id).children('td[data-target=numero]').text();
                    var piso = $('#' + id).children('td[data-target=piso]').text();
                    var caracteristicas = $('#' + id).children('td[data-target=caracteristicas]').text();
                    var descripcion = $('#' + id).children('td[data-target=descripcion]').text();
                    var tipohabitacion = $('#' + id).children('td[data-target=tipohabitacion]').text();
                    var preciodiario = $('#' + id).children('td[data-target=preciodiario]').text();
                    var estado = $('#' + id).children('td[data-target=estado]').text();
                    
                    $('#numerohabitacion').val(numero);
                    $('#idhabita').val(id);
                    $('#modalreserva').modal('toggle');
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