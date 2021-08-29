/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Adicionales.ComparadorFechas;
import Adicionales.IdGenerado;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoCliente;
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoHabitacion;
import modelo.dao.DaoReserva;
import modelo.entidad.Clientes;
import modelo.entidad.Empleado;
import modelo.entidad.Habitacion;
import modelo.entidad.Reserva;

/**
 *
 * @author leo_g
 */
public class ControladorReserva extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            RequestDispatcher despachador = null;
            String pagina = request.getServletPath();
            ComparadorFechas comfe = new ComparadorFechas();/*COMPARA FECHAS*/
            SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");/*formateador de fechas*/

            if (pagina.equals("/MostrarReservas.do")) {
                /*Cargando la lista de reservas para la tabla*/
                List<Reserva> listareservas = new ArrayList<>();
                DaoReserva daoreserva = new DaoReserva();
                listareservas = daoreserva.ObtenerlistaDeReservas();
                request.setAttribute("listareservas", listareservas);

                /*Cargando listado de clientes*/
                List<Clientes> listadoclientes = new ArrayList<>();
                DaoCliente daocliente = new DaoCliente();
                listadoclientes = daocliente.ObtenerlistaDeClientes();
                request.setAttribute("listadoclientes", listadoclientes);
                /*Cargando listado de habitaciones disponibles*/
                List<Habitacion> listahabitaciones = new ArrayList<>();
                DaoHabitacion daohabitaciones = new DaoHabitacion();
                listahabitaciones = daohabitaciones.ObtenerlistaDeHabitacionesDisponibles();
                request.setAttribute("listahabitaciones", listahabitaciones);

                despachador = request.getRequestDispatcher("reserva.jsp");

            } else if (pagina.equals("/BorrarReservas.do")) {
                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                if (idreserva > 0) {

                    Reserva reserva = new Reserva(idreserva);
                    DaoReserva daoreserva = new DaoReserva(idreserva);
                    daoreserva.eliminarReserva(reserva);
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                }

            } else if (pagina.equals("/AgregarReservas.do")) {
                IdGenerado idreserva = new IdGenerado();

                /*obteniendo los datos de la vista reserva*/
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                int idcliente = Integer.parseInt(request.getParameter("idcliente"));
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));
                String tiporeserva = request.getParameter("tiporeserva");
                Date fechareserva = Date.valueOf(request.getParameter("fechareserva"));
                Date fechaingreso = Date.valueOf(request.getParameter("fechaingreso"));
                Date fechasalida = Date.valueOf(request.getParameter("fechasalida"));
                String estado = "No Pagada";
                /*Obteniendo los datos de la habitacion*/
                Clientes clientes = new Clientes();
                DaoCliente daocliente = new DaoCliente(idcliente);
                clientes = daocliente.obtenerCliente();
                /*obteniendo los datos de la habitacion*/
                Habitacion habitacion = new Habitacion();
                DaoHabitacion daohabitacion = new DaoHabitacion(idhabitacion);
                habitacion = daohabitacion.obtenerHabitacion();
                /*obteniendo los datos del empleado */
                Empleado empleado = new Empleado();
                DaoEmpleado daoempleado = new DaoEmpleado(idempleado);
                empleado = daoempleado.obtenerEmpleado();

                /*VALIDANDO EL REGISTRO DE LA FECHAS INGRESADAS PARA LA RESERVA*/
                String fecha1 = format.format(fechareserva);
                String fecha2 = format.format(fechaingreso);
                String fecha3 = format.format(fechasalida);
                /*variables enteras de comprobacion de las fechas ingresadas*/
 /*esta variable indicara que la fecha de reserva sea igual a la del sistema*/
                int f1;
                /*la fecha de ingreso puede ser igual o mayor a la de la reserva, retornara 1 o 0 si se cumple*/
                int fa = comfe.comparefechasconDate(fecha2, fecha1);
                out.print(fa);
                /*la fecha de salida debe ser mayor a la de la fecha ingresada debe retornar 1*/
                int fb = comfe.comparefechasconDate(fecha3, fecha2);
                out.print(fb);

                /*
                En caso de que no se cumplan las restriciones dadas el nuevo registro a incorporar no se agregara
                 */
                if (fa >= 0 && fb == 1 && clientes != null && empleado != null && habitacion != null && !tiporeserva.isEmpty() && !tiporeserva.equals("Seleccione")
                        && fechareserva != null && fechaingreso != null && fechasalida != null && !estado.isEmpty()) {
                    /*guardando los datos correspondientes*/
                    Reserva reserva = new Reserva(idreserva.autoincrementablereservas(), clientes, empleado, habitacion, tiporeserva, fechareserva, fechaingreso, fechasalida, estado);
                    DaoReserva daoreserva = new DaoReserva(reserva);
                    daoreserva.guardarReserva();

                    /*mandando a setear los datos del estado de la habitacion donde se le este indicando*/
                    daohabitacion.setearestadohabitacion(habitacion.getIdhabitacion());
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                }

            } else if (pagina.equals("/ModificarReservas.do")) {
                Reserva reserva = new Reserva();
                reserva.setIdreserva(Integer.parseInt(request.getParameter("idreserva")));

                /*Cargando listado de clientes*/
                DaoCliente daocliente = new DaoCliente();
                List<Clientes> listadoclientes = daocliente.ObtenerlistaDeClientes();
                request.setAttribute("listadoclientes", listadoclientes);
                /*Cargando listado de habitaciones disponibles*/
                DaoHabitacion daohabitaciones = new DaoHabitacion();
                List<Habitacion> listahabitaciones = daohabitaciones.ObtenerlistaDeHabitacionesDisponibles();
                request.setAttribute("listahabitaciones", listahabitaciones);

                DaoReserva daoreserva = new DaoReserva(reserva.getIdreserva());
                reserva = daoreserva.obtenerReserva();
                request.setAttribute("reserva", reserva);
                despachador = request.getRequestDispatcher("MostrarReservas.do");
            } else if (pagina.equals("/EditarReservas.do")) {
                /*obteniendo los datos de la vista reserva*/
                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                int idcliente = Integer.parseInt(request.getParameter("idcliente"));
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));
                String tiporeserva = request.getParameter("tiporeserva");
                Date fechareserva = Date.valueOf(request.getParameter("fechareservas"));
                Date fechaingreso = Date.valueOf(request.getParameter("fechaingreso"));
                Date fechasalida = Date.valueOf(request.getParameter("fechasalida"));
                String estado = "No Pagada";
                /*Obteniendo los datos de la habitacion*/
                Clientes clientes = new Clientes();
                DaoCliente daocliente = new DaoCliente(idcliente);
                clientes = daocliente.obtenerCliente();
                /*obteniendo los datos de la habitacion*/
                Habitacion habitacion = new Habitacion();
                DaoHabitacion daohabitacion = new DaoHabitacion(idhabitacion);
                habitacion = daohabitacion.obtenerHabitacion();
                /*obteniendo los datos del empleado */
                Empleado empleado = new Empleado();
                DaoEmpleado daoempleado = new DaoEmpleado(idempleado);
                empleado = daoempleado.obtenerEmpleado();

                /*VALIDANDO EL REGISTRO DE LA FECHAS INGRESADAS PARA LA RESERVA*/
                String fecha1 = format.format(fechareserva);
                String fecha2 = format.format(fechaingreso);
                String fecha3 = format.format(fechasalida);
                /*variables enteras de comprobacion de las fechas ingresadas*/
 /*esta variable indicara que la fecha de reserva sea igual a la del sistema*/
                int f1;
                /*la fecha de ingreso puede ser igual o mayor a la de la reserva, retornara 1 o 0 si se cumple*/
                int fa = comfe.comparefechasconDate(fecha2, fecha1);
                out.print(fa);
                /*la fecha de salida debe ser mayor a la de la fecha ingresada debe retornar 1*/
                int fb = comfe.comparefechasconDate(fecha3, fecha2);
                out.print(fb);

                /*en caso de que no se cumplan las restriciones dadas el registro seleccionado para editar no se modificara*/
                if (fa >= 0 && fb == 1 && idreserva > 0 && clientes != null && empleado != null && habitacion != null && !tiporeserva.isEmpty() && !tiporeserva.equals("Seleccione")
                        && fechareserva != null && fechaingreso != null && fechasalida != null && !estado.isEmpty()) {
                    /*guardando los datos correspondientes*/
                    Reserva reserva = new Reserva(idreserva, clientes, empleado, habitacion, tiporeserva, fechareserva, fechaingreso, fechasalida, estado);
                    DaoReserva daoreserva = new DaoReserva(reserva);
                    daoreserva.actualizarReserva(reserva);
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarReservas.do");
                }
            } else if (pagina.equals("/MostrarReservasCanceladas.do")) {
                /*Cargando la lista de reservas para la tabla*/
                List<Reserva> listareservasactualizar = new ArrayList<>();
                DaoReserva daoreserva = new DaoReserva();
                listareservasactualizar = daoreserva.ObtenerlistaDeReservasCanceladas();
                request.setAttribute("listareservasactualizar", listareservasactualizar);

                /*cargando los datos del modal*/
                List<Reserva> listareservascombo = new ArrayList<>();
                DaoReserva daoreservacombo = new DaoReserva();
                listareservascombo = daoreservacombo.listacomboreservas();
                request.setAttribute("listareservascombo", listareservascombo);

                despachador = request.getRequestDispatcher("actualizarreserva.jsp");
            } else if (pagina.equals("/CambiarEstadoCancelada.do")) {

                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                String estado = request.getParameter("estado");
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                DaoReserva daoreserva = new DaoReserva();
                DaoHabitacion daohabitacion=new DaoHabitacion();

                if (!estado.isEmpty() && idreserva > 0 && idhabitacion>0) {
                    daoreserva.setearestadocancelarreserva(idreserva, estado);
                    daohabitacion.setearestadohabitacionpago(idhabitacion);
                    despachador = request.getRequestDispatcher("MostrarReservasCanceladas.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarReservasCanceladas.do");
                }

            }
            despachador.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
