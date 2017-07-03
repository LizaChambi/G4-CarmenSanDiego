package edu.ui.domain.CarmenSan10;

import org.uqbar.commons.utils.TransactionalAndObservable;
import edu.ui.domain.CarmenSan10.LugarDeInteres;

@TransactionalAndObservable
public enum LugarDeInteres {

	BANCO("Banco"),BIBLIOTECA("Biblioteca"),CLUB("Club"),EMBAJADA("Embajada");
	
	//vacio?
	
	public String nombre;
	
	LugarDeInteres(String nombre) {
		this.nombre = nombre;
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getNombreLugares() {
		return this.getNombre();
	}

}
