package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Pais
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
//import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.model.ObservableUtils
import edu.ui.domain.CarmenSan10.Mapamundi
import edu.ui.domain.Exceptions.FaltaAgregarLugaresException
import edu.ui.domain.Exceptions.FaltaAgregarCaracteristicasException

@Accessors
@Observable
class MapamundiAppModel{
	
	Mapamundi mapa
	Pais itemSeleccionado
	
	/**
	 * Todos los application model deben anotarse con @Observable.
	 * También es conveniente que implementen la interfaz Serializable.
	 */
	
	new() {}
	
	new(Mapamundi mapamundi) {
		mapa = mapamundi
	}
	
	def eliminarPaisSeleccionado() {
		mapa.borrarPais(itemSeleccionado)
		itemSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"paises", mapa)
	}
	
	def agregarPais(Pais nuevoPais) {
		mapa.agregarPais(nuevoPais)
	}
	
	
//	def List<String> getTodasLasCaracteristicas() {
//		itemSeleccionado.caracteristicaPais
//	}
	
	//def void setTodasLasCaracteristicas(List<String> feature) {}
	
	def getNombreCaracteristicas() {}
	
	def List<Pais> getTodasLasConexiones() {
		itemSeleccionado.paisesConexionAerea
	}
	
	def void setTodasLasConexiones(List<Pais> paises) {}
	
	def List<String> getNombreCoxiones() {
		itemSeleccionado.paisesConexionAerea.map[p| p.nombrePais]
	}
	
	def void setNombreCoxiones(List<String> nombresPaises) {}
	
	def agregarNuevoPais() 
	{
		mapa.agregarPaisSiPuede(itemSeleccionado)
		itemSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"paises", mapa)
	}
	
	def validarEdicion() 
	{
		if (itemSeleccionado.lugares.size < 3)
			throw new FaltaAgregarLugaresException ("Un pais debe tener exactamente 3 lugares de interes.")
		if (itemSeleccionado.caracteristicaPais.size < 2)
			throw new FaltaAgregarCaracteristicasException ("Un pais debe tener al menos 2 características.")
	}
	
}