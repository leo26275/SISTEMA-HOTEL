/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import modelo.dao.DaoConsumo;
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoPago;
import modelo.dao.DaoProducto;
import modelo.dao.DaoReserva;
import modelo.dao.DaoUsuario;
import modelo.entidad.Consumo;
import modelo.entidad.Empleado;
import modelo.entidad.Pago;
import modelo.entidad.Producto;
import modelo.entidad.Reserva;
import modelo.entidad.Usuarios;

/**
 *
 * @author Sony
 */
public class NoEliminacion {

    DaoReserva daoReserva = new DaoReserva();
    DaoPago daopago = new DaoPago();
    DaoConsumo daoconsumo = new DaoConsumo();
    DaoProducto daoproducto = new DaoProducto();
    DaoUsuario daousuarios = new DaoUsuario();
    DaoEmpleado daoempleado = new DaoEmpleado();

    public NoEliminacion() {
    }

    /*buscando el idreserva en los registros de consumos*/
    public Consumo buscaridreservaconsumo(int idreserva) {
        for (Consumo c : daoconsumo.ObtenerlistaDeConsumosInsertar()) {
            if (c.getReserva().getIdreserva() == idreserva) {
                return c;
            }
        }
        return null;
    }

    /*buscando el idreserva en los registros de pagos*/
    public Pago buscaridreservapago(int idreserva) {
        for (Pago p : daopago.ObtenerlistaDePago()) {
            if (p.getReserva().getIdreserva() == idreserva) {
                return p;
            }
        }
        return null;
    }

    /*buscando el id de la catagoria en la clase producto*/
    public Producto buscaridcategoriaproducto(int idcategoria) {
        for (Producto p : daoproducto.ObtenerlistaDeProductos()) {
            if (p.getCategoria().getIdcategoria() == idcategoria) {
                return p;
            }
        }
        return null;
    }

    /*Buscar el id del producto en consumo*/
    public Consumo buscaridproductoconsumo(int idproducto) {
        for (Consumo c : daoconsumo.ObtenerlistaDeConsumosInsertar()) {
            if (c.getProducto().getIdproducto() == idproducto) {
                return c;
            }
        }
        return null;
    }

    /*buscando el id del cliente en las reservas y el id de la habitacion tambien y tambien el id del empleado*/
    public Reserva buscaridclienteidhabitacionreserva(int idcleinte, int idhabitacion, int idempleado) {
        for (Reserva r : daoReserva.ObtenerlistaDeReservas()) {
            if (r.getClientes().getIdcliente() == idcleinte || r.getHabitacion().getIdhabitacion() == idhabitacion || r.getEmpleado().getIdempleado() == idempleado) {
                return r;
            }
        }
        return null;
    }

    /*buscar idempleado en la tabla usuarios*/
    public Usuarios buscaridempleadousuarios(int idempleado) {
        for (Usuarios u : daousuarios.ObtenerlistaDeUsuarios()) {
            if (u.getEmpleado().getIdempleado() == idempleado) {
                return u;
            }
        }
        return null;
    }

    /*buscar id cargo en la entidad empleado*/
    public Empleado buscaridcargoempleado(int idcargo) {
        for (Empleado em : daoempleado.ObtenerlistaDeEmpleado()) {
            if (em.getCargos().getIdcargo() == idcargo) {
                return em;
            }
        }

        return null;
    }
}
