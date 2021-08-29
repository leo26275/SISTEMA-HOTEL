/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import HibernateUtil.HibernateUtil;
import java.util.List;
import modelo.entidad.Categoria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author leo_g
 */
public class DaoCategoria {
    private SessionFactory sesFact;
    private Session ses;
    private Transaction tra;
    
    private Integer id_categoria;
    private int filasAfectadas;
    
    Categoria categoria = new Categoria();
    
    public DaoCategoria(Categoria categoria){
        this.categoria = categoria;
    }
    
    public DaoCategoria(int id_categoria){
        this.id_categoria = id_categoria;
    }
    
    public DaoCategoria(){
        
    }
    
    private void iniciaOperacion() throws HibernateException{
        sesFact = HibernateUtil.getSessionFactory();
        ses = sesFact.openSession();
        tra = ses.beginTransaction();
    }
    
    private void manejaException(HibernateException he) throws HibernateException{
        tra.rollback();
        throw new HibernateException("Ocurrio un error en la capa de acceso a datos", he);
    }
    
    public void guardarCategoria() throws HibernateException{
        try{
            iniciaOperacion();
            ses.save(categoria);
            tra.commit();
        }catch(HibernateException he){
            manejaException(he);
            throw he;
        }finally{
            ses.close();
        }
    }
    
    public void actualizarCategoria(Categoria categoria) throws HibernateException{
        try{
            iniciaOperacion();
            ses.update(categoria);
            tra.commit();
        }catch(HibernateException he){
            manejaException(he);
            throw he;
        }finally{
            ses.close();
        }
    }
    
    public void eliminarCategoria(Categoria categoria) throws HibernateException{
        try{
            iniciaOperacion();
            ses.delete(categoria);
            tra.commit();
        }catch(HibernateException he){
            manejaException(he);
            throw he;
        }finally{
            ses.close();
        }
    }
    
    public Categoria obtenerCategoria() throws HibernateException{
        try{
            iniciaOperacion();
            categoria = (Categoria) ses.get(Categoria.class, id_categoria);
        }catch(HibernateException he){
            manejaException(he);
            throw he;
        }finally{
            ses.close();
        }
        return categoria;
    }
    
    public List<Categoria> ObtenerlistaDeCategorias() throws HibernateException{
        List<Categoria> listaDeCategorias = null;
        try{
            iniciaOperacion();
            listaDeCategorias = ses.createQuery("from Categoria c order by c.idcategoria asc").list();
        }catch(HibernateException he){
            manejaException(he);
            throw he;
        }finally{
            ses.close();
        }
        return listaDeCategorias;
    } 
}
