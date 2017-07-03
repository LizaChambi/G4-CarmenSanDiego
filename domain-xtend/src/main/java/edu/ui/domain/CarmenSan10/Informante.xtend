package edu.ui.domain.CarmenSan10

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Random
import java.util.List

@Observable
@Accessors
class Informante extends Ocupante {

	new(){
		// agregue nombre al informante cuando se crea uno nuevo
		nombre = "Informante"
	}	

	override responderAlDetective(Caso caso, LugarDeInteres unLugar, Pais paisActual) 
	{	
		switch(unLugar)
		{
			case LugarDeInteres.BANCO : responderAlBanco(caso, paisActual)
			case LugarDeInteres.BIBLIOTECA : responderALaBiblioteca(caso, paisActual)
			case LugarDeInteres.CLUB : responderAlClub(caso)
			case LugarDeInteres.EMBAJADA : responderALaEmbajada(caso, paisActual)
		}
	}
	
	def responderALaEmbajada(Caso caso, Pais paisActual)
	{
		// 2 pistas del destino del villano
		val proximoPais = caso.proximoDestino(paisActual)
		proximoPais.dar2PistaDeSusCaracteristicas
	}
	
	def responderAlClub(Caso caso)
	{
		caso.responsable.dar2PistasSeniasParticulares + " " + informacionAdicional(caso, 70)
		// 2 señas particulares									// 70% 1 hobbie
	}
	
	def responderAlBanco(Caso caso, Pais paisActual)
	{
		val proximoPais = caso.proximoDestino(paisActual)
		proximoPais.pistaDeSusCaracteristicas + " " + caso.responsable.pistaDeSeniasParticulares
		// 1 pais destino								// 1 señas particulares
	}
	
	def responderALaBiblioteca(Caso caso, Pais paisActual) 
	{
		responderAlBanco(caso, paisActual) + " " + informacionAdicional(caso, 50)
		// lo mismo del banco						// 50% 1 hobbies
	}
	
	def informacionAdicional(Caso caso, int porcentaje) 
	{
		var Random rnd = new Random
		var int adicional = rnd.nextInt(99)
		
		var respuesta = ""
		
		if (adicional > (porcentaje-1))
		{
			respuesta = pistaSobreHobbie(caso.responsable)
		}
		respuesta
	}
	
	def pistaSobreHobbie(Villano villano) 
	{
		villano.pistaDeHobbies
	}
	
	override actualizar(List<Pais> ps, Pais p, Villano v) 
	{

	}
	
}
