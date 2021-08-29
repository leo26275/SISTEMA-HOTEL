<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="Adicionales.NoEliminacion"%>
<%@page import="modelo.entidad.Habitacion"%>
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
        <title>Registro de Habitaciones</title>
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
            Habitacion habitacion = (Habitacion) request.getAttribute("habitacion");
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
                                    <%if (habitacion != null) {%> 
                                    <h3>Modificar Registro de Habitaciones</h3>
                                    <%} else {%> 
                                    <h3>Registro de Habitaciones</h3>
                                    <%}%>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-habitacion" <%if (habitacion != null) {%> 
                                      action="EditarHabitaciones.do"
                                      <%} else {%> 
                                      action="AgregarHabitaciones.do"
                                      <%}%> method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Numero de la Habitación</label>
                                            <div class="col-sm-6">
                                                <input type="number" <%if (habitacion != null) {%>  value="<%= habitacion.getNumero()%>"<%}%> class="form-control" name="numero" required>
                                                <!--variable para jugar-->
                                                <input type="number" <%if (habitacion != null) {%>  value="<%= habitacion.getNumero()%>"<%}%> class="form-control" name="jugar" style="display: none;">
                                                <input type="text" <%if (habitacion != null) {%>  value="<%= habitacion.getIdhabitacion()%>"<%}%> name="idhabitacion" style="display: none;" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Piso</label>
                                            <div class="col-sm-6">
                                                <input type="number" <%if (habitacion != null) {%>  value="<%= habitacion.getPiso()%>"<%}%> class="form-control" name="piso" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Caracteristicas</label>
                                            <div class="col-sm-6">
                                                <textarea name="caracteristica" required><%if (habitacion != null) {%><%= habitacion.getCaracteristicas()%><%} else {%> <%}%></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Descripción</label>
                                            <div class="col-sm-6">
                                                <textarea name="descripcion" required><%if (habitacion != null) {%><%= habitacion.getDescripcion()%><%} else {%> <%}%></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Tipo de Habitacion</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="tipohabitacion" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%if (habitacion == null) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else {%>

                                                    <%if (habitacion.getTipohabitacion().equals("Matrimonial")) {%>
                                                    <option selected="selected" value="<%=habitacion.getTipohabitacion()%>"><%=habitacion.getTipohabitacion()%></option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Presidencial")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Familiar")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Sencilla")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Lujo")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Economica")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Doble">Doble</option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Doble")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <option value="Individual">Individual</option>
                                                    <%} else if (habitacion.getTipohabitacion().equals("Individual")) {%>
                                                    <option value="Matrimonial">Matrimonial</option>
                                                    <option value="Presidencial">Presidencial</option>
                                                    <option value="Familiar">Familiar</option>
                                                    <option value="Sencilla">Sencilla</option>
                                                    <option value="Lujo">Lujo</option>
                                                    <option value="Economica">Economica</option>
                                                    <option value="Doble">Doble</option>
                                                    <option selected="selected" value="<%= habitacion.getTipohabitacion()%>"><%= habitacion.getTipohabitacion()%></option>
                                                    <%}
                                                        }%>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Precio Diario</label>
                                            <div class="col-sm-6">
                                                <%if(habitacion!=null){%>
                                                <input type="text" readonly="readonly" value="<%= habitacion.getPreciodiario()%>" class="form-control" name="preciodiaros">
                                                <%}else{%>
                                                <input type="text" class="form-control" name="preciodiaro" required>
                                                <%}%>
                                                
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Estado</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="estado" required>
                                                    <%if (habitacion == null) {%>
                                                    <option value=" " disabled="disable" >Seleccione</option>
                                                    <option selected="selected" value="Disponible">Disponible</option>
                                                    <option value="Ocupada" disabled="disabled">Ocupada</option>
                                                    <option value="Mantenimiento" disabled="disabled">Mantenimiento</option>
                                                    <%} else {%>
                                                    <% if (habitacion.getEstado().equals("Disponible")) {%>
                                                    <option selected="selected" value="<%= habitacion.getEstado()%>"><%= habitacion.getEstado()%></option>
                                                    <option value="Ocupada" disabled="disabled">Ocupada</option>
                                                    <option value="Mantenimiento" disabled="disabled">Mantenimiento</option>
                                                    <%} else if (habitacion.getEstado().equals("Ocupada")) {%>
                                                    <option value="Disponible" disabled="disabled">Disponible</option>
                                                    <option selected="selected"  value="<%= habitacion.getEstado()%>"><%= habitacion.getEstado()%></option>
                                                    <option value="Mantenimiento" disabled="disabled">Mantenimiento</option>
                                                    <%} else if (habitacion.getEstado().equals("Mantenimiento")) {%>
                                                    <option value="Disponible" disabled="disabled">Disponible</option>
                                                    <option value="Ocupada" disabled="disabled">Ocupada</option>
                                                    <option selected="selected" value="<%= habitacion.getEstado()%>"><%= habitacion.getEstado()%></option>
                                                    <%}%>
                                                    <% }%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <button id="guardar" name="guardar" type="submit" class="btn btn-primary pull-right"><span class="fa fa-save"></span> Guardar</button>
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
                                    <h3 class="box-title">Listado de Habitaciones</h3>
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
                                                <th>Acciones</th>
                                                <th>Mensaje</th>
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
                                                <td>
                                                    <a name="editar" href="ModificarHabitaciones.do?idhabitacion=<%= h.getIdhabitacion()%>" class="btn btn-success"><span class="fa fa-edit"></span></a>
                                                        <%if (ne.buscaridclienteidhabitacionreserva(0, h.getIdhabitacion(),0) != null) {%>
                                                    <button name="borrar" onclick=" swal('Error', 'Este registro no se puede eliminar!', 'error');" class="btn btn-danger" id="btn-eliminar"><span class="fa fa-remove"></span></button>
                                                        <%} else {%>
                                                    <a name="borrar" href="BorrarHabitaciones.do?idhabitacion=<%= h.getIdhabitacion()%>" class="btn btn-danger"><span class="fa fa-trash"></span></a>
                                                        <%}%>
                                                </td>
                                                <td>
                                                    <%if (ne.buscaridclienteidhabitacionreserva(0, h.getIdhabitacion(),0) != null) {%>
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