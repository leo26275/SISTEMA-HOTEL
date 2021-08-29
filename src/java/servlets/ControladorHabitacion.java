/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Adicionales.IdGenerado;
import Adicionales.NoRepeticion;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoHabitacion;
import modelo.entidad.Habitacion;

/**
 *
 * @author leo_g
 */
public class ControladorHabitacion extends HttpServlet {

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
            NoRepeticion nr = new NoRepeticion();
            
            if (pagina.equals("/MostrarHabitaciones.do")) {
                List<Habitacion> listahabitaciones = new ArrayList<>();
                DaoHabitacion daohabitaciones = new DaoHabitacion();
                listahabitaciones = daohabitaciones.ObtenerlistaDeHabitaciones();
                request.setAttribute("listahabitaciones", listahabitaciones);
                despachador = request.getRequestDispatcher("habitacion.jsp");
            } else if (pagina.equals("/AgregarHabitaciones.do")) {
                IdGenerado idhabitacion = new IdGenerado();
                String numero = String.valueOf(request.getParameter("numero"));
                String piso = String.valueOf(request.getParameter("piso"));
                String caracteristica = request.getParameter("caracteristica");
                String descripcion = request.getParameter("descripcion");
                String estado = request.getParameter("estado");
                String tipohabitacion = request.getParameter("tipohabitacion");
                BigDecimal preciodiario = BigDecimal.valueOf(Double.parseDouble(request.getParameter("preciodiaro")));
                
                if (nr.buscarnumerohabitacion(numero) == null) {
                    if (Integer.parseInt(numero) > 0 && Integer.parseInt(piso) > 0 && !caracteristica.isEmpty() && !descripcion.isEmpty()
                            && !estado.isEmpty() && !tipohabitacion.isEmpty() && Double.parseDouble(String.valueOf(preciodiario)) > 0
                            && !tipohabitacion.equals("Seleccione") && !estado.equals("Seleccione")) {
                        Habitacion habitacion = new Habitacion(idhabitacion.autoincrementablehabitacion(), numero, piso, descripcion, caracteristica, preciodiario, estado, tipohabitacion);
                        DaoHabitacion daohabitacion = new DaoHabitacion(habitacion);
                        daohabitacion.guardarHabitacion();
                        despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                }
                
            } else if (pagina.equals("/BorrarHabitaciones.do")) {
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                
                if (idhabitacion > 0) {
                    Habitacion habitacion = new Habitacion(idhabitacion);
                    DaoHabitacion daohabitacion = new DaoHabitacion(habitacion);
                    daohabitacion.eliminarHabitacion(habitacion);
                    despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                    
                } else {
                    despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                }
                
            } else if (pagina.equals("/ModificarHabitaciones.do")) {
                Habitacion habitacion = new Habitacion();
                habitacion.setIdhabitacion(Integer.parseInt(request.getParameter("idhabitacion")));
                DaoHabitacion daohabitacion = new DaoHabitacion(habitacion.getIdhabitacion());
                habitacion = daohabitacion.obtenerHabitacion();
                request.setAttribute("habitacion", habitacion);
                
                despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                
            } else if (pagina.equals("/EditarHabitaciones.do")) {
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                String numero = String.valueOf(request.getParameter("numero"));
                String piso = String.valueOf(request.getParameter("piso"));
                String caracteristica = request.getParameter("caracteristica");
                String descripcion = request.getParameter("descripcion");
                String estado = request.getParameter("estado");
                String tipohabitacion = request.getParameter("tipohabitacion");
                BigDecimal preciodiario = BigDecimal.valueOf(Double.parseDouble(request.getParameter("preciodiaros")));

                /*Variable para jugar uu*/
                String jugar = request.getParameter("jugar");
                
                if (nr.buscarnumerohabitacion(numero) == null) {
                    if (idhabitacion > 0 && Integer.parseInt(numero) > 0 && Integer.parseInt(piso) > 0 && !caracteristica.isEmpty()
                            && !descripcion.isEmpty() && !estado.isEmpty() && !tipohabitacion.isEmpty()
                            && Double.parseDouble(String.valueOf(preciodiario)) > 0 && !tipohabitacion.equals("Seleccione")
                            && !estado.equals("Seleccione")) {
                        
                        Habitacion habitacion = new Habitacion(idhabitacion, numero, piso, descripcion, caracteristica, preciodiario, estado, tipohabitacion);
                        DaoHabitacion daohabitacion = new DaoHabitacion(habitacion);
                        daohabitacion.actualizarHabitacion(habitacion);
                        despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                        
                    } else {
                        despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                    }
                } else {
                    if (!numero.equals(jugar) && nr.buscarnumerohabitacion(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                    } else {
                        if (idhabitacion > 0 && Integer.parseInt(numero) > 0 && Integer.parseInt(piso) > 0 && !caracteristica.isEmpty()
                                && !descripcion.isEmpty() && !estado.isEmpty() && !tipohabitacion.isEmpty()
                                && Double.parseDouble(String.valueOf(preciodiario)) > 0 && !tipohabitacion.equals("Seleccione")
                                && !estado.equals("Seleccione")) {
                            
                            Habitacion habitacion = new Habitacion(idhabitacion, numero, piso, descripcion, caracteristica, preciodiario, estado, tipohabitacion);
                            DaoHabitacion daohabitacion = new DaoHabitacion(habitacion);
                            daohabitacion.actualizarHabitacion(habitacion);
                            despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                            
                        } else {
                            despachador = request.getRequestDispatcher("MostrarHabitaciones.do");
                        }
                    }
                }
                
            } else if (pagina.equals("/MostrarHabitacionesDisponibles.do")) {
                /*Cargando listado de habitaciones disponibles*/
                List<Habitacion> listahabitaciones = new ArrayList<>();
                DaoHabitacion daohabitaciones = new DaoHabitacion();
                listahabitaciones = daohabitaciones.ObtenerlistaDeHabitacionesDisponibles();
                request.setAttribute("listahabitaciones", listahabitaciones);

                /*Cargando listado de habitaciones en mantenimiento para la modal*/
                List<Habitacion> listamantenimiento = new ArrayList<>();
                DaoHabitacion daohabitacionesm = new DaoHabitacion();
                listamantenimiento = daohabitacionesm.ObtenerlistaDeHabitacionesMantenimiento();
                request.setAttribute("listamantenimiento", listamantenimiento);
                
                despachador = request.getRequestDispatcher("habitacionesmantenimiento.jsp");
            } else if (pagina.equals("/AbilitarAbitaciones.do")) {
                
                String habitacion = request.getParameter("habitacion");
                int idhabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
                if (!habitacion.isEmpty() && idhabitacion > 0) {
                    DaoHabitacion daohabi = new DaoHabitacion();
                    daohabi.setearestadohabitacionpago(idhabitacion);
                    despachador = request.getRequestDispatcher("MostrarHabitacionesDisponibles.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarHabitacionesDisponibles.do");
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
