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
import modelo.dao.DaoCargo;
import modelo.dao.DaoEmpleado;
import modelo.entidad.Cargos;
import modelo.entidad.Empleado;

/**
 *
 * @author leo_g
 */
public class ControladorEmpleado extends HttpServlet {

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

            if (pagina.equals("/MostrarEmpleados.do")) {
                /*CARGANDO LOS DATOS PARA EL COMBOBOX DE CARGOS*/
                List<Cargos> listaDeCargos = new ArrayList<>();
                DaoCargo controlcargo = new DaoCargo();
                listaDeCargos = controlcargo.ObtenerlistaDeCargos();
                request.setAttribute("listaDeCargos", listaDeCargos);
                /*CARGANDO LOS DATOS PARA LA TABLA DE EMPLEADOS*/
                List<Empleado> listaempleados = new ArrayList<>();
                DaoEmpleado daoempleado = new DaoEmpleado();
                listaempleados = daoempleado.ObtenerlistaDeEmpleado();
                request.setAttribute("listaempleados", listaempleados);

                despachador = request.getRequestDispatcher("empleado.jsp");

            } else if (pagina.equals("/BorrarEmpleados.do")) {
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));

                if (idempleado > 0) {
                    Empleado empleado = new Empleado(idempleado);
                    DaoEmpleado daoempleado = new DaoEmpleado(idempleado);
                    daoempleado.eliminarEmpleado(empleado);
                    despachador = request.getRequestDispatcher("MostrarEmpleados.do");

                } else {
                    despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                }

            } else if (pagina.equals("/AgregarEmpleados.do")) {
                IdGenerado idempleado = new IdGenerado();
                /*obteniendo los datos de la vista producto.jsp*/
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String tipodocumento = request.getParameter("tipodocumento");
                String numerodocumento = request.getParameter("numdocumento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String email = request.getParameter("email");
                /*obteniendo los datos del cargo para poder agregarsela al empleado correspondiente*/
                int idcargo = Integer.parseInt(request.getParameter("idcargo"));
                Cargos cargo = new Cargos();
                DaoCargo daocargo = new DaoCargo(idcargo);
                cargo = daocargo.obtenerCargo();

                if (nr.buscarnumdocumentoempleado(numerodocumento) == null) {
                    if (cargo != null && !nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty()
                            && !numerodocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty() && !email.isEmpty()
                            && !tipodocumento.equals("Seleccione")) {
                        /*guardando los registros correspondientes*/
                        Empleado empleado = new Empleado(idempleado.autoincrementableempleado(), cargo, nombre, apellido, tipodocumento, numerodocumento, direccion, telefono, email);
                        DaoEmpleado daoempleado = new DaoEmpleado(empleado);
                        daoempleado.guardarEmpleado();
                        despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarEmpleados.do");

                }

            } else if (pagina.equals("/ModificarEmpleados.do")) {
                Empleado empleado = new Empleado();
                empleado.setIdempleado(Integer.parseInt(request.getParameter("idempleado")));

                /*cargamos el cargo correspondiente al empleado en el combo
                box*/
                DaoCargo controlcargo = new DaoCargo();
                List<Cargos> listaDeCargos = controlcargo.ObtenerlistaDeCargos();
                request.setAttribute("listaDeCargos", listaDeCargos);

                /*cargamos los datos correspondientes al input*/
                DaoEmpleado daoempleado = new DaoEmpleado(empleado.getIdempleado());
                empleado = daoempleado.obtenerEmpleado();
                request.setAttribute("empleado", empleado);
                despachador = request.getRequestDispatcher("MostrarEmpleados.do");

            } else if (pagina.equals("/EditarEmpleados.do")) {
                /*obteniendo los datos de la vista producto.jsp*/
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String tipodocumento = request.getParameter("tipodocumento");
                String numerodocumento = request.getParameter("numdocumento");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String email = request.getParameter("email");
                /*obteniendo los datos del cargo para poder agregarsela al empleado correspondiente*/
                int idcargo = Integer.parseInt(request.getParameter("idcargo"));
                Cargos cargo = new Cargos();
                DaoCargo daocargo = new DaoCargo(idcargo);
                cargo = daocargo.obtenerCargo();

                /*variable para jugar jajaja*/
                String jugar = request.getParameter("jugar");

                if (nr.buscarnumdocumentoempleado(numerodocumento) == null) {
                    if (idempleado > 0 && cargo != null && !nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty()
                            && !numerodocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty() && !email.isEmpty()
                            && !tipodocumento.equals("Seleccione")) {
                        /*guardando los registros correspondientes*/
                        Empleado empleado = new Empleado(idempleado, cargo, nombre, apellido, tipodocumento, numerodocumento, direccion, telefono, email);
                        DaoEmpleado daoempleado = new DaoEmpleado(empleado);
                        daoempleado.actualizarEmpleado(empleado);
                        despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                    }
                } else {
                    if (!numerodocumento.equals(jugar) && nr.buscarnumdocumentoempleado(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                    } else {
                        if (idempleado > 0 && cargo != null && !nombre.isEmpty() && !apellido.isEmpty() && !tipodocumento.isEmpty()
                                && !numerodocumento.isEmpty() && !direccion.isEmpty() && !telefono.isEmpty() && !email.isEmpty()
                                && !tipodocumento.equals("Seleccione")) {
                            /*guardando los registros correspondientes*/
                            Empleado empleado = new Empleado(idempleado, cargo, nombre, apellido, tipodocumento, numerodocumento, direccion, telefono, email);
                            DaoEmpleado daoempleado = new DaoEmpleado(empleado);
                            daoempleado.actualizarEmpleado(empleado);
                            despachador = request.getRequestDispatcher("MostrarEmpleados.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarEmpleados.do");
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
