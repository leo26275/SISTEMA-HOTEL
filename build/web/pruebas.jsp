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
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-empresa" method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Nombre Categoria</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control"  name="nombre" required>

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <button id="submit" name="guardar" type="submit" onclick="recibir();" class="btn btn-primary pull-right"><span class="fa fa-save"></span> Guardar</button>
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
                                    <h3 class="box-title">Listado de Categorías</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <div class="box-body">

                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Categoria</th>
                                                <th>Acciones</th>
                                                <th>Mensaje</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Categoria> lstCategoria = (List<Categoria>) request.getAttribute("listaDeCategorias");

                                                for (Categoria c : lstCategoria) {
                                            %>
                                            <tr>
                                                <td><span id="nombre=<%= c.getNombre()%>"><%= c.getNombre()%></span></td>
                                                <td>
                                                    <div class="col-sm-3" >
                                                        <button style="display: block" type="button" onclick="editar_form();" class="btn btn-success" data-toggle="modal">
                                                            <span class="fa fa-plus"></span>
                                                        </button>
                                                    </div>

                                                </td>
                                                <td>
                                                    <span class="badge badge-pill badge-warning">Eliminable</span>
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

                <script>
                    function recibir()
                    {
                        var valor = document.getElementById("#nombre").value;
                        document.getElementById("codigo").value = valor;

                    }

                    function editar_form() {
                        $('#modal_edit').modal({
                            show: 'false'
                                    var first = ('#nombre' + id).text();
                        });
                    }
                </script>
                <div class="modal fade" id="modal_edit">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Edicion de Clientes</h4>
                            </div>
                            <form id="form-aviones-modal" action="ControladorVuelo" method="post" class="form-horizontal">
                                <div class="box-body">
                                    <div class="form-group">
                                        <label for="nombre" class="col-sm-3 control-label">Nombre</label>
                                        <div class="col-sm-6">
                                            <input  type="text" class="form-control" name="codigo" id="nombre"  required>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <button name="btnavion" type="submit" class="btn btn-success"><span class="fa fa-save"></span>  Guardar  </button>
                                        </div>
                                        <div class="col-sm-2">
                                            <button type="reset" class="btn btn-warning" data-dismiss="modal"><span class="fa fa-dedent"></span>  Cancelar  </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>

            </div>
        </main>
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/dist/js/myajax.js" type="text/javascript"></script>
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
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