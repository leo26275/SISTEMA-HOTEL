/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import modelo.dao.DaoCargo;
import modelo.dao.DaoCategoria;
import modelo.dao.DaoCliente;
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoHabitacion;
import modelo.dao.DaoProducto;
import modelo.dao.DaoReserva;
import modelo.dao.DaoUsuario;
import modelo.entidad.Cargos;
import modelo.entidad.Categoria;
import modelo.entidad.Clientes;
import modelo.entidad.Empleado;
import modelo.entidad.Habitacion;
import modelo.entidad.Producto;
import modelo.entidad.Usuarios;

/**
 *
 * @author Sony
 */
public class NoRepeticion {

    DaoCategoria daoCategoria = new DaoCategoria();
    DaoCliente daocliente = new DaoCliente();
    DaoCargo daocargo = new DaoCargo();
    DaoEmpleado daoempleado = new DaoEmpleado();
    DaoHabitacion daohabitacion = new DaoHabitacion();
    DaoProducto daoProducto = new DaoProducto();
    DaoReserva daoreserva = new DaoReserva();
    DaoUsuario daousuario = new DaoUsuario();

    public NoRepeticion() {
    }

    /*buscando el nombre de la categoria*/
    public Categoria buscarcategoria(String nombrecategoria) {

        for (Categoria c : daoCategoria.ObtenerlistaDeCategorias()) {
            if (c.getNombre().equals(nombrecategoria)) {
                return c;
            }
        }

        return null;
    }

    /*buscando el nombre del cargo*/
    public Cargos buscarnombrecargo(String nombrecargo) {
        for (Cargos c : daocargo.ObtenerlistaDeCargos()) {
            if (c.getNombre().equals(nombrecargo)) {
                return c;
            }
        }
        return null;
    }

    /*buscando el tipo de documento del cliete*/
    public Clientes buscarnumdocumentocliente(String numerodocumento) {
        for (Clientes cl : daocliente.ObtenerlistaDeClientes()) {
            if (cl.getNumdocu().equals(numerodocumento)) {
                return cl;
            }
        }

        return null;
    }

    /*buscando el numero de documento del empleado para que no se repita*/
    public Empleado buscarnumdocumentoempleado(String numerodocumento) {
        for (Empleado e : daoempleado.ObtenerlistaDeEmpleado()) {
            if (e.getNumerodocu().equals(numerodocumento)) {
                return e;
            }
        }
        return null;
    }

    /*buscar el  numero de la habitacion para que no se agregue en caso de que se quiera agregar otra que ya exista*/
    public Habitacion buscarnumerohabitacion(String numerohabitacion) {

        for (Habitacion h : daohabitacion.ObtenerlistaDeHabitaciones()) {
            if (h.getNumero().equals(numerohabitacion)) {
                return h;
            }
        }

        return null;
    }

    /*buscando el nombre del producto*/
    public Producto buscarnombreproducto(String nombreproducto) {
        for (Producto p : daoProducto.ObtenerlistaDeProductos()) {
            if (p.getNombre().equals(nombreproducto)) {
                return p;
            }
        }
        return null;
    }

    /*buscando el usuario y el empleado para que no se repitan al agregar*/
    public Usuarios buscaruserempleado(String usuario) {

        for(Usuarios u:daousuario.ObtenerlistaDeUsuarios()){
            if (u.getUsuario().equals(usuario)) {
                return u;
            }
        }
        return null;
    }

}
