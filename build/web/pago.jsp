<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="Adicionales.CodigoFactura"%>
<%@page import="modelo.entidad.Pago"%>
<%@page import="modelo.entidad.Reserva"%>
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
        <title>Registro de Pagos</title>
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
            CodigoFactura codigo = new CodigoFactura();
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
                                    <h3>Registro de Pagos</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-pago" action="AgregarPago.do" method="GET" class="form-horizontal">
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
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Total Pago habitación</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" onkeyup="concatenar();" name="pagohabitacion" id="pagohabitacion" readonly="readonly">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Tipo de Comprobante</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="tipocomprobante" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <option value="Factura">Factura</option>
                                                    <option value="Ticked">Ticked</option>

                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Numero del Comprobante</label>
                                            <div class="col-sm-6">
                                                <input type="text" readonly="readonly" class="form-control" value="<%= codigo.generarCodigo()%>" name="numcomprobante" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Impuesto</label>
                                            <div class="col-sm-6">
                                                <input type="text" readonly="readonly" class="form-control" onkeyup="concatenar();"  name="impuesto" value="0.13" id="pimpuesto"  required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Fecha de la Emisión</label>
                                            <div class="col-sm-6">
                                                <input type="date" readonly="readonly" name="fechaemisionreserva" class="form-control" id="fechaemision" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Fecha de Pago</label>
                                            <div class="col-sm-6">
                                                <input type="date" name="fechapagoreserva" class="form-control" id="fechapago" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Pago Total</label>
                                            <div class="col-sm-6">
                                                <input type="text" readonly onclick="concatenar();" class="form-control" name="pagototal" id="pagototal12">
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        function concatenar() {
                                            var fil = Number(document.getElementById("pagohabitacion").value);
                                            var col = Number(document.getElementById("pimpuesto").value);
                                            document.getElementById("pagototal12").value = ((fil * col) + fil);
                                        }

                                    </script>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <button type="submit" class="btn btn-primary pull-right"><span class="fa fa-save"></span> Guardar</button>
                                            </div>
                                            <div class="col-sm-3">
                                                <button id="limpiar" name="limpiar" type="reset" class="btn btn-warning"><span class="fa fa-dedent"></span> Limpiar</button>
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

                </section>
                <br>
                <br>
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="box">
                                <div class="box-header">
                                    <h3 class="box-title">Listado de Pagos</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <table id="example1" class="table data-table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Reserva</th>
                                                <th>Habitacion</th>
                                                <th>Cliente</th>
                                                <th>Comprobante</th>
                                                <th>Numero del Comprobante</th>
                                                <th>Impuesto</th>
                                                <th>Fecha de Emisión</th>
                                                <th>Fecha de Pago</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%                                        List<Pago> lstpagos = (List<Pago>) request.getAttribute("listapagos");
                                                for (Pago p : lstpagos) {
                                            %>
                                            <tr>
                                                <td><%= p.getReserva().getIdreserva()%></td>
                                                <td><%= p.getReserva().getHabitacion().getNumero()%></td>
                                                <td><%= p.getReserva().getClientes().getNombres() + " " + p.getReserva().getClientes().getApellidos()%></td>
                                                <td><%= p.getTipocomprobante()%></td>
                                                <td><%= p.getNumcomprobante()%></td>
                                                <td><%= p.getIgv()%></td>
                                                <td><%= p.getFechaemision()%></td>
                                                <td><%= p.getFechapago()%></td>
                                                <td>
                                                    <a name="borrar" href="BorrarPago.do?idpago=<%= p.getIdpago()%>" class="btn btn-danger"><span class="fa fa-trash"></span></a>
                                                </td>
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
            <!-- /.row -->
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
                                                        <th>Habitacion</th>
                                                        <th>Caracteristicas</th>
                                                        <th>Total Pagar</th>
                                                        <th>Cliente</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%                                                        DaoReserva pagos = new DaoReserva();
                                                        int i = 0;
                                                        List<Reserva> listareservas = (List<Reserva>) request.getAttribute("listareserva");
                                                        for (Reserva r : listareservas) {
                                                    %>
                                                    <tr id="<%= r.getIdreserva()%>">
                                                        <td>
                                                            <a data-role="add" data-id="<%= r.getIdreserva()%>" class="btn btn-info"><span class="fa fa-hotel"></span></a>
                                                        </td>
                                                        <td data-target="habitacion"><%= r.getHabitacion().getNumero()%></td>
                                                        <td data-target="habicaracteristicas"><%= r.getHabitacion().getCaracteristicas()%></td>
                                                        <td data-target="pago"><%= r.pagohabitacion()%></td>
                                                        <td data-target="cliente"><%= r.getClientes().getNombres() + " " + r.getClientes().getApellidos()%></td>
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
                    var pagohabitacion = $('#' + id).children('td[data-target=pago]').text();

                    $('#nombrecliente').val(cliente);
                    $('#idreserva').val(id);
                    $('#reserva').val('Reserva: ' + id);
                    $('#habitacion').val('Habitación: ' + habitacion);
                    $('#pagohabitacion').val(pagohabitacion);
                    $('#modalreserva').modal('toggle');
                });

                $(document).on('click', '#idguardar', function () {
                    var fechaactual = new Date();
                    var boton = document.getElementById("idguardar").accept;
                    var fechapago = document.getElementById("fechapago").value;
                    var fechaemision = document.getElementById("fechaemision").value;
                    fechapago = new Date(fechapago);
                    if (fechapago < fechaactual) {
                        /*mostrar una alerta*/
                        boton.disabled = true;
                    }
                });
            });
            window.onload = function () {
                var fecha = new Date(); //Fecha actual
                var mes = fecha.getMonth() + 1; //obteniendo mes
                var dia = fecha.getDate(); //obteniendo dia
                var ano = fecha.getFullYear(); //obteniendo año
                if (dia < 10)
                    dia = '0' + dia; //agrega cero si el menor de 10
                if (mes < 10)
                    mes = '0' + mes; //agrega cero si el menor de 10
                document.getElementById('fechaemision').value = ano + "-" + mes + "-" + dia;
            };
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