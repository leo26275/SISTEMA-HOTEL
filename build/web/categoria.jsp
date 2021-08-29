<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="Adicionales.NoEliminacion"%>
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
        
        <link href="resources/bootstrapvalidator/dist/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/bootstrapvalidator/src/css/bootstrapValidator.css" rel="stylesheet" type="text/css"/>
        
        <link href="resources/tablas/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            NoEliminacion ne=new NoEliminacion();
            
            Categoria categorias = (Categoria) request.getAttribute("categoria");
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
                                    <%if (categorias != null) {%> 
                                    <h3>Editar Categorias</h3>
                                    <%} else {%> 
                                    <h3>Registro de Categorias</h3>
                                    <%}%>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <form id="form-categoria" <%if (categorias != null) {%> 
                                      action="EditarCategorias.do"
                                      <%} else {%> 
                                      action="AgregarCategorias.do"
                                      <%}%> method="GET" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Nombre Categoria</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" <%if (categorias != null) {%>  value="<%=categorias.getNombre()%>"<%}%>  name="nombre" required>
                                                <!--variable para jugar-->
                                                <input type="text" class="form-control" <%if (categorias != null) {%>  value="<%=categorias.getNombre()%>"<%}%>  name="jugar"  style="display: none;">
                                                <input type="text" <%if (categorias != null) {%>  value="<%= categorias.getIdcategoria()%>"<%}%> name="id" style="display: none;" />
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
                                                <td><%= c.getNombre()%></td>
                                                <td>
                                                    
                                                    <a href="ModificarCategorias.do?idcategoria=<%= c.getIdcategoria()%>" name="editar" value="" class="btn btn-success"><span class="fa fa-edit"></span></a>
                                                    <%if(ne.buscaridcategoriaproducto(c.getIdcategoria())==null){%>
                                                    <a href="BorrarCategorias.do?idcategoria=<%= c.getIdcategoria()%>"  name="borrar" value="" class="btn btn-danger" id="btn-eliminar"><span class="fa fa-trash"></span></a>
                                                    <%}else{%>
                                                    <button name="borrar" onclick=" swal('Error', 'Este registro no se puede eliminar!', 'error');" class="btn btn-danger" id="btn-eliminar"><span class="fa fa-remove"></span></button>
                                                    <%}%>
                                                </td>
                                                <td>
                                                    
                                                    <%if(ne.buscaridcategoriaproducto(c.getIdcategoria())==null){%>
                                                    <span class="badge badge-pill badge-eliminar">Eliminable</span>
                                                    <%}else{%>
                                                    <span class="badge badge-pill badge-noeliminar">No Eliminable</span>
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
        <script src="resources/dist/js/myajax.js" type="text/javascript"></script>
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <script src="resources/bootstrapvalidator/dist/js/bootstrapValidator.min.js" type="text/javascript"></script>
        
        <script src="resources/sweetalert-master/docs/assets/sweetalert/sweetalert.min.js" type="text/javascript"></script>
        
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