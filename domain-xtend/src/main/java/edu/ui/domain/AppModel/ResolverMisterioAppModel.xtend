package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Detective
import edu.ui.domain.CarmenSan10.Caso
import edu.ui.domain.CarmenSan10.ACME
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.CarmenSan10.Villano
import edu.ui.domain.CarmenSan10.LugarInteres

class ResolverMisterioAppModel 
{
	ACME acme
	Pais paisSeleccionado
	Villano villanoSeleccionado
	
	new(){}
	
	new(ACME acme)
	{
		this.acme = acme
	}
	
	def getCaso()
	{
		acme.caso
	}
	
	def getDetective()
	{
		acme.resolvedorDeCasos
	}
	
	def getExpediente()
	{
		acme.villanos
	}
	
	def nombrePaisActual()
	{
		getDetective.nombreDelPaisActual
	}
	
	def nombreDelCaso()
	{
		acme.nombreDelCaso
	}
	
	def ordenDeArresto()
	{
		acme.detectiveEnviarOrdenDeArresto
	}
	
	def regresarAlPaisAnterior() 
	{
		acme.detectiveRegresarAlPaisAnterior
	}
	
	def viajar()
	{
		acme.detectiveViajaA(paisSeleccionado)
	}
	
	def LugarInteres el1erLugarDeInteres() {
		// devuelve el 1er lugar de interes
	}
	
	def LugarInteres el2erLugarDeInteres() 
	{
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def LugarInteres el3erLugarDeInteres() 
	{
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}