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
        <title>Registro de Reservas</title>
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
            NoEliminacion ne = new NoEliminacion();

            Reserva reserva = (Reserva) request.getAttribute("reserva");

            String nombreuser = String.valueOf(session.getAttribute("nomuser"));
            String iduser = String.valueOf(session.getAttribute("iduser"));
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
                                    <h3>Registro de Reservas</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-reserva" <%if (reserva != null) {%> 
                                      action="EditarReservas.do"
                                      <%} else {%> 
                                      action="AgregarReservas.do"
                                      <%}%> method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Habitación</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="idhabitacion" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%
                                                        List<Habitacion> lsthabitacion = (List<Habitacion>) request.getAttribute("listahabitaciones");
                                                        for (Habitacion h : lsthabitacion) {
                                                            if (reserva != null) {
                                                                out.print(reserva.getHabitacion().getIdhabitacion());
                                                                if (h.getIdhabitacion() == reserva.getHabitacion().getIdhabitacion()) {
                                                    %>
                                                    <option selected="selected" value="<%= h.getIdhabitacion()%>"><%= h.getNumero()%></option>
                                                    <%} else {%>
                                                    <option value="<%= h.getIdhabitacion()%>"><%= h.getNumero()%></option>
                                                    <%}%>
                                                    <%} else {%>
                                                    <option value="<%= h.getIdhabitacion()%>"><%= h.getNumero()%></option>
                                                    <%}
                                                        }%>
                                                </select>
                                                <input type="text" class="form-control" value="<%=(reserva == null) ? "" : reserva.getIdreserva()%>" name="idreserva" style="display: none;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Cliente</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="idcliente" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%
                                                        List<Clientes> lstclientes = (List<Clientes>) request.getAttribute("listadoclientes");
                                                        for (Clientes c : lstclientes) {
                                                            if (reserva != null) {
                                                                if (c.getIdcliente() == reserva.getClientes().getIdcliente()) {
                                                    %>
                                                    <option selected="selected" value="<%= c.getIdcliente()%>"><%=c.getNombres() + " " + c.getApellidos()%></option>
                                                    <%} else {%>
                                                    <option value="<%= c.getIdcliente()%>"><%=c.getNombres() + " " + c.getApellidos()%></option>
                                                    <%}%>
                                                    <%} else {%>
                                                    <option value="<%=c.getIdcliente()%>"><%=c.getNombres() + " " + c.getApellidos()%></option>
                                                    <%}
                                                        }%>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Empleado</label>
                                            <div class="col-sm-6">
                                                <input type="text" value="<%=nombreuser%>" class="form-control" name="empleado" required readonly>
                                                <input type="text" class="form-control" name="idempleado" required value="<%=iduser%>" style="display: none;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Tipo de Reserva</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="tiporeserva" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%if (reserva == null) {%>
                                                    <option value="Reserva">Reserva</option>
                                                    <option value="Alquiler">Alquiler</option>
                                                    <%} else {%>

                                                    <%if (reserva.getTiporeserva().equals("Reserva")) {%>
                                                    <option selected="selected" value="<%=reserva.getTiporeserva()%>"><%=reserva.getTiporeserva()%></option>
                                                    <option value="Alquiler">Alquiler</option>
                                                    <%} else if (reserva.getTiporeserva().equals("Alquiler")) {%>
                                                    <option value="Reserva">Reserva</option>
                                                    <option selected="selected" value="<%=reserva.getTiporeserva()%>"><%=reserva.getTiporeserva()%></option>
                                                    <%}
                                                        }%>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Fecha de la Reserva</label>
                                            <div class="col-sm-6">
                                                <%if (reserva == null) {%>
                                                <input type="date" readonly="readonly" class="form-control" id="fechaActual" name="fechareserva" required>
                                                <%} else {%>
                                                <input type="date" readonly="readonly" value="<%=reserva.getFechareserva()%>" class="form-control" name="fechareservas">
                                                <%}%>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Fecha de Ingreso</label>
                                            <div class="col-sm-6">
                                                <input type="date" value="<%=(reserva == null) ? "" : reserva.getFechaingresada()%>" class="form-control" name="fechaingreso" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Fecha de Salida</label>
                                            <div class="col-sm-6">
                                                <input type="date" value="<%=(reserva == null) ? "" : reserva.getFechasalida()%>" class="form-control" name="fechasalida" required>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <button  type="submit" class="btn btn-primary pull-right"><span class="fa fa-save"></span> Guardar</button>
                                            </div>
                                            <div class="col-sm-3">
                                                <button id="limpiar" name="limpiar" type="reset" type="reset" class="btn btn-warning"><span class="fa fa-dedent"></span> Limpiar</button>
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
                                    <h3 class="box-title">Listado de Reservas</h3>
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
                                                <th>Empleado</th>
                                                <th>Acciones</th>
                                                <th>Mensaje</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Reserva> lstreserva = (List<Reserva>) request.getAttribute("listareservas");
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
                                                <td><%= r.getEmpleado().getNombres() + " " + r.getEmpleado().getApellidos()%></td>
                                                <td>
                                                    <%if (r.getEstado().equals("Pagada")) {%>
                                                    <button onclick=" swal('Error', 'Esta reserva ha sido Pagada!', 'error');"  class="btn btn-danger"><span class="fa fa-edit"></span></button>
                                                        <%} else if (r.getEstado().equals("Cancelada")) {%>
                                                    <button onclick=" swal('Error', 'Esta reserva ha sido Cancelada!', 'error');"  class="btn btn-danger"><span class="fa fa-edit"></span></button>

                                                    <%} else {%>
                                                    <a  href="ModificarReservas.do?idreserva=<%= r.getIdreserva()%>" class="btn btn-success"><span class="fa fa-edit"></span></a>
                                                        <%}%>
                                                        <%if (ne.buscaridreservaconsumo(r.getIdreserva()) != null || ne.buscaridreservapago(r.getIdreserva()) != null) {%>
                                                    <button id="alert" onclick=" swal('Error', 'Este registro no se puede eliminar!', 'error');" class="btn btn-danger btnBorrar"><span class="fa fa-remove"></span></button>
                                                        <%} else {%>
                                                    <a  href="BorrarReservas.do?idreserva=<%= r.getIdreserva()%>" class="btn btn-danger"><span class="fa fa-trash"></span></a>
                                                        <%}%>
                                                </td>
                                                <td>

                                                    <%if (ne.buscaridreservaconsumo(r.getIdreserva()) != null || ne.buscaridreservapago(r.getIdreserva()) != null) {%>
                                                    <span class="badge badge-pill badge-noeliminar">No Eliminable</span>
                                                    <%} else {%>
                                                    <span class="badge badge-pill badge-eliminar">Eliminable</span>
                                                    <%}%>

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

                                                        window.onload = function () {
                                                            var fecha = new Date(); //Fecha actual
                                                            var mes = fecha.getMonth() + 1; //obteniendo mes
                                                            var dia = fecha.getDate(); //obteniendo dia
                                                            var ano = fecha.getFullYear(); //obteniendo año
                                                            if (dia < 10)
                                                                dia = '0' + dia; //agrega cero si el menor de 10
                                                            if (mes < 10)
                                                                mes = '0' + mes; //agrega cero si el menor de 10
                                                            document.getElementById('fechaActual').value = ano + "-" + mes + "-" + dia;
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