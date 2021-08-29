<%-- 
    Document   : menuencabezado
    Created on : 14/04/2019, 04:12:34 PM
    Author     : Sony
--%>
<%@page import="modelo.dao.DaoHabitacion"%>
<%@page import="modelo.dao.DaoReserva"%>
<%
DaoReserva dr=new DaoReserva();
DaoHabitacion dh=new DaoHabitacion();
%>
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
        <header class="my-header">
            <nav class="container navbar navbar-static-top">
                <div class="navbar-header">

                    <div class="my-logo">
                        <span><b>Hotel</b> Notre Dame</span>
                    </div>

                    <div class="my-div-right "  >
                        <div class="navbar-collapse navbar-collapse-toolbar collapse"  id="barra-menu">
                            <ul class="nav navbar-nav my-right-ul">
                                <li class="dropdown user-menu">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        
                                       <span class="hidden-xs">.</span>
                                       <img src="resources/dist/logo.jpg" class="user-image"/>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li class="my-user-header">
                                            <img src="resources/dist/logo.jpg" class="img-circle" alt="User Image"/>
                                            <p><%out.println(session.getAttribute("nomuser"));%><br>
                                                <strong><small><%out.println(session.getAttribute("tipo"));%></small></strong>
                                            </p>
                                        </li>

                                        <li class="my-user-footer">
                                            <div class="pull-left">
                                                <a href="#" class="btn btn-default"> <i class="fa fa-user"></i> Perfil</a>
                                            </div>
                                            <form action="ControladorSesionSalir" method="post">
                                            <div class="pull-right">
                                                <button name="salir" type="submit" class="btn btn-default"> <i class="fa fa-power-off"></i> Salir</button>
                                            </div>
                                            </form> 
                                        </li>
                                    </ul>                                    
                                </li>                     
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <div class="page-wrapper chiller-theme toggled">
            <!--<a id="show-sidebar" class="btn btn-sm btn-block" href="#">
                <i class="fa fa-android"></i>
            </a>-->
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content">
                    <!--<div class="sidebar-brand">
                        <a href="#"></a>
                        <div id="close-sidebar">
                            <i class="fa fa-close"></i>
                        </div>
                    </div>-->
                    <div class="sidebar-header">
                        <div class="user-pic">
                            <img class="img-responsive img-rounded" src="resources/dist/logo.jpg"
                                 alt="User picture">
                        </div>
                        <div class="user-info">
                            <span class="user-name"><%out.println(session.getAttribute("user"));%></span>
                            <span class="user-role"><%out.println(session.getAttribute("tipo"));%></span>
                            <span class="user-status">
                                <i class="fa fa-circle"></i>
                                <span>Conectado</span>
                            </span>
                        </div>
                    </div>
                    <!-- sidebar-header  -->
                    <div class="sidebar-menu">
                        <ul>
                            <li class="header-menu">
                                <span>General</span>
                            </li>
                            <li class="sidebar-dropdown">
                                    <a href="index.jsp">
                                    <i class="glyphicon glyphicon-home"></i>
                                    <span>Inicio</span>
                                    <span class="badge badge-nuevasreserva badge-nuevasreserva"><%= dr.reservasdia()  %></span>
                                    <span class="badge badge-nopagadas badge-nopagadas"><%= dr.reservasnopagadas()%></span>
                                </a>
                            </li>
                            
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-user-times"></i>
                                    <span>Clientes</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                       
                                        <li>
                                            <a href="MostrarClientes.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-hotel"></i>
                                    <span>Habitaciones</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarHabitaciones.do"> <i class="fa fa-circle-o"></i>Nueva Registro</a>
                                        </li>
                                        <li>
                                            <a href="MostrarVistaHabitaciones.do"><i class="fa fa-circle-o"></i>Habitaciones</a>
                                        </li>
                                        <li>
                                            <a href="MostrarHabitacionesDisponibles.do" style="text-align: center;"><i class="fa fa-circle-o"></i>Habilitar Habitaciones en Mantenimiento</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reservas</span>
                                    <span class="badge badge-pill badge-nuevasreserva"><%= dr.reservasdia() %></span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                             
                                            <a href="MostrarReservas.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                        <li>
                                             
                                            <a href="MostrarReservasCanceladas.do"><i class="fa fa-circle-o"></i>Cancelar Reserva</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-product-hunt"></i>
                                    <span>Productos</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarProductos.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                        <li>
                                            <a href="MostrarCategoria.do"><i class="fa fa-circle-o"></i>Categorias</a>
                                        </li>
                                        <li>
                                            <a href="MostrarConsumo.do"><i class="fa fa-circle-o"></i>Consumos</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-user-plus"></i>
                                    <span>Empleados</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarEmpleados.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                        <li>
                                            <a href="MostrarCargos.do"><i class="fa fa-circle-o"></i>Cargos</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="header-menu">
                                <span>Transacciones</span>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-user-times"></i>
                                    <span>Pagos</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarPago.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-user-plus"></i>
                                    <span>Usuarios</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarUsuarios.do"><i class="fa fa-circle-o"></i>Nuevo Registro</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="header-menu">
                                <span>Informes</span>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-edit"></i>
                                    <span>Reportes</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="vistareportes.jsp"><i class="fa fa-circle-o"></i>Reportes de Usuarios</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="header-menu">
                                <span>Información</span>
                            </li>
                            
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-info"></i>
                                    <span>Consultas</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="vistaconsultas.jsp"> <i class="fa fa-circle-o"></i>Ver Consultas</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-database"></i>
                                    <span>Back Up</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a href="MostrarPagina.do"><i class="fa fa-circle-o"></i>Crear Respaldo</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="#">
                                    <i class="fa fa-question-circle"></i>
                                    <span>Ayuda</span>
                                </a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li>
                                            <a  type="application/pdf" href="Reportes/Manual Hotel Notre Dame.pdf" target="target"><i class="fa fa-circle-o"></i>Manual de Usuario</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="acercade.jsp">
                                    <i class="fa fa-comment"></i>
                                    <span>Acerca de</span>
                                </a>
                            </li>
                            
                        </ul>
                    </div>
                    <!-- sidebar-menu  -->
                </div>
                <!-- sidebar-content  -->
            </nav>
            <!-- sidebar-wrapper  -->
            
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
