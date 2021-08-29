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
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.DaoCliente;
import modelo.entidad.Clientes;

/**
 *
 * @author leo_g
 */
public class ControladorCliente extends HttpServlet {

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

            if (pagina.equals("/MostrarClientes.do")) {
                List<Clientes> listadoclientes = new ArrayList<>();
                DaoCliente daocliente = new DaoCliente();
                listadoclientes = daocliente.ObtenerlistaDeClientes();
                request.setAttribute("listadoclientes", listadoclientes);

                despachador = request.getRequestDispatcher("cliente.jsp");

            } else if (pagina.equals("/BorrarClientes.do")) {
                int idcliente = Integer.parseInt(request.getParameter("idcliente"));

                if (idcliente > 0) {
                    Clientes cliente = new Clientes(idcliente);
                    DaoCliente daocliente = new DaoCliente(cliente);
                    daocliente.eliminarClientes(cliente);
                    despachador = request.getRequestDispatcher("MostrarClientes.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarClientes.do");
                }
            } else if (pagina.equals("/AgregarClientes.do")) {
                IdGenerado idcliente = new IdGenerado();
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String tipodocumento = request.getParameter("tipodocumento");
                String numdocumento = request.getParameter("numdocumento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

                if (nr.buscarnumdocumentocliente(numdocumento) == null) {
                    /*validando los datos del cliente a ingresar*/
                    if (!nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty() && !numdocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty()) {
                        Clientes clientes = new Clientes(idcliente.autoincrementableclientes(), nombre, apellido, tipodocumento, numdocumento, direccion, telefono);
                        DaoCliente daocliente = new DaoCliente(clientes);
                        daocliente.guardarCliente();
                        despachador = request.getRequestDispatcher("MostrarClientes.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarClientes.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarClientes.do");
                }

            } else if (pagina.equals("/ModificarClientes.do")) {
                Clientes clientes = new Clientes();
                clientes.setIdcliente(Integer.parseInt(request.getParameter("idcliente")));
                DaoCliente daocliente = new DaoCliente(clientes.getIdcliente());
                clientes = daocliente.obtenerCliente();
                request.setAttribute("clientes", clientes);
                despachador = request.getRequestDispatcher("MostrarClientes.do");
            } else if (pagina.equals("/EditarClientes.do")) {
                int idcliente = Integer.parseInt(request.getParameter("idcliente"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String tipodocumento = request.getParameter("tipodocumento");
                String numdocumento = request.getParameter("numdocumento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");

                /*variable para jugar xd*/
                String jugar = request.getParameter("jugar");

                if (nr.buscarnumdocumentocliente(numdocumento) == null) {
                    /*validacionde los datos del cliente a ingresar por el lado del sevidror*/
                    if (idcliente > 0 && !nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty() && !numdocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty()) {
                        Clientes clientes = new Clientes(idcliente, nombre, apellido, tipodocumento, numdocumento, direccion, telefono);
                        DaoCliente daocliente = new DaoCliente(clientes);
                        daocliente.actualizarClientes(clientes);
                        despachador = request.getRequestDispatcher("MostrarClientes.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarClientes.do");
                    }
                } else {
                    if (!numdocumento.equals(jugar) && nr.buscarnumdocumentocliente(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarClientes.do");
                    } else {
                        /*validacionde los datos del cliente a ingresar por el lado del sevidror*/
                        if (idcliente > 0 && !nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty() && !numdocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty()) {
                            Clientes clientes = new Clientes(idcliente, nombre, apellido, tipodocumento, numdocumento, direccion, telefono);
                            DaoCliente daocliente = new DaoCliente(clientes);
                            daocliente.actualizarClientes(clientes);
                            despachador = request.getRequestDispatcher("MostrarClientes.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarClientes.do");
                        }
                    }
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
