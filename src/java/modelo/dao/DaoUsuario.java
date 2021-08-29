/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Usuarios;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoUsuario {
    
    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idusuario;
    Usuarios usuarios = new Usuarios();

    public DaoUsuario(Usuarios usuarios) {
        this.usuarios = usuarios;
    }

    public DaoUsuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public DaoUsuario() {

    }

    private void iniciaOperacion() throws HibernateException {
        sesfact = HibernateUtil.getSessionFactory();
        ses = sesfact.openSession();
        tra = ses.beginTransaction();
    }

    private void manejaExcepcion(HibernateException e) throws HibernateException {
        tra.rollback();
        throw new HibernateException("Ocurrio un error", e);

    }

    public void guardarUsuario() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(usuarios);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarUsuario(Usuarios usuarios) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(usuarios);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarUsuario(Usuarios usuarios) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(usuarios);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Usuarios obtenerUsuario() throws HibernateException {
        try {

            iniciaOperacion();
            usuarios = (Usuarios) ses.get(Usuarios.class, idusuario);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return usuarios;
    }

    public List<Usuarios> ObtenerlistaDeUsuarios() throws HibernateException {

        List<Usuarios> listausuarios = null;
        try {
            iniciaOperacion();
            listausuarios = ses.createQuery("from Usuarios as us join fetch us.empleado as emp join fetch emp.cargos as cr join fetch emp.usuarioses as usua order by us.idusuario asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listausuarios;
    }
   
}
