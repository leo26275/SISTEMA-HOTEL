<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="modelo.entidad.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="modelo.entidad.Usuarios"%>
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
        <title>Registro de Usuarios</title>
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
            Usuarios usuarios = (Usuarios) request.getAttribute("usuarios");
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
                                    <h3>Registro de Usuarios</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-us" <%if (usuarios != null) {%> 
                                      action="EditarUsuarios.do"
                                      <%} else {%> 
                                      action="AgregarUsuarios.do"
                                      <%}%> method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Usuario</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" <%if (usuarios != null) {%>  value="<%= usuarios.getUsuario()%>"<%}%> name="usuario" required>
                                                <!--variable para jugar 1-->
                                                <input type="text" class="form-control" <%if (usuarios != null) {%>  value="<%= usuarios.getUsuario()%>"<%}%> name="jugar1" style="display: none;">
                                                <input type="text" <%if (usuarios != null) {%>  value="<%= usuarios.getIdusuario()%>"<%}%> name="idusuario" style="display: none;" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Contraseña</label>
                                            <div class="col-sm-6">
                                                <input type="password" class="form-control" name="pass" placeholder="Minimo se requieren 8 caracteres">
                                                <!--variable para jugar-->
                                                <input type="text" <%if (usuarios != null) {%>  value="<%= usuarios.getPassword()%>"<%}%> class="form-control" name="jugar3" style="display: none;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Empleado</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="idempleado" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <%
                                                        List<Empleado> lstempleado = (List<Empleado>) request.getAttribute("listaempleados");
                                                        for (Empleado e : lstempleado) {
                                                            if (usuarios != null) {
                                                                if (e.getIdempleado() == usuarios.getEmpleado().getIdempleado()) {
                                                    %>
                                                    <option selected="selected" value="<%= e.getIdempleado()%>"><%= e.getNombres() + " " + e.getApellidos()%></option>
                                                    <%} else {%>
                                                    <option value="<%= e.getIdempleado()%>"><%= e.getNombres() + " " + e.getApellidos()%></option>
                                                    <%}%>
                                                    <%} else {%>
                                                    <option value="<%= e.getIdempleado()%>"><%= e.getNombres() + " " + e.getApellidos()%></option>
                                                    <%}%>
                                                    <%}%>
                                                    <input type="text" class="form-control" <%if (usuarios != null) {%>  value="<%= usuarios.getEmpleado().getIdempleado()%>"<%}%> name="jugar2" style="display: none;">
                                                </select>
                                            </div>
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
                                    <h3 class="box-title">Listado de Usuarios</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Empleado</th>
                                                <th>Usuario</th>
                                                <th>Contraseña</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Usuarios> listausuarios = (List<Usuarios>) request.getAttribute("listausuarios");
                                                for (Usuarios usuario : listausuarios) {
                                            %>
                                            <tr>
                                                <td><%= usuario.getEmpleado().getNombres() + " " + usuario.getEmpleado().getApellidos()%></td>
                                                <td><%= usuario.getUsuario()%></td>
                                                <td><%= usuario.getPassword()%></td>
                                                <td>
                                                    <a name="editar" href="ModificarUsuarios.do?idusuario=<%= usuario.getIdusuario()%>" class="btn btn-success"><span class="fa fa-edit"></span></a>
                                                    <a name="borrar" href="BorrarUsuarios.do?idusuario=<%= usuario.getIdusuario()%>" class="btn btn-danger"><span class="fa fa-trash"></span></a>
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
            location.href = "Login.jsp";
        }
    }</script> 