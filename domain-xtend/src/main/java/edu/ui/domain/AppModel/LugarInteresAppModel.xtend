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
	String tituloDelResultado
	String estadoFinalDelCaso
	String resumenFinal
	
	new(){}
	
	new(LugarDeInteres lugar, Caso caso, Detective doc)
	{
		this.lugar = lugar
		this.caso = caso
		this.detective = doc
		tituloDelResultado = ""
		estadoFinalDelCaso = ""
		resumenFinal = ""
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
	
	def casoResulto() 
	{
		tituloDelResultado = "En hora buena!!!"
		estadoFinalDelCaso = "Ha detenido a " + caso.responsable.nombre + " y recuperado la Tumba del Faraon"
		resumenFinal = "Felicitaciones!!!!"
	}
	
	def casoImpune() 
	{
		tituloDelResultado = "Malas noticias :("
		estadoFinalDelCaso = "Ha detenido a " + detective.ordenDeArresto + ", pero usted tenia una orden contra" + caso.responsable.nombre
		resumenFinal = "Lamentablemente este crimen quedará impune."
	}
	
	
}