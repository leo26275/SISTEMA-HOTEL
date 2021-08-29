/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoHabitacion;
import modelo.dao.DaoProducto;
import modelo.dao.DaoReserva;
import modelo.entidad.Empleado;
import modelo.entidad.Habitacion;
import modelo.entidad.Producto;
import modelo.entidad.Reserva;

/**
 *
 * @author leo_g
 */
public class ControladorConsultas extends HttpServlet {

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
            
            
            if (pagina.equals("/ProductosCategorias.do")) {
                
                List<Producto> listaproductos=new ArrayList<>();
                DaoProducto daoproducto=new DaoProducto();
                listaproductos=daoproducto.ObtenerlistaDeProductosconsultas();
                request.setAttribute("listaproductos", listaproductos);
                
                despachador=request.getRequestDispatcher("consulta1.jsp");
                
            } else if(pagina.equals("/HabitacionesOcupadas.do")){
                
                List<Habitacion> listahabita=new ArrayList<>();
                DaoHabitacion daohabitacion=new DaoHabitacion();
                listahabita=daohabitacion.habitacionesocupadas();
                request.setAttribute("listahabita", listahabita);
                
                despachador=request.getRequestDispatcher("consulta2.jsp");
                
            }else if(pagina.equals("/HabitacionesDisponibles.do")){
            
                List<Habitacion> listahabita=new ArrayList<>();
                DaoHabitacion daohabitacion=new DaoHabitacion();
                listahabita=daohabitacion.habitacionesdisponibles();
                request.setAttribute("listahabita", listahabita);
                
                despachador=request.getRequestDispatcher("consulta3.jsp");
                
            }else if(pagina.equals("/InformacionReservasCosto.do")){
                
                List<Reserva> listareserva=new ArrayList<>();
                DaoReserva daoreserva=new DaoReserva();
                listareserva=daoreserva.informacionreservas();
                request.setAttribute("listareserva", listareserva);
                
                despachador=request.getRequestDispatcher("consulta4.jsp");
            
            }else if(pagina.equals("/InformacionEmpleadosCargos.do")){
            
                 List<Empleado> listaempleado=new ArrayList<>();
                DaoEmpleado daoempleado=new DaoEmpleado();
                listaempleado=daoempleado.empleadoscargos();
                request.setAttribute("listaempleado", listaempleado);
                
                despachador=request.getRequestDispatcher("consulta5.jsp");
                
            }else if(pagina.equals("/EmpleadossinAcceso.do")){
            List<Empleado> listaempleado=new ArrayList<>();
                DaoEmpleado daoempleado=new DaoEmpleado();
                listaempleado=daoempleado.empleadossinuser();
                request.setAttribute("listaempleadosinuser", listaempleado);
                
                despachador=request.getRequestDispatcher("consulta6.jsp");
            
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
