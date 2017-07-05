package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Villano
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.ApplicationContext
import java.io.Serializable
import org.uqbar.commons.utils.Observable
import edu.ui.domain.CarmenSan10.Expediente
import edu.ui.domain.Exceptions.FaltaAgregarSeniasException
import edu.ui.domain.Exceptions.FaltaAgregarHabbiesException
import org.uqbar.commons.model.ObservableUtils

@Accessors
@Observable
class ExpedienteAppModel implements Serializable {
	
	Expediente expediente
	Villano villanoSeleccionado
	String nombreDelCaso
	
	new(Expediente expediente, String caso) 
	{
		this.expediente = expediente
		this.nombreDelCaso = caso
	}
	
	new(Expediente expediente) 
	{
		this.expediente = expediente
	}
	
	new(Expediente expediente, Villano villano) 
	{
		this.expediente = expediente
		this.villanoSeleccionado = villano
	}
	
	def validarEdicion() 
	{
		if (villanoSeleccionado.seniasParticulares.size() <2)
			throw new FaltaAgregarSeniasException ("El villano debe tener al menos 2 señas particulares.")
		if (villanoSeleccionado.hobbies.size() <1)
			throw new FaltaAgregarHabbiesException ("El villano debe tener al menos 1 hobbie.")
	}
	
	def agregarNuevoVillano() 
	{
		expediente.agregarVillanoSiPuede(villanoSeleccionado)
		villanoSeleccionado = null
		ObservableUtils.firePropertyChanged(this,"villanos", expediente)
	}
	
}