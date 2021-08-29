/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Cargos;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Sony
 */
public class DaoCargo {

    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idcargo;
    Cargos cargo = new Cargos();

    public DaoCargo(Cargos cargo) {
        this.cargo = cargo;
    }

    public DaoCargo(int idcargo) {
        this.idcargo = idcargo;
    }

    public DaoCargo() {

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

    public void guardarCargo() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(cargo);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarCargo(Cargos cargo) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(cargo);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarCargo(Cargos cargo) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(cargo);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Cargos obtenerCargo() throws HibernateException {
        try {

            iniciaOperacion();
            cargo = (Cargos) ses.get(Cargos.class, idcargo);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return cargo;
    }

    public List<Cargos> ObtenerlistaDeCargos() throws HibernateException {

        List<Cargos> listaDeCargos = null;
        try {
            iniciaOperacion();
            listaDeCargos = ses.createQuery("from Cargos as c order by c.idcargo asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaDeCargos;
    }
}
