/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Consumo;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoConsumo {
    
    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idconsumo;
    Consumo consumo = new Consumo();

    public DaoConsumo(Consumo consumo) {
        this.consumo = consumo;
    }

    public DaoConsumo(int idconsumo) {
        this.idconsumo = idconsumo;
    }

    public DaoConsumo() {

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

    public void guardarConsumo() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(consumo);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarConsumo(Consumo consumo) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(consumo);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarConsumo(Consumo consumo) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(consumo);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Consumo obtenerConsumo() throws HibernateException {
        try {

            iniciaOperacion();
            consumo = (Consumo) ses.get(Consumo.class, idconsumo);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return consumo;
    }

    public List<Consumo> ObtenerlistaDeConsumosInsertar() throws HibernateException {

        List<Consumo> listaconsumo = null;
        try {
            iniciaOperacion();
            listaconsumo = ses.createQuery("from Consumo as c join fetch c.producto as p join fetch c.reserva as r order by c.idconsumo asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaconsumo;
    }
    
    public List<Consumo> ObtenerlistaDeConsumosEstado() throws HibernateException {

        List<Consumo> listaconsumo = null;
        try {
            iniciaOperacion();
            listaconsumo = ses.createQuery("from Consumo as c join fetch c.producto as p join fetch c.reserva as r join fetch r.clientes as cl where r.estado='No Pagada' order by c.idconsumo asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaconsumo;
    }
}
