/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Clientes;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoCliente {
    
    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idcliente;
    Clientes clientes = new Clientes();

    public DaoCliente(Clientes clientes) {
        this.clientes = clientes;
    }

    public DaoCliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public DaoCliente() {

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

    public void guardarCliente() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(clientes);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarClientes(Clientes clientes) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(clientes);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarClientes(Clientes clientes) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(clientes);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Clientes obtenerCliente() throws HibernateException {
        try {

            iniciaOperacion();
            clientes = (Clientes) ses.get(Clientes.class, idcliente);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return clientes;
    }

    public List<Clientes> ObtenerlistaDeClientes() throws HibernateException {

        List<Clientes> listadoclientes = null;
        try {
            iniciaOperacion();
            listadoclientes = ses.createQuery("from Clientes as c order by c.idcliente asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listadoclientes;
    }
}
