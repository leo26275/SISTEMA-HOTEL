/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.dao.DaoCargo;
import modelo.dao.DaoCategoria;
import modelo.dao.DaoCliente;
import modelo.dao.DaoConsumo;
import modelo.dao.DaoEmpleado;
import modelo.dao.DaoHabitacion;
import modelo.dao.DaoPago;
import modelo.dao.DaoProducto;
import modelo.dao.DaoReserva;
import modelo.dao.DaoUsuario;

/**
 *
 * @author Sony
 */
public class IdGenerado {

    public IdGenerado() {
    }

    DaoCargo dc = new DaoCargo();
    DaoProducto dp=new DaoProducto();
    DaoCategoria dca=new DaoCategoria();
    DaoEmpleado de=new DaoEmpleado();
    DaoUsuario du=new DaoUsuario();
    DaoHabitacion dh=new DaoHabitacion();
    DaoCliente dcl=new DaoCliente();
    DaoReserva dr=new DaoReserva();
    DaoConsumo dcm=new DaoConsumo();
    DaoPago dpg=new DaoPago();
    

    public int autoincrementable() {
        int auto_increment = 0;

        if (dc.ObtenerlistaDeCargos().size() > 0) {
            auto_increment = dc.ObtenerlistaDeCargos().get(dc.ObtenerlistaDeCargos().size() - 1).getIdcargo() + 1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementableproducto() {
        int auto_increment = 0;

        if (dp.ObtenerlistaDeProductos().size() > 0) {
            auto_increment = dp.ObtenerlistaDeProductos().get(dp.ObtenerlistaDeProductos().size() - 1).getIdproducto()+ 1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementablecategoria() {
        int auto_increment = 0;

        if (dca.ObtenerlistaDeCategorias().size() > 0) {
            auto_increment = dca.ObtenerlistaDeCategorias().get(dca.ObtenerlistaDeCategorias().size()-1).getIdcategoria()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementableempleado() {
        int auto_increment = 0;

        if (de.ObtenerlistaDeEmpleado().size() > 0) {
            auto_increment = de.ObtenerlistaDeEmpleado().get(de.ObtenerlistaDeEmpleado().size()-1).getIdempleado()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementableusuario() {
        int auto_increment = 0;

        if (du.ObtenerlistaDeUsuarios().size() > 0) {
            auto_increment = du.ObtenerlistaDeUsuarios().get(du.ObtenerlistaDeUsuarios().size()-1).getIdusuario()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementablehabitacion() {
        int auto_increment = 0;

        if (dh.ObtenerlistaDeHabitaciones().size() > 0) {
            auto_increment = dh.ObtenerlistaDeHabitaciones().get(dh.ObtenerlistaDeHabitaciones().size()-1).getIdhabitacion()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementableclientes() {
        int auto_increment = 0;

        if (dcl.ObtenerlistaDeClientes().size() > 0) {
            auto_increment = dcl.ObtenerlistaDeClientes().get(dcl.ObtenerlistaDeClientes().size()-1).getIdcliente()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    
    public int autoincrementablereservas() {
        int auto_increment = 0;

        if (dr.ObtenerlistaDeReservas().size() > 0) {
            auto_increment = dr.ObtenerlistaDeReservas().get(dr.ObtenerlistaDeReservas().size()-1).getIdreserva()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementableconsumos() {
        int auto_increment = 0;

        if (dcm.ObtenerlistaDeConsumosInsertar().size() > 0) {
            auto_increment = dcm.ObtenerlistaDeConsumosInsertar().get(dcm.ObtenerlistaDeConsumosInsertar().size()-1).getIdconsumo()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
    public int autoincrementablepagos() {
        int auto_increment = 0;

        if (dpg.ObtenerlistaDePago().size() > 0) {
            auto_increment = dpg.ObtenerlistaDePago().get(dpg.ObtenerlistaDePago().size()-1).getIdpago()+1;
        } else {
            auto_increment = 1;
        }
        return auto_increment;
    }
    
}
