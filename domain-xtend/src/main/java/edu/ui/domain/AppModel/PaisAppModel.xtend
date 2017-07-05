package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Pais
import org.eclipse.xtend.lib.annotations.Accessors
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.TransactionalAndObservable
import edu.ui.domain.CarmenSan10.Mapamundi
import java.util.List
import java.util.ArrayList
import edu.ui.domain.Exceptions.FaltaAgregarLugaresException
import edu.ui.domain.Exceptions.FaltaAgregarCaracteristicasException
import edu.ui.domain.Exceptions.ElLugarYaFueAgregadoException

@Accessors
@TransactionalAndObservable
class PaisAppModel
{
	Pais pais
	
	List<Pais> paises
	
	List<LugarDeInteres> lugaresPosibles
	
	Caracteristicas carSeleccionada
	String textCaracteristica
	LugarDeInteres lugarSeleccionado
	LugarDeInteres lugarNuevoSeleccionado
	Pais paisDeConexSeleccionado
	Pais paisDeConexNuevoSeleccionado
	
	new(Mapamundi mapa, Pais pais) {
		this.pais = pais
		this.paises = mapa.paises
		
		// Cargo los lugares con las que cuento para el selector
		lugaresPosibles = new ArrayList<LugarDeInteres> ()
		lugaresPosibles.add(LugarDeInteres.BANCO)
		lugaresPosibles.add(LugarDeInteres.BIBLIOTECA) 
		lugaresPosibles.add(LugarDeInteres.CLUB) 
		lugaresPosibles.add(LugarDeInteres.EMBAJADA)
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
	
	def eliminarConexionSelecionada() 
	{
		pais.eliminarConexionAerea(paisDeConexSeleccionado)
		paisDeConexSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"paisesConexionAerea", pais)
	}
	
	def agregarConexionAerea() 
	{
		pais.agregarConexionSiPuede(paisDeConexNuevoSeleccionado)
		paisDeConexNuevoSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"paisesConexionAerea", pais)
	}
	
	def agregarLugarSeleccionado() 
	{
		pais.agregarLugarSiPuede(lugarNuevoSeleccionado)
		lugarNuevoSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"lugares", pais)
	}
	
	def validarEdicion() 
	{
		if (pais.lugares.size < 3)
			throw new FaltaAgregarLugaresException ("Un pais debe tener exactamente 3 lugares de interes.")
		if (pais.caracteristicaPais.size < 2)
			throw new FaltaAgregarCaracteristicasException ("Un pais debe tener al menos 2 características.")
	}
	
	
	
}