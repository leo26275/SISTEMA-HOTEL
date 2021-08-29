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
import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoHabitacion;
import modelo.dao.DaoPago;
import modelo.dao.DaoReserva;
import modelo.entidad.Pago;
import modelo.entidad.Reserva;

/**
 *
 * @author leo_g
 */
public class ControladorPago extends HttpServlet {

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
            ComparadorFechas comfe=new ComparadorFechas();/*COMPARA FECHAS*/
            SimpleDateFormat format=new SimpleDateFormat("dd/MM/yyyy");/*formateador de fechas*/
            
            if (pagina.equals("/MostrarPago.do")) {

                /*cargando la lista con las reservas no pagadas*/
                List<Reserva> listareserva = new ArrayList<>();
                DaoReserva daoreserva = new DaoReserva();
                listareserva = daoreserva.listacomboreservas();
                request.setAttribute("listareserva", listareserva);

                /*Cargando los resultados a la tabla*/
                List<Pago> listapagos = new ArrayList<>();
                DaoPago daopago = new DaoPago();
                listapagos = daopago.ObtenerlistaDePago();
                request.setAttribute("listapagos", listapagos);
                
                despachador = request.getRequestDispatcher("pago.jsp");
            } else if (pagina.equals("/BorrarPago.do")) {
                int idpago = Integer.parseInt(request.getParameter("idpago"));
                
                if (idpago > 0) {
                    Pago pago = new Pago(idpago);
                    DaoPago daopago = new DaoPago();
                    daopago.eliminarPago(pago);
                    despachador = request.getRequestDispatcher("MostrarPago.do");
                    
                } else {
                    despachador = request.getRequestDispatcher("MostrarPago.do");
                }
                
            } else if (pagina.equals("/AgregarPago.do")) {
                IdGenerado idpago = new IdGenerado();
                DaoHabitacion daohabitacion=new DaoHabitacion();
                
                /*obteniendo los datos para ser ingresados*/
                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                String tipocomprobante = request.getParameter("tipocomprobante");
                String numerocomprobante = request.getParameter("numcomprobante");
                BigDecimal impuesto = BigDecimal.valueOf(Double.parseDouble(request.getParameter("impuesto")));
                Date fechaemision = Date.valueOf(request.getParameter("fechaemisionreserva"));
                Date fechapago = Date.valueOf(request.getParameter("fechapagoreserva"));
                String pagototal=request.getParameter("pagototal");

                /*cargando los datos de la reserva*/
                Reserva reserva = new Reserva();
                DaoReserva daoreserva = new DaoReserva(idreserva);
                reserva = daoreserva.obtenerReserva();
                
                /*VALIDANDO EL REGISTRO DE LA FECHAS INGRESADAS PARA LA RESERVA*/
                String fecha1=format.format(fechaemision);
                String fecha2=format.format(fechapago);
                /*variables enteras de comprobacion de las fechas ingresadas*/
                /*la fecha de pago puede ser igual o mayor a la de la emision, retornara 1 o 0 si se cumple*/
                int fa=comfe.comparefechasconDate(fecha2, fecha1);
                out.print(fa);
                
                
                if (fa>=0 && reserva != null && !tipocomprobante.isEmpty() && !numerocomprobante.isEmpty() && fechaemision != null && !pagototal.isEmpty()
                        && fechapago != null && Double.parseDouble(String.valueOf(impuesto)) > 0 && !tipocomprobante.equals("Seleccione")) {
                    /*guardando los datos del pago*/
                    Pago pago = new Pago(idpago.autoincrementablepagos(), reserva, tipocomprobante, numerocomprobante, impuesto, fechaemision, fechapago);
                    DaoPago daopago = new DaoPago(pago);
                    daopago.guardarPago();
                    
                    /*guardamos el seteo del estado de la habitacion disponible y el estado de la reserva a pagada*/
                    //seteando el estado de la habitacion
                    daohabitacion.setearestadohabitacionpago(reserva.getHabitacion().getIdhabitacion());
                    //seteamos el estado de pago de la habitacion
                    daoreserva.setearestadopagoreserva(idreserva);
                    
                    despachador = request.getRequestDispatcher("MostrarPago.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarPago.do");
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
