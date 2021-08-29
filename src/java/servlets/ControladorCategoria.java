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
import modelo.dao.DaoCategoria;
import modelo.entidad.Cargos;
import modelo.entidad.Categoria;

/**
 *
 * @author leo_g
 */
public class ControladorCategoria extends HttpServlet {

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

            if (pagina.equals("/MostrarCategoria.do")) {
                List<Categoria> listaDeCategorias = new ArrayList<>();
                DaoCategoria controlcategoria = new DaoCategoria();
                listaDeCategorias = controlcategoria.ObtenerlistaDeCategorias();
                request.setAttribute("listaDeCategorias", listaDeCategorias);
                despachador = request.getRequestDispatcher("categoria.jsp");
            } else if (pagina.equals("/AgregarCategorias.do")) {
                IdGenerado id = new IdGenerado();
                String nombre = request.getParameter("nombre");

                if (nr.buscarcategoria(nombre) == null) {
                    if (!nombre.isEmpty()) {
                        Categoria categoria = new Categoria(id.autoincrementablecategoria(), nombre);
                        DaoCategoria daocategoria = new DaoCategoria(categoria);
                        daocategoria.guardarCategoria();
                        despachador = request.getRequestDispatcher("MostrarCategoria.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarCategoria.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarCategoria.do");
                }

            } else if (pagina.equals("/BorrarCategorias.do")) {
                int idcategoria = Integer.parseInt(request.getParameter("idcategoria"));
                if (idcategoria > 0) {

                    Categoria categoria = new Categoria(idcategoria);
                    DaoCategoria daocategoria = new DaoCategoria(idcategoria);
                    daocategoria.eliminarCategoria(categoria);
                    despachador = request.getRequestDispatcher("MostrarCategoria.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarCategoria.do");
                }

            } else if (pagina.equals("/ModificarCategorias.do")) {
                Categoria categoria = new Categoria();
                categoria.setIdcategoria(Integer.parseInt(request.getParameter("idcategoria")));
                DaoCategoria daocategoria = new DaoCategoria(categoria.getIdcategoria());
                categoria = daocategoria.obtenerCategoria();
                request.setAttribute("categoria", categoria);
                despachador = request.getRequestDispatcher("MostrarCategoria.do");
            } else if (pagina.equals("/EditarCategorias.do")) {
                int idcategoria = Integer.parseInt(request.getParameter("id"));
                String nombrecategoria = request.getParameter("nombre");

                /*variable para jugar*/
                String jugar=request.getParameter("jugar");
                
                if (nr.buscarcategoria(nombrecategoria) == null) {
                    if (idcategoria > 0 && !nombrecategoria.isEmpty()) {
                        Categoria categoria = new Categoria(idcategoria, nombrecategoria);
                        DaoCategoria daocategoria = new DaoCategoria(categoria);
                        daocategoria.actualizarCategoria(categoria);
                        despachador = request.getRequestDispatcher("MostrarCategoria.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarCategoria.do");
                    }
                } else {

                    if (!nombrecategoria.equals(jugar) && nr.buscarcategoria(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarCategoria.do");
                    } else {
                        if (idcategoria > 0 && !nombrecategoria.isEmpty()) {
                            Categoria categoria = new Categoria(idcategoria, nombrecategoria);
                            DaoCategoria daocategoria = new DaoCategoria(categoria);
                            daocategoria.actualizarCategoria(categoria);
                            despachador = request.getRequestDispatcher("MostrarCategoria.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarCategoria.do");
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
