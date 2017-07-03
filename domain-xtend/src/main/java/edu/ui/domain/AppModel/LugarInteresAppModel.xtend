package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Caso
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.ui.domain.CarmenSan10.Detective
import edu.ui.domain.CarmenSan10.LugarDeInteres

@Observable
@Accessors
class LugarInteresAppModel 
{
	LugarDeInteres lugar
	Caso caso
	Detective detective
	
	new(){}
	
	new(LugarDeInteres lugar, Caso caso, Detective doc)
	{
		this.lugar = lugar
		this.caso = caso
		this.detective = doc
	}
	
	def nombreDelCaso()
	{
		caso.objetoDelRobo
	}
	
	def nombreDelLugar()
	{
		lugar.nombre
	}
	
	def preguntarAlOcupante()
	{
		caso.mostrarPista(detective.ubicacionActual, lugar)
	}

	def ordenDeArresto()
	{
		detective.ordenDeArresto
	}
	
	// Pregunta si encontre al villano
	def esElFinDelJuego() 
	{
		caso.esElFinDelCaso(detective)
	}
	
	// Pregunta si el villano que encontre es al que le mande la orden de arresto (si gane o perdi el juego)
	def estaResuelto() 
	{
		caso.estaResuelto(detective)
	}
	
	
}