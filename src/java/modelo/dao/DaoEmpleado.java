/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Empleado;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoEmpleado {
    
    private SessionFactory sesfact;
    private Session ses;
    private Transaction tra;

    private Integer idempleado;
    Empleado empleado = new Empleado();

    public DaoEmpleado(Empleado empleado) {
        this.empleado = empleado;
    }

    public DaoEmpleado(int idempleado) {
        this.idempleado = idempleado;
    }

    public DaoEmpleado() {

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

    public void guardarEmpleado() throws HibernateException {
        try {
            iniciaOperacion();
            ses.save(empleado);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public void actualizarEmpleado(Empleado emppleado) throws HibernateException {
        try {
            iniciaOperacion();
            ses.update(empleado);
            tra.commit();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
    }

    public void eliminarEmpleado(Empleado empleado) throws HibernateException {
        try {
            iniciaOperacion();
            ses.delete(empleado);
            tra.commit();

        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }

    }

    public Empleado obtenerEmpleado() throws HibernateException {
        try {

            iniciaOperacion();
            empleado = (Empleado) ses.get(Empleado.class, idempleado);
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return empleado;
    }

    public List<Empleado> ObtenerlistaDeEmpleado() throws HibernateException {

        List<Empleado> listaempleados = null;
        try {
            iniciaOperacion();
            listaempleados = ses.createQuery("from Empleado as e join fetch e.cargos as c order by e.idempleado asc").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaempleados;
    }
    
    /*EMPLEADOS QUE  TIENEN USUARIOS ASIGNADOS
    este metodo se utilizara para que si un empleado ya tiene usuario no pueda ingresar otro
    */
    public List<Empleado> ObtenerlistaDeEmpleadoconUsuarios() throws HibernateException {

        List<Empleado> listaempleados = null;
        try {
            iniciaOperacion();
            listaempleados = ses.createQuery("from Empleado as emp join fetch emp.cargos as crg where exists(from Usuarios as us where emp.idempleado=us.empleado.idempleado)").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaempleados;
    }
    
    
    /*metodo para agregar usuarios segun sea cargo gerente recepcionista secretaria*/
     public List<Empleado> ObtenerlistaDeEmpleadoUsuarios() throws HibernateException {

        List<Empleado> listaempleados = null;
        try {
            iniciaOperacion();
            listaempleados = ses.createQuery("from Empleado as emp join fetch emp.cargos as crg where exists(from Usuarios as us where emp.idempleado=us.empleado.idempleado) and crg.nombre like '%Gerente%' or crg.nombre like '%Recepcionista%' or crg.nombre like '%Secretaria%' or crg.nombre like '%Ordenanza%'").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaempleados;
    }
     
     
     /*arreglo de consultas*/
     public List<Empleado> empleadoscargos() throws HibernateException {

        List<Empleado> listaempleados = null;
        try {
            iniciaOperacion();
            listaempleados = ses.createQuery("from Empleado as e join fetch e.cargos as c").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaempleados;
    }
     
    public List<Empleado> empleadossinuser() throws HibernateException {

        List<Empleado> listaempleados = null;
        try {
            iniciaOperacion();
            listaempleados = ses.createQuery("from Empleado as e join fetch e.cargos as c where not exists(from Usuarios u where u.empleado=e.idempleado)").list();
        } catch (HibernateException e) {
            manejaExcepcion(e);
            throw e;
        } finally {
            ses.close();
        }
        return listaempleados;
    } 
     
}
