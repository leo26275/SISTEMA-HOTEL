/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.dao.DaoPago;

/**
 *
 * @author Sony
 */
public class CodigoFactura {

    DaoPago lista = new DaoPago();

    public CodigoFactura() {
    }

    public int generarnumero() {
        int n = 0;

        if (lista.ObtenerlistaDePago().size() > 0) {
            n = lista.ObtenerlistaDePago().get(lista.ObtenerlistaDePago().size() - 1).getIdpago() + 1;
        } else {
            n = 1;
        }

        return n;
    }
    String g = "res09999";

    public String generarCodigo() {
        int n = generarnumero();
        String letras = "HOT";
        String codigo = "";
        if (n < 10) {
            codigo = letras + "0000" + n;
        } else if (n >= 10 && n < 100) {
            codigo = letras + "000" + n;
        } else if (n >= 100 && n < 1000) {
            codigo = letras + "00" + n;
        } else if (n >= 1000 && n < 10000) {
            codigo = letras + "0" + n;
        } else {
            codigo = letras + n;
        }
        return codigo;
    }
}
