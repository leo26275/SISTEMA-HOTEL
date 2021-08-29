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
        <title>Cancelar Reservas</title>
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
        <%
            String tipo = String.valueOf(session.getAttribute("tipo"));
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
                                    <h3>Formulario para Cancelar Reservas</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-cancelar" action="CambiarEstadoCancelada.do" method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Cliente</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" name="nombrecliente" id="nombrecliente" required disabled>
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalreserva">
                                                    <span class="fa fa-user-plus"></span>
                                                </button>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-3">
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" name="reserva" id="reserva" required disabled>
                                                <input type="text" class="form-control" name="idreserva" id="idreserva" style="display: none;" required>
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" name="habitacion" id="habitacion" required disabled>
                                                <input type="text" class="form-control" name="idhabitacion" id="idhabi" style="display: none;" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Estado reserva</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="estado" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <option value="Cancelada">Cancelada</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-7">
                                                <button  type="submit" class="btn btn-danger pull-right"><span class="fa fa-ban"></span> Cancelar Reserva</button>
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
                                    <h3 class="box-title">Listado de Reservas Canceladas</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <table id="example1" class="table data-table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Id Reserva</th>
                                                <th>Habitacion</th>
                                                <th>Cliente</th>
                                                <th>Tipo de Reserva</th>
                                                <th>Fecha de la Reserva</th>
                                                <th>Fecha del Ingreso</th>
                                                <th>Fecha de Salida</th>
                                                <th>Estado de la Reserva</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Reserva> lstreserva = (List<Reserva>) request.getAttribute("listareservasactualizar");
                                                for (Reserva r : lstreserva) {
                                            %>
                                            <tr>
                                                <td><%= r.getIdreserva()%></td>
                                                <td><%= r.getHabitacion().getNumero()%></td>
                                                <td><%= r.getClientes().getNombres() + " " + r.getClientes().getApellidos()%></td>
                                                <td><%= r.getTiporeserva()%></td>
                                                <td><%= r.getFechareserva()%></td>
                                                <td><%= r.getFechaingresada()%></td>
                                                <td><%= r.getFechasalida()%></td>
                                                <td><%= r.getEstado()%></td>
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
                            <h4 class="modal-title">Listado de Reservas</h4>
                        </div>
                        <div class="box-body">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="box">
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <table id="example1" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Acciones</th>
                                                        <th style="display: none;">Id Habitacion</th>
                                                        <th>Habitacion</th>
                                                        <th>Caracteristicas</th>
                                                        <th>Cliente</th>
                                                        <th>Estado</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        DaoReserva pagos = new DaoReserva();
                                                        int i = 0;
                                                        List<Reserva> listareservas = (List<Reserva>) request.getAttribute("listareservascombo");
                                                        for (Reserva r : listareservas) {
                                                    %>
                                                    <tr id="<%= r.getIdreserva()%>">
                                                        <td>
                                                            <a data-role="add" data-id="<%= r.getIdreserva()%>" class="btn btn-danger"><span class="fa fa-hotel"></span></a>
                                                        </td>
                                                        <td data-target="idhabitacion" style="display: none;"><%= r.getHabitacion().getIdhabitacion()%></td>
                                                        <td data-target="habitacion"><%= r.getHabitacion().getNumero()%></td>
                                                        <td data-target="habicaracteristicas"><%= r.getHabitacion().getCaracteristicas()%></td>
                                                        <td data-target="cliente"><%= r.getClientes().getNombres() + " " + r.getClientes().getApellidos()%></td>
                                                        <td data-target="pago"><%= r.getEstado()%></td>
                                                        <%i++;%>
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
                    var id = $(this).data('id');
                    var habitacion = $('#' + id).children('td[data-target=habitacion]').text();
                    var cliente = $('#' + id).children('td[data-target=cliente]').text();
                    var idhabitacion = $('#' + id).children('td[data-target=idhabitacion]').text();

                    $('#nombrecliente').val(cliente);
                    $('#idreserva').val(id);
                    $('#idhabi').val(idhabitacion);
                    $('#reserva').val('Reserva: ' + id);
                    $('#habitacion').val('Habitación: ' + habitacion);
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
            location.href = "Login.jsp";
        }
    }</script> 