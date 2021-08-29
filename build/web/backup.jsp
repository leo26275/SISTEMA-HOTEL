<%-- 
    Document   : habitacion
    Created on : 14/04/2019, 05:50:16 PM
    Author     : Sony
--%>

<%@page import="Adicionales.NoEliminacion"%>
<%@page import="modelo.entidad.Cargos"%>
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
        <title>Exportar back up</title>
        <!--Componentes-->
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
        <% String tipo = String.valueOf(session.getAttribute("tipo"));
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
                                    <h3>Crear respaldo de datos</h3>
                                </div>
                                <hr>
                                <!-- /.box-header -->
                                <!-- form start -->
                                <div id="form-back-up" class="form-horizontal">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Versión del Gestor</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" id="idnumero" name="numero" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <option  value="9.1">9.1</option>
                                                    <option  value="9.2">9.2</option>
                                                    <option  value="9.3">9.3</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Puerto</label>
                                            <div class="col-sm-6">
                                                <select class="form-control" id="idpuerto" name="puerto" required>
                                                    <option selected="selected" value=" ">Seleccione</option>
                                                    <option value="5432">5432</option>
                                                    <option value="5434">5434</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Base de Datos</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="idnombre"  name="nombre" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Usuario</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="iduser" name="user" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Contraseña</label>
                                            <div class="col-sm-6">
                                                <input type="password" class="form-control" id="idcontra" name="contra" required>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                    <hr>
                                    <div class="box-footer">
                                        <div class="form-group">
                                            <div class="col-sm-6">
                                                <button  type="submit" class="btn btn-primary pull-right idguardar"><span class="fa fa-save"></span> Guardar</button>
                                            </div>
                                            <div class="col-sm-3">
                                                <button id="limpiar" type="reset" class="btn btn-warning"><span class="fa fa-dedent"></span> Cancelar</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.box-footer -->
                                </div>
                            </div>
                            <!-- /.box -->

                            <!-- Input addon -->
                        </div>
                        <!--/.col (left) -->
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

            $(document).ready(function () {
                $(document).on('click', '.idguardar', function () {
                    var numero = document.getElementById("idnumero").value;
                    var puerto = document.getElementById("idpuerto").value;
                    var nombre = document.getElementById("idnombre").value;
                    var user = document.getElementById("iduser").value;
                    var contra = document.getElementById("idcontra").value;
                    swal({
                        title: "Advertencia",
                        text: "Asegurese de haber creado una carpeta en el disco local C con el nombre BBD, para poder realizar el respaldo de los datos",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    $.ajax({
                                        url: "CrearRespaldo.do",
                                        type: "GET",
                                        data: {numero: numero, puerto: puerto, nombre: nombre, user: user, contra: contra},
                                        success: function (data) {
                                            //alert('El respaldo ha sido creado');
                                        }
                                    });
                                    swal("Respaldo de datos creaodo correctamente", {
                                        icon: "success",
                                    });
                                } else {
                                    swal("El respaldo de datos ha sido cancelado!", {
                                        icon: 'error',
                                    });
                                }
                            });



                    /*
                     var respuesta = confirm("Asegurese de haber creado una carpeta en el disco local C con el nombre BBD, para poder realizar el respaldo de los datos");
                     if (respuesta) {
                     $.ajax({
                     url: "CrearRespaldo.do",
                     type: "GET",
                     data: {numero: numero, puerto: puerto, nombre: nombre, user: user, contra: contra},
                     success: function (data) {
                     alert('El respaldo ha sido creado');
                     }
                     });
                     }*/
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