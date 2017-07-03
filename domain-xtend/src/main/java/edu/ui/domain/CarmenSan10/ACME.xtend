package edu.ui.domain.CarmenSan10

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class ACME 
{
	Expediente villanos
	Detective resolvedorDeCasos
	Caso caso
	
	new() {}
	
	/**
	 * @Propósito Crea a ACME con villlanos y un resolvedor de casos.
	 * @param expediente Son todos los villanos registrados en ACME.
	 * @param resolvedor Es el Detective encargado de perseguir a los villanos.
	 */
	new (Expediente expediente, Detective resolvedor) 
	{
		villanos = expediente
		resolvedorDeCasos = resolvedor
	}
	
	new (Expediente expediente, Detective resolvedor, Caso caso) 
	{
		villanos = expediente
		resolvedorDeCasos = resolvedor
		this.caso = caso
	}
	
	/*
	new(Detective resolvedor) { Preguntaar
		expedientes = new ArrayList<Villano>()
		resolvedorDeCasos = resolvedor
	}
	 */
	 
	/**
	 * @Propósito Agrega un Villano a la base de datos de ACME solo si no fue cargado anteriormente.
	 * @param VillanoAAgregar Es el Villano que se intenta agrega a la base de datos de ACME.
	 */
	def void agregarVillanoSiPuede (Villano villanoAAgregar)
	{
		villanos.agregarVillanoSiPuede(villanoAAgregar)
	}
	
	/**
	 * @Propósito Pregunta si el villano existe en la base de datos de ACME.
	 * @param unNombre Es el nombre del Villano por el que se hace la verificacion.
	 */
	def elVillanoYaExiste (String unNombre) 
	{
		villanos.elVillanoYaExiste(unNombre)
	}
	
	/**
	 * @Propósito Agrega un villano a la base de datos de ACME.
	 * @param villanoAAgregar Es el Villano que se agrega a la base de datos de ACME.
	 */
	def void agregarVillano (Villano villanoAAgregar)
	{
		villanos.agregarVillano(villanoAAgregar)
	}
	
	/**
	 * @Propósito Busca un villano a la base de datos de ACME.
	 * @param unNombre Es el nombre del Villano que se quiere buscar en la base de datos de ACME.
	 */
	def buscarVillano (String unNombre)
	{
		villanos.buscarVillano(unNombre)
	}
	
	def nombreDelCaso() 
	{
		caso.objetoDelRobo
	}
	
	def detectiveEnviarOrdenDeArresto() 
	{
		resolvedorDeCasos.ordenDeArresto
	}
	
	def detectiveRegresarAlPaisAnterior() 
	{
		resolvedorDeCasos.regresarAlPaisAnterior
	}
	
	def detectiveViajaA(Pais pais) 
	{
		resolvedorDeCasos.viajarA(pais)
	}
	
	def nombreDeLosVillanos() 
	{
		villanos.nombreDeLosVillanos()
	}
	
	def nombreDelPaisActual() 
	{
		resolvedorDeCasos.nombreDelPaisActual
	}
	
}