package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Pais
import java.io.Serializable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.TransactionalAndObservable
import edu.ui.domain.CarmenSan10.Mapamundi
import java.util.List
import java.util.ArrayList

@Accessors
@TransactionalAndObservable
class PaisAppModel{
	List<Pais> paises
	List<LugarDeInteres> lugaresPosibles
	Pais pais
	Caracteristicas carSeleccionada
	LugarDeInteres lugarSeleccionado
	Pais paisDeConexSeleccionado
	String textCaracteristica
	
	/**
	 * String nombrePais
	 * List<String> caracteristicaPais	
	 * List<LugarInteres> lugares	
	 * List<Pais> paisesConexionAerea
	 */
	
	new(Pais pais) {
		this.pais = pais
		// Cargo los lugares con las que cuento para el selector
		lugaresPosibles = new ArrayList<LugarDeInteres> ()
		lugaresPosibles.add(LugarDeInteres.BANCO)
		lugaresPosibles.add(LugarDeInteres.BIBLIOTECA) 
		lugaresPosibles.add(LugarDeInteres.CLUB) 
		lugaresPosibles.add(LugarDeInteres.EMBAJADA)
	}
	
	new(List<Pais> ps, Pais pais) {
		this.pais = pais
		this.paises = ps
	}
	
	def eliminarCaracteristicaSelecionada() 
	{
		pais.eliminarCaracteristica(carSeleccionada)
		carSeleccionada = null
		ObservableUtils.firePropertyChanged(this,"caracteristicaPais", pais)
	}
	
	def agregarCaracteristica() 
	{
		pais.agregarCaracteristica(new Caracteristicas(textCaracteristica))
		textCaracteristica = ""
		ObservableUtils.firePropertyChanged(this,"caracteristicaPais", pais)
	}
	
	def eliminarLugarSelecionado() 
	{
		pais.eliminarLugarDeInteres(lugarSeleccionado)
		lugarSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"lugares", pais)
	}
	
	def getEliminarConexionSelecionada() 
	{
		pais.eliminarConexionAerea(paisDeConexSeleccionado)
		paisDeConexSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"paisesConexionAerea", pais)
	}
	
	
	
}