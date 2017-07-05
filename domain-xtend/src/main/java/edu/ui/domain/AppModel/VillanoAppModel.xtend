package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Villano
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class VillanoAppModel 
{
	Villano villano
	
	Caracteristicas seniaSeleccionada
	String textNuevaSenia
	
	Caracteristicas hobbieSeleccionado
	String textNuevoHobbie
	
	new(Villano villano) 
	{
		this.villano = villano
	}
	
	def eliminarSeniaSelecionada() 
	{
		villano.borrarSenia(seniaSeleccionada)
		seniaSeleccionada = null
		ObservableUtils.firePropertyChanged(this,"seniasParticulares", villano)
	}
	
	def agregarSenia() 
	{
		villano.agregarSeniaSiPuede(new Caracteristicas(textNuevaSenia))
		textNuevaSenia = ""
		ObservableUtils.firePropertyChanged(this,"seniasParticulares", villano)
	}
	
	def eliminarHobbieSelecionado() 
	{
		villano.borrarHobbie(hobbieSeleccionado)
		hobbieSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"hobbies", villano)
	}
	
	def agregarHobbie() 
	{
		villano.agregarHobbieSiPuede(new Caracteristicas(textNuevoHobbie))
		textNuevoHobbie = ""
		ObservableUtils.firePropertyChanged(this,"hobbies", villano)
	}
	
}