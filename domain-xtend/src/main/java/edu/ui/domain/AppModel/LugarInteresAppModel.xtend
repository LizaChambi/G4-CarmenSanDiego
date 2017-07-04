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
	String estadoBoton
	
	new(){}
	
	new(LugarDeInteres lugar, Caso caso, Detective doc)
	{
		this.lugar = lugar
		this.caso = caso
		this.detective = doc
		tituloDelResultado = ""
		estadoFinalDelCaso = ""
		resumenFinal = ""
		estadoBoton = ""
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
		detective.pedirPista(caso, lugar)
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
		estadoBoton = "Disfrutar de nuestra victoria"
	}
	
	def casoImpune() 
	{
		tituloDelResultado = "Malas noticias :("
		estadoFinalDelCaso = "Ha detenido a " +  caso.responsable.nombre + ", pero usted tenia una orden contra" + detective.ordenDeArresto
		resumenFinal = "Lamentablemente este crimen quedará impune."
		estadoBoton = "Aceptar el error cometido"
	}
	
	
}