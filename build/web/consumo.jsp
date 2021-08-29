
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.entidad.Producto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.entidad.Reserva"%>
<%@page import="modelo.entidad.Consumo"%>
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
        <title>Registro de Consumos</title>
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>

        <!--validator-->
        <link href="resources/bootstrapvalidator/dist/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/bootstrapvalidator/src/css/bootstrapValidator.css" rel="stylesheet" type="text/css"/>

        <link href="resources/tablas/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            Consumo consumo = (Consumo) request.getAttribute("consumo");
            String tipo = String.valueOf(session.getAttribute("tipo"));
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
                                    <h3>Registro de Consumos</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-consumo" <%if (consumo != null) {%> 
                                      action="EditarConsumo.do"
                                      <%} else {%> 
                                      action="AgregarConsumo.do"
                                      <%}%> method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Cliente</label>
                                            <div class="col-sm-6">
                                                <!--validando para poder recuperar el nombre del cliente-->
                                                <%

                                                    if (consumo != null) {
                                                        List<Reserva> lstreserva = (List<Reserva>) request.getAttribute("listareserva");
                                                        for (Reserva res : lstreserva) {
                                                            if (consumo.getReserva().getIdreserva() == res.getIdreserva()) {
                                                %>
                                                <input type="text" readonly class="form-control" value="<%= res.getClientes().getNombres() + " " + res.getClientes().getApellidos()%>" name="nombrecliente" id="nombrecliente" required>
                                                <%}%>
                                                <%}%>
                                                <%} else {%>
                                                <input type="text" readonly class="form-control" name="nombrecliente" id="nombrecliente" required>
                                                <%}%>
                                            </div>
                                            <div class="col-sm-3">  
                                                <input type="text" class="form-control" <%if (consumo != null) {%>  value="<%= consumo.getReserva().getIdreserva()%>"<%}%> name="idreserva" id="idreserva" style="display: none;" required>
                                                <input type="text" class="form-control" <%if (consumo != null) {%>  value="<%= consumo.getIdconsumo()%>"<%}%> name="idconsumo" id="idreserva" style="display: none;">
                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalreserva">
                                                    <span class="fa fa-plus"></span>
                                                </button>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Producto</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="idproducto" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%
                                                        List<Producto> listaproducto = (List<Producto>) request.getAttribute("listaproducto");
                                                        for (Producto p : listaproducto) {
                                                            if (consumo != null) {
                                                                if (p.getIdproducto() == consumo.getProducto().getIdproducto()) {
                                                    %>
                                                    <option selected="selected" value="<%= p.getIdproducto()%>"><%= p.getNombre()%></option>
                                                    <%} else {%>
                                                    <option value="<%= p.getIdproducto()%>"><%= p.getNombre()%></option>
                                                    <%}%>
                                                    <%} else {%>
                                                    <option value="<%= p.getIdproducto()%>"><%= p.getNombre()%></option>
                                                    <%}
                                                        }%>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Cantidad</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" <%if (consumo != null) {%>  value="<%= consumo.getCantidad()%>"<%}%> name="cantidad" required>
                                            </div>
                                        </div>
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
                                    </div>
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
                <%@include file="tablaconsumo.jsp" %><!--incluimos la tabla correspondiente a consumo-->
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
                                                        <th>Habitacion</th>
                                                        <th>Caracteristicas</th>
                                                        <th>Cliente</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Reserva> listareservas = (List<Reserva>) request.getAttribute("listareserva");
                                                        for (Reserva r : listareservas) {
                                                    %>
                                                    <tr id="<%= r.getIdreserva()%>">
                                                        <td>
                                                            <a data-role="update" data-id="<%= r.getIdreserva()%>" class="btn btn-warning"><span class="fa fa-user-plus"></span></a>
                                                        </td>
                                                        <td data-target="habitacion"><%= r.getHabitacion().getNumero()%></td>
                                                        <td data-target="habitacion"><%= r.getHabitacion().getCaracteristicas()%></td>
                                                        <td data-target="cliente"><%= r.getClientes().getNombres() + " " + r.getClientes().getApellidos()%></td>
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
        <script src="resources/tablas/scrolltable.js" type="text/javascript"></script>

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
                $(document).on('click', 'a[data-role=update]', function () {
                    var id = $(this).data('id');
                    var habitacion = $('#' + id).children('td[data-target=habitacion]').text();
                    var cliente = $('#' + id).children('td[data-target=cliente]').text();

                    $('#nombrecliente').val(cliente);
                    $('#idreserva').val(id);
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
