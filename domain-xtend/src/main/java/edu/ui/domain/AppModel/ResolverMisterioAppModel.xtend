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
import java.util.Observable

@Accessors
@TransactionalAndObservable
class ResolverMisterioAppModel 
{
	
	Expediente expediente
	Detective detective
	Caso caso
	
	Boolean enInicioDelJuego
	Pais paisSeleccionado
	Villano villanoSeleccionado
	String nombrePaisActual
	List<Pais> conexionesDelPaisActual
	List<Pais> paisesFallidos
	String paisesAcertados
	String ordenPara
	String estadoDeLaOrdenDeArresto
	String nombreDelCaso
	
	// trabajando con esto
	LugarDeInteres lugar1
	LugarDeInteres lugar2
	LugarDeInteres lugar3
	
	
	new(){}
	
	new(ACME acme, Mapamundi mapamundi) 
	{
		this.caso = acme.caso
		this.expediente = acme.villanos
		this.detective = acme.resolvedorDeCasos
		detective.viajarA(caso.planDeEscape.get(0))
		
		this.conexionesDelPaisActual = detective.ubicacionActual.paisesConexionAerea
		paisesFallidos = detective.destinosFallidos(caso.planDeEscape)
		paisesAcertados = listar(recorridoCriminal())
		nombrePaisActual = detective.nombreDelPaisActual.toUpperCase
		estadoDeLaOrdenDeArresto = "Sin emitir orden de arresto."
		ordenPara = ""
		nombreDelCaso = caso.objetoDelRobo
		lugar1 = detective.ubicacionActual.lugarDeInteres1 
		lugar2 = detective.ubicacionActual.lugarDeInteres2 
		lugar3 = detective.ubicacionActual.lugarDeInteres3 
	}
	
	def listar(List<String> paises) 
	{
		var resultado = ""
		if (paises.size>=1)
		{
			resultado = paises.get(0)
		}
		
		val paisesRes = paises.tail.toList
		
		for(p : paisesRes)
		{
			resultado = p + "<-" + resultado
		}
		
		resultado
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
	
	def getNombrePaisActual()
	{
		nombrePaisActual
	}
	
	def setNombrePaisActual(Pais pais)
	{
		nombrePaisActual = pais.nombrePais.toUpperCase
		ObservableUtils.firePropertyChanged(this, "nombrePaisActual", nombrePaisActual)
	}
	
	
	def regresarAlPaisAnterior() 
	{
		detective.regresarAlPaisAnterior
		
		if (detective.esInicioDelJuego)
		{
			enInicioDelJuego = null
		}
		
		setNombrePaisActual(detective.ubicacionActual)
		setConexionesDelPaisActual(detective.ubicacionActual.paisesConexionAerea)
		
	}
	
	def setConexionesDelPaisActual(List<Pais> conexiones)
	{
		conexionesDelPaisActual = conexiones
		ObservableUtils.firePropertyChanged(this, "conexionesDelPaisActual", conexionesDelPaisActual)
	}
	
	def setPaisesFallidos (List<Pais> paises)
	{
		paisesFallidos = paises
		ObservableUtils.firePropertyChanged(this, "paisesFallidos", paisesFallidos)
	}
	
	def setPaisesAcertados(String paises)
	{
		paisesAcertados = paises
		ObservableUtils.firePropertyChanged(this, "paisesAcertados", paisesAcertados)
	}
	
	def viajar()
	{
		detective.viajarA(paisSeleccionado)
		
		// activo el boton para regresar al pais anterior
		enInicioDelJuego = false
		
		// actualizo los valores en pantalla
		setNombrePaisActual(detective.ubicacionActual)
		setConexionesDelPaisActual(detective.ubicacionActual.paisesConexionAerea)
		setPaisesFallidos (detective.destinosFallidos(caso.planDeEscape))
		setPaisesAcertados (listar(recorridoCriminal()))
		
		lugar1 = detective.ubicacionActual.lugarDeInteres1 
		lugar2 = detective.ubicacionActual.lugarDeInteres2 
		lugar3 = detective.ubicacionActual.lugarDeInteres3
		
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
	
	def setOrdenPara(String nombre)
	{
		ordenPara = nombre
		ObservableUtils.firePropertyChanged(this, "ordenPara", ordenPara)
	}
	
	def setEstadoDeLaOrdenDeArresto(String estado)
	{
		estadoDeLaOrdenDeArresto = estado
		ObservableUtils.firePropertyChanged(this, "estadoDeLaOrdenDeArresto", estadoDeLaOrdenDeArresto)
	}
	
	def generarOrdenDeArrestoPara() 
	{
		detective.ordenarArresto(villanoSeleccionado)
		setOrdenPara(detective.ordenDeArresto)
		setEstadoDeLaOrdenDeArresto("Orden ya emitida: ")
	}
	
}