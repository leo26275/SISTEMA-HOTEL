/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Pago;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoPago {
    
    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idpago;
    Pago pago = new Pago();

    public DaoPago(Pago pago) {
        this.pago = pago;
    }

    public DaoPago(int idpago) {
        this.idpago = idpago;
    }

    public DaoPago() {

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

    public void guardarPago() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(pago);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarPago(Pago pago) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(pago);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarPago(Pago pago) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(pago);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Pago obtenerPago() throws HibernateException {
        try {

            iniciaOperacion();
            pago = (Pago) ses.get(Pago.class, idpago);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return pago;
    }

    /*para insertar el registro del id*/
    public List<Pago> ObtenerlistaDePago() throws HibernateException {

        List<Pago> listaDePago = null;
        try {
            iniciaOperacion();
            listaDePago = ses.createQuery("from Pago as p join fetch p.reserva as r join fetch r.clientes as cl join fetch r.habitacion as habi order by p.idpago asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaDePago;
    }
    
    /*cargando solo reservas no pagadas*/
}
