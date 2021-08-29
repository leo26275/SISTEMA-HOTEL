/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Habitacion;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoHabitacion {

    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idhabitacion;
    Habitacion habitacion = new Habitacion();

    public DaoHabitacion(Habitacion habitacion) {
        this.habitacion = habitacion;
    }

    public DaoHabitacion(int idhabitacion) {
        this.idhabitacion = idhabitacion;
    }

    public DaoHabitacion() {

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

    public void guardarHabitacion() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(habitacion);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarHabitacion(Habitacion habitacion) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(habitacion);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarHabitacion(Habitacion habitacion) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(habitacion);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Habitacion obtenerHabitacion() throws HibernateException {
        try {

            iniciaOperacion();
            habitacion = (Habitacion) ses.get(Habitacion.class, idhabitacion);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return habitacion;
    }

    public List<Habitacion> ObtenerlistaDeHabitaciones() throws HibernateException {

        List<Habitacion> listahabitaciones = null;
        try {
            iniciaOperacion();
            listahabitaciones = ses.createQuery("from Habitacion as h order by h.idhabitacion asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listahabitaciones;
    }

    public List<Habitacion> ObtenerlistaDeHabitacionesDisponibles() throws HibernateException {

        List<Habitacion> listahabitaciones = null;
        try {
            iniciaOperacion();
            listahabitaciones = ses.createQuery("from Habitacion as h where h.estado='Disponible' order by h.idhabitacion asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listahabitaciones;
    }

    /*Metodo para setear el estado de la habitacion*/
    public void actualizarestadohabitacion(Habitacion habitacion) {
        try {
            iniciaOperacion();
            Query query = ses.createQuery("update from Habitacion h set h.estado='No Disponible' where h.idhabitacion='" + habitacion.getIdhabitacion() + "'");
            ses.saveOrUpdate(query);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    /*consulta habitacion*/
    public List<Habitacion> habitacionesocupadas() throws HibernateException {

        List<Habitacion> listahabitaciones = null;
        try {
            iniciaOperacion();
            listahabitaciones = ses.createQuery("from Habitacion as h where estado ='Ocupada'").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listahabitaciones;
    }

    public List<Habitacion> habitacionesdisponibles() throws HibernateException {

        List<Habitacion> listahabitaciones = null;
        try {
            iniciaOperacion();
            listahabitaciones = ses.createQuery("from Habitacion as h where estado ='Disponible'").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listahabitaciones;
    }

    /*seteo del estado de la habitacion*/
    public void setearestadohabitacion(int idhabitacion) throws HibernateException {
        try {
            iniciaOperacion();
            String estado = "Ocupada";
            Query query = ses.createQuery("from Habitacion as h where h.idhabitacion= :idhabitacion");
            query.setParameter("idhabitacion", idhabitacion);
            Habitacion habitacion = (Habitacion) query.uniqueResult();

            /*seteando el estado de la habitacion en el id indicado*/
            habitacion.setEstado(estado);
            ses.save(habitacion);/*Guardamos el registro modificado en la base de datos de la habitacion que hemos indicado donde sea su id*/
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    /*seteo del estado de la habitacion cuando el cliente pague para poder volver a poner la habitacion disponible*/
    public void setearestadohabitacionpago(int idhabitacion) throws HibernateException {
        try {
            iniciaOperacion();
            String estado = "Disponible";
            Query query = ses.createQuery("from Habitacion as h where h.idhabitacion= :idhabitacion");
            query.setParameter("idhabitacion", idhabitacion);
            Habitacion habitacion = (Habitacion) query.uniqueResult();

            /*seteando el estado de la habitacion en el id indicado*/
            habitacion.setEstado(estado);
            ses.save(habitacion);/*Guardamos el registro modificado en la base de datos de la habitacion que hemos indicado donde sea su id*/
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }
    
    /*Habitaciones en mantenimiento*/
    public List<Habitacion> ObtenerlistaDeHabitacionesMantenimiento() throws HibernateException {

        List<Habitacion> listahabitaciones = null;
        try {
            iniciaOperacion();
            listahabitaciones = ses.createQuery("from Habitacion as h where h.estado='Mantenimiento' order by h.idhabitacion asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listahabitaciones;
    }

}
