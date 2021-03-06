package modelo.entidad;
// Generated 15/04/2019 12:56:10 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Categoria generated by hbm2java
 */
public class Categoria  implements java.io.Serializable {


     private int idcategoria;
     private String nombre;
     private Set productos = new HashSet(0);

    public Categoria() {
    }

    public Categoria(int idcategoria, String nombre) {
        this.idcategoria = idcategoria;
        this.nombre = nombre;
    }

	
    public Categoria(int idcategoria) {
        this.idcategoria = idcategoria;
    }
    public Categoria(int idcategoria, String nombre, Set productos) {
       this.idcategoria = idcategoria;
       this.nombre = nombre;
       this.productos = productos;
    }
   
    public int getIdcategoria() {
        return this.idcategoria;
    }
    
    public void setIdcategoria(int idcategoria) {
        this.idcategoria = idcategoria;
    }
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public Set getProductos() {
        return this.productos;
    }
    
    public void setProductos(Set productos) {
        this.productos = productos;
    }




}


