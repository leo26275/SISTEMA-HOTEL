/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Adicionales.IdGenerado;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoConsumo;
import modelo.dao.DaoProducto;
import modelo.dao.DaoReserva;
import modelo.entidad.Consumo;
import modelo.entidad.Producto;
import modelo.entidad.Reserva;

/**
 *
 * @author leo_g
 */
public class ControladorConsumo extends HttpServlet {

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
            if (pagina.equals("/MostrarConsumo.do")) {

                /*cargando la lista con las reservas no pagadas*/
                List<Reserva> listareserva = new ArrayList<>();
                DaoReserva daoreserva = new DaoReserva();
                listareserva = daoreserva.listacomboreservas();
                request.setAttribute("listareserva", listareserva);

                /*cargando la lista con los productos*/
                List<Producto> listaproducto = new ArrayList<>();
                DaoProducto daoproducto = new DaoProducto();
                listaproducto = daoproducto.ObtenerlistaDeProductos();
                request.setAttribute("listaproducto", listaproducto);

                /*Cargando lista de consumos de reservas no pagadas*/
                List<Consumo> listaconsumo = new ArrayList<>();
                DaoConsumo daoconsumo = new DaoConsumo();
                listaconsumo = daoconsumo.ObtenerlistaDeConsumosEstado();
                request.setAttribute("listaconsumo", listaconsumo);

                despachador = request.getRequestDispatcher("consumo.jsp");
            } else if (pagina.equals("/BorrarConsumo.do")) {

                int idconsumo = Integer.parseInt(request.getParameter("idconsumo"));

                if (idconsumo > 0) {

                    Consumo consumo = new Consumo(idconsumo);
                    DaoConsumo daoconsumo = new DaoConsumo();
                    daoconsumo.eliminarConsumo(consumo);
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
                }

            } else if (pagina.equals("/AgregarConsumo.do")) {

                IdGenerado idconsumo = new IdGenerado();
                /*obteniendo los datos de la vista*/
                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                int idproducto = Integer.parseInt(request.getParameter("idproducto"));
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));

                /*obteniendo los datos de la reserva*/
                Reserva reserva = new Reserva();
                DaoReserva daoreserva = new DaoReserva(idreserva);
                reserva = daoreserva.obtenerReserva();

                /*obteniendo los datos del producto*/
                Producto producto = new Producto();
                DaoProducto daoproducto = new DaoProducto(idproducto);
                producto = daoproducto.obtenerProducto();
                if (producto != null && reserva != null && cantidad > 0) {
                    /*Guardando el consumo*/
                    Consumo consumo = new Consumo(idconsumo.autoincrementableconsumos(), producto, reserva, cantidad);
                    DaoConsumo daoconsumo = new DaoConsumo(consumo);
                    daoconsumo.guardarConsumo();
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
                }

            } else if (pagina.equals("/ModificarConsumo.do")) {
                Consumo consumo = new Consumo();
                consumo.setIdconsumo(Integer.parseInt(request.getParameter("idconsumo")));

                /*cargando la lista con los productos*/
                DaoProducto daoproducto = new DaoProducto();
                List<Producto> listaproducto = daoproducto.ObtenerlistaDeProductos();
                request.setAttribute("listaproducto", listaproducto);

                /*Cargamos el consumo solicitado para la edicion de datos*/
                DaoConsumo daoconsumo = new DaoConsumo(consumo.getIdconsumo());
                consumo = daoconsumo.obtenerConsumo();
                request.setAttribute("consumo", consumo);

                despachador = request.getRequestDispatcher("MostrarConsumo.do");

            } else if (pagina.equals("/EditarConsumo.do")) {

                /*obteniendo los datos de la vista*/
                int idconsumo = Integer.parseInt(request.getParameter("idconsumo"));
                int idreserva = Integer.parseInt(request.getParameter("idreserva"));
                int idproducto = Integer.parseInt(request.getParameter("idproducto"));
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));

                /*obteniendo los datos de la reserva*/
                Reserva reserva = new Reserva();
                DaoReserva daoreserva = new DaoReserva(idreserva);
                reserva = daoreserva.obtenerReserva();

                /*obteniendo los datos del producto*/
                Producto producto = new Producto();
                DaoProducto daoproducto = new DaoProducto(idproducto);
                producto = daoproducto.obtenerProducto();

                if (idconsumo > 0 && producto != null && reserva != null && cantidad > 0) {
                    /*Guardando el consumo*/
                    Consumo consumo = new Consumo(idconsumo, producto, reserva, cantidad);
                    DaoConsumo daoconsumo = new DaoConsumo(consumo);
                    daoconsumo.actualizarConsumo(consumo);
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarConsumo.do");
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
