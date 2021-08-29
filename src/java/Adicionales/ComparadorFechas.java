/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Sony
 */
public class ComparadorFechas {

    public ComparadorFechas() {
    }

    public int comparefechasconDate(String fecha1, String fechaactual) {

        int resultado = 0;

        SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
        try {
            Date fechaDate1 = formateador.parse(fecha1);
            Date fechaDate2 = formateador.parse(fechaactual);

            if (fechaDate1.before(fechaDate2)) {
                //la fecha es menor
                return -1;
            } else if (fechaDate2.before(fechaDate1)) {
                //la fecha es mayor
                return 1;
            } else {
                //las fechas son iguales
                return 0;
            }
        } catch (ParseException ex) {
            Logger.getLogger(ComparadorFechas.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }
}
