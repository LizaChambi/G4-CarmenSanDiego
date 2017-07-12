package edu.ui.dominioXTrest

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.domain.CarmenSan10.Mapamundi

@Accessors
class PaisRest {
	
	String nombre
	Integer id
	
	new() {
		nombre = "" //ver si lo necesitamos
	}
	
	new(Integer identi, String name) {
		id = identi
		nombre = name
	}
	
	def maximizar(Mapamundi mapa, String nombre) {
		
		var pais_maxi = mapa.getPais(nombre)
		pais_maxi
	} 
}

@Accessors
class PaisConID {
	
	Integer id
	String nombre
	List<LugarDeInteres> lugares
	List<PaisRest> mini_conexiones
	
	new() {		
	}
	
	new(String nombrePais, List<LugarDeInteres> interes, Integer identi, List<PaisRest> rests) {
		id = identi
		nombre = nombrePais
		lugares = interes
		mini_conexiones = rests
	}
	
	def getConexionesIds() 
	{
		mini_conexiones.map[p | p.id].toList
	}
	
}

@Accessors
class PaisSinID {
	
	String nombre
	List<LugarDeInteres> lugares
	List<PaisRest> mini_conexiones
	
	new() {}
}