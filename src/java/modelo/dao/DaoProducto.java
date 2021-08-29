/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Producto;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoProducto {

    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idproducto;
    Producto producto = new Producto();

    public DaoProducto(Producto producto) {
        this.producto = producto;
    }

    public DaoProducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public DaoProducto() {

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

    public void guardarProducto() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(producto);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarProducto(Producto producto) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(producto);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarProducto(Producto prpducto) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(prpducto);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Producto obtenerProducto() throws HibernateException {
        try {

            iniciaOperacion();
            producto = (Producto) ses.get(Producto.class, idproducto);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return producto;
    }

    public List<Producto> ObtenerlistaDeProductos() throws HibernateException {

        List<Producto> listaproductos = null;
        try {
            iniciaOperacion();
            listaproductos = ses.createQuery("from Producto as p join fetch p.categoria as c order by p.idproducto asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaproductos;
    }
    
    
    /*metodo para las consultas*/
    
    public List<Producto> ObtenerlistaDeProductosconsultas() throws HibernateException {

        List<Producto> listaproductos = null;
        try {
            iniciaOperacion();
            listaproductos = ses.createQuery("from Producto as p join fetch p.categoria as c order by p.idproducto asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaproductos;
    }
}
