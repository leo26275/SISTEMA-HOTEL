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
import modelo.dao.DaoCargo;
import modelo.entidad.Cargos;

/**
 *
 * @author Sony
 */
public class ControladorCargo extends HttpServlet {

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

            if (pagina.equals("/MostrarCargos.do")) {
                List<Cargos> listaDeCargos = new ArrayList<>();
                DaoCargo controlcargo = new DaoCargo();
                listaDeCargos = controlcargo.ObtenerlistaDeCargos();
                request.setAttribute("listaDeCargos", listaDeCargos);
                despachador = request.getRequestDispatcher("cargos.jsp");
            } else if (pagina.equals("/AgregarCargos.do")) {
                IdGenerado id = new IdGenerado();
                String nombre = request.getParameter("nombre");
                BigDecimal salario = BigDecimal.valueOf(Double.parseDouble(request.getParameter("salario")));

                if (nr.buscarnombrecargo(nombre) == null) {
                    if (!nombre.isEmpty() && Double.parseDouble(String.valueOf(salario)) > 0) {
                        Cargos cargo = new Cargos(id.autoincrementable(), nombre, salario);
                        DaoCargo daocargo = new DaoCargo(cargo);
                        daocargo.guardarCargo();
                        despachador = request.getRequestDispatcher("MostrarCargos.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarCargos.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarCargos.do");
                }

            } else if (pagina.equals("/BorrarCargos.do")) {
                int idcargo = Integer.parseInt(request.getParameter("idcargo"));

                if (idcargo > 0) {
                    Cargos cargo = new Cargos(idcargo);
                    DaoCargo daocargo = new DaoCargo(idcargo);
                    daocargo.eliminarCargo(cargo);
                    despachador = request.getRequestDispatcher("MostrarCargos.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarCargos.do");
                }

            } else if (pagina.equals("/ModificarCargos.do")) {
                Cargos cargo = new Cargos();
                cargo.setIdcargo(Integer.parseInt(request.getParameter("idcargo")));
                DaoCargo daocargo = new DaoCargo(cargo.getIdcargo());
                cargo = daocargo.obtenerCargo();
                request.setAttribute("cargo", cargo);
                despachador = request.getRequestDispatcher("MostrarCargos.do");
            } else if (pagina.equals("/EditarCargos.do")) {
                int idcargo = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                BigDecimal salario = BigDecimal.valueOf(Double.parseDouble(request.getParameter("salario")));

                /*variable para jugar*/
                String jugar = request.getParameter("jugar");

                if (nr.buscarnombrecargo(nombre) == null) {
                    if (!nombre.isEmpty() && Double.parseDouble(String.valueOf(salario)) > 0 && idcargo > 0) {
                        Cargos cargo = new Cargos(idcargo, nombre, salario);
                        DaoCargo daocargo = new DaoCargo(cargo);
                        daocargo.actualizarCargo(cargo);
                        despachador = request.getRequestDispatcher("MostrarCargos.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarCargos.do");
                    }
                } else {
                    if (!(nombre.equals(jugar)) && nr.buscarnombrecargo(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarCargos.do");
                    } else {
                        if (!nombre.isEmpty() && Double.parseDouble(String.valueOf(salario)) > 0 && idcargo > 0) {
                            Cargos cargo = new Cargos(idcargo, nombre, salario);
                            DaoCargo daocargo = new DaoCargo(cargo);
                            daocargo.actualizarCargo(cargo);
                            despachador = request.getRequestDispatcher("MostrarCargos.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarCargos.do");
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
