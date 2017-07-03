package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.ACME
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.CarmenSan10.Villano
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.domain.CarmenSan10.Detective
import edu.ui.domain.CarmenSan10.Caso
import edu.ui.domain.CarmenSan10.Expediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.TransactionalAndObservable
import edu.ui.domain.CarmenSan10.Mapamundi
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.commons.model.ObservableUtils
import java.util.List

@Accessors
@TransactionalAndObservable
class ResolverMisterioAppModel 
{
	Mapamundi mapa
	Expediente expediente
	Detective detective
	Caso caso
	Pais paisSeleccionado
	Villano villanoSeleccionado
	List<Pais> paisesFallidos
	List<Pais> paisesAcertados
	String nombrePaisActual
	String ordenPara
	String nombreDelCaso
	LugarDeInteres lugar1
	LugarDeInteres lugar2
	LugarDeInteres lugar3
	
	
	new(){}
	
	new(ACME acme, Mapamundi mapamundi) 
	{
		this.mapa = mapamundi
		this.caso = acme.caso
		this.expediente = acme.villanos
		this.detective = acme.resolvedorDeCasos
		detective.viajarA(caso.planDeEscape.get(0))
		
		// inicializacion de propiedades (es necesario? :/)
		paisesFallidos = detective.destinosFallidos(caso.planDeEscape)
		nombrePaisActual = detective.nombreDelPaisActual
		ordenPara = ""
		nombreDelCaso = caso.objetoDelRobo
		lugar1 = detective.ubicacionActual.lugarDeInteres1 
		lugar2 = detective.ubicacionActual.lugarDeInteres2 
		lugar3 = detective.ubicacionActual.lugarDeInteres3 
	}
	
	def tituloDelCaso()
	{
		caso.objetoDelRobo
	}
	
	def getCaso()
	{
		caso
	}
	
	def getDetective()
	{
		detective
	}
	
	def getExpediente()
	{
		expediente
	}
	
	def nombrePaisActual()
	{
		detective.nombreDelPaisActual
	}
	
	def regresarAlPaisAnterior() 
	{
		detective.regresarAlPaisAnterior
	}
	
	def viajar()
	{
		detective.viajarA(paisSeleccionado)
		// Actualizo
		nombrePaisActual = detective.nombreDelPaisActual
		paisesFallidos = detective.destinosFallidos(caso.planDeEscape)
		paisesAcertados = detective.paisesVisitados(caso.planDeEscape)
		lugar1 = detective.ubicacionActual.lugarDeInteres1 
		lugar2 = detective.ubicacionActual.lugarDeInteres2 
		lugar3 = detective.ubicacionActual.lugarDeInteres3 
		ObservableUtils.firePropertyChanged(this, "nombrePaisActual", nombrePaisActual)
		ObservableUtils.firePropertyChanged(this, "lugar1", lugar1)
		ObservableUtils.firePropertyChanged(this, "lugar2", lugar2)
		ObservableUtils.firePropertyChanged(this, "lugar3", lugar3)
	}
	
	def recorridoCriminal()
	{
		val nombresDeLosPaises = detective.paisesVisitados(caso.planDeEscape)
		
		nombresDeLosPaises.map[p | p.nombrePais].toList
	}
	
	def reporteDelActoCriminal() 
	{
		caso.reporteDelActoCriminal
	}
	
	def nombreDel1erLugarInteres() 
	{
		lugar1.nombre
	}
	
	def nombreDel2doLugarInteres() 
	{
		lugar2.nombre
	}
	
	def nombreDel3erLugarInteres() 
	{
		lugar3.nombre
	}
	
	def generarOrdenDeArrestoPara() 
	{
		detective.ordenarArresto(villanoSeleccionado)
		ordenPara = detective.ordenDeArresto
		ObservableUtils.firePropertyChanged(this, "ordenDeArresto", detective)
	}
	
}