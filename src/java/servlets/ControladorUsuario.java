/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Adicionales.Encriptacion;
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
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoUsuario;
import modelo.entidad.Empleado;
import modelo.entidad.Usuarios;

/**
 *
 * @author leo_g
 */
public class ControladorUsuario extends HttpServlet {

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

            if (pagina.equals("/MostrarUsuarios.do")) {
                /*cargando los datos al combo box empleados*/
                List<Empleado> listaempleados = new ArrayList<>();
                DaoEmpleado daoempleado = new DaoEmpleado();
                listaempleados = daoempleado.ObtenerlistaDeEmpleadoUsuarios();
                request.setAttribute("listaempleados", listaempleados);

                /*Cargando la lista con datos de los usuarios para
                ser mostrados respectivamente en la tabla correspondiente*/
                List<Usuarios> listausuarios = new ArrayList<>();
                DaoUsuario daousuario = new DaoUsuario();
                listausuarios = daousuario.ObtenerlistaDeUsuarios();
                request.setAttribute("listausuarios", listausuarios);
                despachador = request.getRequestDispatcher("usuarios.jsp");
            } else if (pagina.equals("/BorrarUsuarios.do")) {

                int idusuario = Integer.parseInt(request.getParameter("idusuario"));
                if (idusuario > 0) {

                    Usuarios usuario = new Usuarios(idusuario);
                    DaoUsuario daousuario = new DaoUsuario();
                    daousuario.eliminarUsuario(usuario);
                    despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                } else {
                    despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                }
            } else if (pagina.equals("/AgregarUsuarios.do")) {
                IdGenerado idusuario = new IdGenerado();
                /*Buscando al empleado para agregarle un usuario*/
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));
                Empleado empleado = new Empleado();
                DaoEmpleado daoempleado = new DaoEmpleado(idempleado);
                empleado = daoempleado.obtenerEmpleado();

                /*recogiendo los datos para proceder a guardarlos*/
                String us = request.getParameter("usuario");
                String pas = request.getParameter("pass");

                if (nr.buscaruserempleado(us) == null) {
                    String passnuevo=Encriptacion.getStringMessageDigest(pas, Encriptacion.MD5);
                    if (!us.isEmpty() && !pas.isEmpty() && empleado != null &&pas.length()>7) {

                        Usuarios usuario = new Usuarios(idusuario.autoincrementableusuario(), empleado, us, passnuevo);
                        DaoUsuario daousuario = new DaoUsuario(usuario);
                        daousuario.guardarUsuario();
                        despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                    } else {
                        despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                    }
                } else {
                    despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                }

            } else if (pagina.equals("/ModificarUsuarios.do")) {
                Usuarios usuarios = new Usuarios();
                usuarios.setIdusuario(Integer.parseInt(request.getParameter("idusuario")));

                /*obtenemos los datos de los empleados para cargarlos en el combo*/
                DaoEmpleado daoempleado = new DaoEmpleado();
                List<Empleado> listaempleados = daoempleado.ObtenerlistaDeEmpleadoUsuarios();
                request.setAttribute("listaempleados", listaempleados);

                /*Cargamos los datos seleccionados del usuario correspondiente*/
                DaoUsuario daousuario = new DaoUsuario(usuarios.getIdusuario());
                usuarios = daousuario.obtenerUsuario();
                request.setAttribute("usuarios", usuarios);
                despachador = request.getRequestDispatcher("MostrarUsuarios.do");
            } else if (pagina.equals("/EditarUsuarios.do")) {
                /*Buscando al empleado para agregarle un usuario*/
                int idempleado = Integer.parseInt(request.getParameter("idempleado"));
                Empleado empleado = new Empleado();
                DaoEmpleado daoempleado = new DaoEmpleado(idempleado);
                empleado = daoempleado.obtenerEmpleado();

                /*recogiendo los datos para proceder a guardarlos*/
                int idusuario = Integer.parseInt(request.getParameter("idusuario"));
                String us = request.getParameter("usuario");
                String pas = request.getParameter("pass");

                /*variable que trae el metodo de la contrasena*/
                String jugarcontrasena = request.getParameter("jugar3");

                /*variables para jugar uwu uwu*/
                String jugar1 = request.getParameter("jugar1");/*es el usuario*/
                int jugar2 = Integer.parseInt(request.getParameter("jugar2"));/*es el id del empleado*/

                if (nr.buscaruserempleado(us) == null) {

                    /*validacion de la modificacion del password*/
                    if (pas.equals("")) {
                        if (!us.isEmpty() && !pas.isEmpty() && idusuario > 0 && pas.length()>7) {
                            Usuarios usuario = new Usuarios(idusuario, empleado, us, jugarcontrasena);
                            DaoUsuario daousuario = new DaoUsuario(usuario);
                            daousuario.actualizarUsuario(usuario);
                            despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                        }
                    } else {
                        if (!us.isEmpty() && !pas.isEmpty() && idusuario > 0 && pas.length()>7) {
                            String passnuevo=Encriptacion.getStringMessageDigest(pas, Encriptacion.MD5);
                            Usuarios usuario = new Usuarios(idusuario, empleado, us, passnuevo);
                            DaoUsuario daousuario = new DaoUsuario(usuario);
                            daousuario.actualizarUsuario(usuario);
                            despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                        } else {
                            despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                        }
                    }

                } else {
                    if (!us.equals(jugar1) && nr.buscaruserempleado(jugar1) != null) {
                        despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                    } else {
                        /*validacion de la modificacion del password*/
                        if (pas.equals("")) {
                            if (!us.isEmpty() && !pas.isEmpty() && idusuario > 0 && pas.length()>7) {
                                Usuarios usuario = new Usuarios(idusuario, empleado, us, jugarcontrasena);
                                DaoUsuario daousuario = new DaoUsuario(usuario);
                                daousuario.actualizarUsuario(usuario);
                                despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                            } else {
                                despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                            }
                        } else {
                            if (!us.isEmpty() && !pas.isEmpty() && idusuario > 0 && pas.length()>7) {
                                String passnuevo=Encriptacion.getStringMessageDigest(pas, Encriptacion.MD5);
                                Usuarios usuario = new Usuarios(idusuario, empleado, us, passnuevo);
                                DaoUsuario daousuario = new DaoUsuario(usuario);
                                daousuario.actualizarUsuario(usuario);
                                despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                            } else {
                                despachador = request.getRequestDispatcher("MostrarUsuarios.do");
                            }
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
