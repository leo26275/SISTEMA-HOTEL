/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import modelo.dao.DaoConsumo;
import modelo.entidad.Consumo;

/**
 *
 * @author Sony
 */
public class Totales {

    DaoConsumo daoconsumo = new DaoConsumo();

    public Totales() {
    }

    public double totalconsumido() {
        double tot = 0;

        for (Consumo c : daoconsumo.ObtenerlistaDeConsumosEstado()) {
            tot += c.total();
        }

        return tot;
    }
}
