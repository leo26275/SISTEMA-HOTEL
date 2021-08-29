/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Cargos;
import modelo.entidad.Reserva;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoReserva {

    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idreserva;
    Reserva reserva = new Reserva();

    public DaoReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public DaoReserva(int idreserva) {
        this.idreserva = idreserva;
    }

    public DaoReserva() {

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

    public void guardarReserva() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(reserva);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarReserva(Reserva reserva) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(reserva);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarReserva(Reserva reserva) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(reserva);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Reserva obtenerReserva() throws HibernateException {
        try {

            iniciaOperacion();
            reserva = (Reserva) ses.get(Reserva.class, idreserva);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return reserva;
    }

    public List<Reserva> ObtenerlistaDeReservas() throws HibernateException {

        List<Reserva> lisreservas = null;
        try {
            iniciaOperacion();
            lisreservas = ses.createQuery("from Reserva as r join fetch r.clientes as cl join fetch r.empleado as em join fetch r.habitacion as ha order by r.idreserva asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return lisreservas;
    }

    public int reservasdia() throws HibernateException {
        int totales = 0;

        try {
            iniciaOperacion();
            Query query = ses.createQuery("select r.idreserva from Reserva as r where r.fechareserva=CURRENT_DATE");
            List<Integer> listareservas = query.list();
            totales = listareservas.size();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

        return totales;
    }

    public Double ingresosdia() throws HibernateException {
        double total = 0;

        try {
            iniciaOperacion();
            Query query = ses.createQuery("select (((r.fechasalida)-(r.fechaingresada))*h.preciodiario)as totalmontodia from Reserva as r join r.habitacion as h where r.estado='Pagada' and r.fechareserva=CURRENT_DATE order by r.idreserva asc");
            List<Double> listatotales = query.list();
            for (int i = 0; i < listatotales.size(); i++) {
                total += listatotales.get(i);
            }
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return total;
    }

    /*codigo no utilizado para pagos de habitaciones*/
    public List<Double> totalpagarhabitaciones() throws HibernateException {
        List<Double> listatotales = null;
        try {
            iniciaOperacion();
            Query query = ses.createQuery("select (((r.fechasalida)-(r.fechaingresada))*h.preciodiario)as totalpago \n"
                    + "from Reserva as r join r.habitacion as h \n"
                    + "where r.estado='No Pagada' order by r.idreserva asc");
            listatotales = query.list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listatotales;
    }

    public int reservasnopagadas() throws HibernateException {
        int tot = 0;
        try {
            iniciaOperacion();
            Query query = ses.createQuery("select r.idreserva from Reserva as r join r.habitacion as h where r.estado='No Pagada' order by r.idreserva asc");
            List<Integer> listareservasnopagadas = query.list();
            tot = listareservasnopagadas.size();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

        return tot;
    }

    /*Metodo para cargar las reservas que aun no estan pagadas con todos sus datos*/
    public List<Reserva> listacomboreservas() throws HibernateException {

        List<Reserva> lisreservas = null;
        try {
            iniciaOperacion();
            lisreservas = ses.createQuery("from Reserva as r join fetch r.clientes as cl join fetch r.habitacion as h where r.estado='No Pagada' order by r.idreserva asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return lisreservas;
    }

    /*metodo para las consultas*/
    public List<Reserva> informacionreservas() throws HibernateException {

        List<Reserva> lisreservas = null;
        try {
            iniciaOperacion();
            lisreservas = ses.createQuery("from Reserva as r  join fetch r.clientes as c join fetch r.habitacion as h join fetch r.empleado as emp").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return lisreservas;
    }

    /*seteo el estado de pago de la reserva cuando se pague se ejecutara este metodo haciendo constar que esa reserva ha sido pagada asumiendo que el cliente
    se retirara en su fecha de salida*/
    public void setearestadopagoreserva(int idreserva) throws HibernateException {
        try {
            iniciaOperacion();
            String estado = "Pagada";
            Query query = ses.createQuery("from Reserva as r where r.idreserva= :idreserva");
            query.setParameter("idreserva", idreserva);
            Reserva reserva = (Reserva) query.uniqueResult();

            /*seteando el estado de la habitacion en el id indicado*/
            reserva.setEstado(estado);
            ses.save(reserva);/*Guardamos el registro modificado en la base de datos de la habitacion que hemos indicado donde sea su id*/
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }
    
    /*obteniendo listado reserva canceladas*/
public List<Reserva> ObtenerlistaDeReservasCanceladas() throws HibernateException {

        List<Reserva> lisreservas = null;
        try {
            iniciaOperacion();
            lisreservas = ses.createQuery("from Reserva as r join fetch r.clientes as cl join fetch r.empleado as em join fetch r.habitacion as ha where r.estado='Cancelada' order by r.idreserva asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return lisreservas;
    }

/*con este metodo podremos cancelar reservas que no han sido pagadas*/
public void setearestadocancelarreserva(int idreserva,String estadoreserva) throws HibernateException {
        try {
            iniciaOperacion();
            String estado = estadoreserva;
            Query query = ses.createQuery("from Reserva as r where r.idreserva= :idreserva");
            query.setParameter("idreserva", idreserva);
            Reserva reserva = (Reserva) query.uniqueResult();

            /*seteando el estado de la habitacion en el id indicado*/
            reserva.setEstado(estado);
            ses.save(reserva);/*Guardamos el registro modificado en la base de datos de la habitacion que hemos indicado donde sea su id*/
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }
}
