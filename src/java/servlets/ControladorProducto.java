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
import modelo.dao.DaoCategoria;
import modelo.dao.DaoProducto;
import modelo.entidad.Categoria;
import modelo.entidad.Producto;

/**
 *
 * @author leo_g
 */
public class ControladorProducto extends HttpServlet {

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

            if (pagina.equals("/MostrarProductos.do")) {
                /*cargamos la tabla con sus respectivos datos*/
                List<Producto> listaproductos = new ArrayList<>();
                DaoProducto daoproducto = new DaoProducto();
                listaproductos = daoproducto.ObtenerlistaDeProductos();
                request.setAttribute("listaproductos", listaproductos);

                /*cargamos el combo con las categorias para poder guardar los productos con sus 
                respectivas categorias*/
                List<Categoria> listacategorias = new ArrayList<>();
                DaoCategoria daocategoria = new DaoCategoria();
                listacategorias = daocategoria.ObtenerlistaDeCategorias();
                request.setAttribute("listacategorias", listacategorias);

                despachador = request.getRequestDispatcher("producto.jsp");
            } else if (pagina.equals("/AgregarProductos.do")) {
                IdGenerado idproducto = new IdGenerado();
                /*obteniendo los datos de la vista producto.jsp*/
                String nombre = request.getParameter("nombre");
                int idcategoria = Integer.parseInt(request.getParameter("idcategoria"));
                String descripcion = request.getParameter("descripcion");
                BigDecimal precioventa = BigDecimal.valueOf(Double.parseDouble(request.getParameter("precioventa")));
                /*obteniendo los datos de la categoria para poder agregarsela al producto correspondiente*/
                Categoria categoria = new Categoria();
                DaoCategoria daocategoria = new DaoCategoria(idcategoria);
                categoria = daocategoria.obtenerCategoria();

                if (nr.buscarnombreproducto(nombre) == null) {
                    if (!nombre.isEmpty() && !descripcion.isEmpty() && Double.parseDouble(String.valueOf(precioventa)) > 0
                            && categoria != null) {
                        /*guardando los registros correspondientes*/
                        Producto producto = new Producto(idproducto.autoincrementableproducto(), categoria, nombre, descripcion, precioventa);
                        DaoProducto daoproducto = new DaoProducto(producto);
                        daoproducto.guardarProducto();
                        despachador = request.getRequestDispatcher("MostrarProductos.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarProductos.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarProductos.do");
                }

            } else if (pagina.equals("/ModificarProductos.do")) {
                Producto producto = new Producto();
                producto.setIdproducto(Integer.parseInt(request.getParameter("idproducto")));

                /*obtenemos los datos de la categoria para cargar en el combo
                la categoria correspondiente del producto que solicitamos editar*/
                DaoCategoria daocategoria = new DaoCategoria();
                List<Categoria> listacategorias = daocategoria.ObtenerlistaDeCategorias();
                request.setAttribute("listacategorias", listacategorias);

                /*cargamos el producto solicitado a editar con todos sus datos*/
                DaoProducto daoproducto = new DaoProducto(producto.getIdproducto());
                producto = daoproducto.obtenerProducto();/*cargamos el producto con todos sus datos*/
                request.setAttribute("producto", producto);
                despachador = request.getRequestDispatcher("MostrarProductos.do");
            } else if (pagina.equals("/EditarProductos.do")) {
                /*obteniendo los datos de la vista producto.jsp*/
                int idproducto = Integer.parseInt(request.getParameter("idproducto"));
                String nombre = request.getParameter("nombre");
                int idcategoria = Integer.parseInt(request.getParameter("idcategoria"));
                String descripcion = request.getParameter("descripcion");
                BigDecimal precioventa = BigDecimal.valueOf(Double.parseDouble(request.getParameter("precioventamodificar")));

                /*obteniendo los datos de la categoria para poder agregarsela al producto correspondiente*/
                Categoria categoria = new Categoria();
                DaoCategoria daocategoria = new DaoCategoria(idcategoria);
                categoria = daocategoria.obtenerCategoria();

                /*variable para jugar uwu*/
                String jugar = request.getParameter("jugar");

                if (nr.buscarnombreproducto(nombre) == null) {
                    if (idproducto > 0 && !nombre.isEmpty() && !descripcion.isEmpty() && Double.parseDouble(String.valueOf(precioventa)) > 0
                            && categoria != null) {
                        /*guardando los registros correspondientes*/
                        Producto producto = new Producto(idproducto, categoria, nombre, descripcion, precioventa);
                        DaoProducto daoproducto = new DaoProducto(producto);
                        daoproducto.actualizarProducto(producto);
                        despachador = request.getRequestDispatcher("MostrarProductos.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarProductos.do");
                    }
                } else {
                    if (!nombre.equals(jugar) && nr.buscarnombreproducto(jugar) != null) {
                        despachador = request.getRequestDispatcher("MostrarProductos.do");
                    } else {
                        if (idproducto > 0 && !nombre.isEmpty() && !descripcion.isEmpty() && Double.parseDouble(String.valueOf(precioventa)) > 0
                                && categoria != null) {
                            /*guardando los registros correspondientes*/
                            Producto producto = new Producto(idproducto, categoria, nombre, descripcion, precioventa);
                            DaoProducto daoproducto = new DaoProducto(producto);
                            daoproducto.actualizarProducto(producto);
                            despachador = request.getRequestDispatcher("MostrarProductos.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarProductos.do");
                        }
                    }
                }

            } else if (pagina.equals("/BorrarProductos.do")) {
                int idproducto = Integer.parseInt(request.getParameter("idproducto"));

                if (idproducto > 0) {
                    Producto producto = new Producto(idproducto);
                    DaoProducto daoproducto = new DaoProducto();
                    daoproducto.eliminarProducto(producto);
                    despachador = request.getRequestDispatcher("MostrarProductos.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarProductos.do");
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
