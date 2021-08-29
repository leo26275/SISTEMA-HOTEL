<%-- 
    Document   : index
    Created on : 14/04/2019, 06:20:36 AM
    Author     : Sony
--%>

<%@page import="modelo.dao.DaoReserva"%>
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
<html lang="es">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" src="sources/images/fo.png" />
        <title>Hotel Notre Dame</title>
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap/font-awesome/css/font-awesome.min.css">    
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,400,500" rel="stylesheet">
        <link href="resources/bootstrap/css/diseño.css" rel="stylesheet" type="text/css"/>

    </head>


    <body>
        <%
            DaoReserva daore = new DaoReserva();
            String nombreuser = String.valueOf(session.getAttribute("nomuser"));
            String tipo = String.valueOf(session.getAttribute("tipo"));
        %>

        <%if (tipo.equals("Ordenanza")) {%>
        <%@include file="menuencabezadoempleado.jsp" %>
        <%} else {%>
        <%@include file="menuencabezado.jsp" %>
        <%}%>


        <main class="page-content">
            <div class="container-fluid">
                <h2>Bienvenidos al <b>Hotel Notre Dame</b></h2>
            </div>
            <hr>
            <div class="row">
                <section>
                    <!-- Small boxes (Stat box) -->
                    <div class="row">
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-verdeaqua">
                                <div class="inner">
                                    <h3><%= daore.reservasdia()%></h3>

                                    <p>Nuevas Reservas</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-desktop"></i>
                                </div>
                                <a href="#" class="small-box-footer">Más Información <i class="fa fa-arrow-circle-right"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3><%= daore.ingresosdia()%></h3>

                                    <p>Ingresos Totales por Día</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="#" class="small-box-footer">Más Información <i class="fa fa-arrow-circle-right"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3><%=daore.reservasnopagadas()%></h3>

                                    <p>Habitaciones no Pagadas</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-hotel"></i>
                                </div>
                                <a href="#" class="small-box-footer">Más Información <i class="fa fa-arrow-circle-right"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-orange">
                                <div class="inner">
                                    <h3>1</h3>

                                    <p>Clientes del día</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-user-plus"></i>
                                </div>
                                <a href="#" class="small-box-footer">Más Información <i class="fa fa-arrow-circle-right"></i></a><!--se abrira otra ventana para mostrar los registros correspondiente-->
                            </div>
                        </div>
                        <!-- ./col -->
                    </div>
                    <!-- /.row -->
                    <!-- Main row -->

                </section>
                <div class="widget">
                    <div class="fecha">
                        <p id="diaSemana" class="diaSemana"></p>
                        <p id="dia" class="dia"></p>
                        <p>de</p>
                        <p id="mes" class="mes"></p>
                        <p>del</p>
                        <p id="anio" class="anio"></p>
                    </div>
                    <div class="reloj">
                        <p id="horas" class="horas"></p>
                        <p>:</p>
                        <p id="minutos" class="minutos"></p>
                        <p>:</p>
                        <div class="cajaSegundos">
                            <p id="ampm" class="ampm"></p>
                            <p id="segundos" class="segundos"></p>
                        </div>
                    </div>
                </div>
            </div>


        </main>
        <!-- page-content" -->
        <!--footer exportado-->
        <%@include file="footer.jsp" %>
        <!-- /#page-content-wrapper -->
        <script src="resources/jquery/jquery-3.4.0.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.min.js"></script>
        <script src="resources/dist/js/diseño.js" type="text/javascript"></script>
        <script src="resources/dist/js/reloj.js" type="text/javascript"></script>

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