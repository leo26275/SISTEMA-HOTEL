/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Adicionales;

import modelo.dao.DaoUsuario;
import modelo.entidad.Usuarios;

/**
 *
 * @author leo_g
 */
public class ValidacionSesion {

    DaoUsuario daousuario = new DaoUsuario();
    Encriptacion encriptar = new Encriptacion();

    public ValidacionSesion() {
    }

    public Usuarios validasesion(String usuario, String password) {
String encri = Encriptacion.getStringMessageDigest(password, Encriptacion.MD5);
        for (Usuarios us : daousuario.ObtenerlistaDeUsuarios()) {

            if (us.getUsuario().equals(usuario) && us.getPassword().equals(encri)) {
                return us;
            }

        }

        return null;
    }

}
