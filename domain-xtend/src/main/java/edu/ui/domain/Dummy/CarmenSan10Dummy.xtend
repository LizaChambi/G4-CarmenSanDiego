package edu.ui.domain.Dummy

import edu.ui.domain.CarmenSan10.Villano
import edu.ui.domain.CarmenSan10.Caracteristicas
import java.util.ArrayList
import edu.ui.domain.CarmenSan10.Mapamundi
import edu.ui.domain.CarmenSan10.Expediente
import org.eclipse.xtend.lib.annotations.Accessors
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.domain.CarmenSan10.Caso
import edu.ui.domain.CarmenSan10.Detective
import java.util.List

@Accessors
class CarmenSan10Dummy 
{
	Mapamundi mapamundi
	Expediente expediente
	Detective doc
	Caso caso
	
	new ()
	{
		/**
		 * Mapamundi - Paises
		 */	
		mapamundi = new Mapamundi
		
		// diff entre val y var?
		val venezuela = new Pais("Venezuela", #[LugarDeInteres.EMBAJADA, LugarDeInteres.BIBLIOTECA, LugarDeInteres.CLUB], new ArrayList<Pais>())
		venezuela.caracteristicaPais = #[new Caracteristicas("Maduro a la cabeza"), new Caracteristicas("Su lider cosmico supremo habla con los pajaritos")]
		
		
		val brazil = new Pais("Brazil", #[LugarDeInteres.EMBAJADA, LugarDeInteres.BANCO, LugarDeInteres.CLUB], #[venezuela]) => [
			caracteristicaPais = #[new Caracteristicas("Se habla portugues"), new Caracteristicas("Su bandera es verde y amarilla")]
		]
		
		val uruguay = new Pais("Uruguay", #[LugarDeInteres.BANCO, LugarDeInteres.BIBLIOTECA, LugarDeInteres.CLUB], #[venezuela, brazil]) => [
			caracteristicaPais = #[new Caracteristicas("A toda hora mate"), new Caracteristicas("Es una una provincia de Argentina")]
		]
		
		val argentina = new Pais("Argentina", #[LugarDeInteres.EMBAJADA, LugarDeInteres.BIBLIOTECA, LugarDeInteres.BANCO], #[venezuela, brazil, uruguay]) => [
			caracteristicaPais = #[new Caracteristicas("Bandera azul y blanca"), new Caracteristicas("Su arbol nacional es el Ceibo")]
		]
		
		mapamundi.setPaisMini(venezuela) // id = 1
		mapamundi.setPaisMini(brazil)	 // id = 2
		mapamundi.setPaisMini(argentina) // id = 3
		mapamundi.setPaisMini(uruguay)	 // id = 4
		
		
		/**
		 * Expediente - Villanos
		 */
		
		val seniasParticularesCS = new ArrayList<Caracteristicas>()
		val seniaCS1 = new Caracteristicas("Pelo rojo")
		val seniaCS2 = new Caracteristicas("Maneja un convertible")
		seniasParticularesCS.add(seniaCS1)
		seniasParticularesCS.add(seniaCS2)
		
		val hobbiesCS = new ArrayList<Caracteristicas>()
		val hobbieCS = new Caracteristicas("Juega tenis")
		hobbiesCS.add(hobbieCS)
		
		//val villanoCS = new Villano("Carmen Sandiego", "Femenino", seniasParticularesCS, hobbiesCS)
		
		val villanoCS = new Villano => [
			nombre = "Carmen Sandiego"
			sexo = "Femenino"
			seniasParticulares = seniasParticularesCS
			hobbies = hobbiesCS
		]
		
		val seniasParticularesII = new ArrayList<Caracteristicas>()
		val seniaII1 = new Caracteristicas("Pelo rubio")
		val seniaII2 = new Caracteristicas("Maneja un descapotable")
		seniasParticularesII.add(seniaII1)
		seniasParticularesII.add(seniaII2)
		
		val hobbiesII = new ArrayList<Caracteristicas>()
		val hobbieII = new Caracteristicas("Juega al futbol")
		hobbiesII.add(hobbieII)
		
		val villanoII = new Villano("Ivan Igorovich", "Masculino", seniasParticularesII, hobbiesII)
		
		expediente = new Expediente
		expediente.agregarVillano(villanoCS)
		expediente.agregarVillano(villanoII)
		
		
		/**
		 * Caso
		 */
		 
		 val reporteDelCrimen = "A las 9 de la mañana en la ciudad del Cairo la comunidad científica fue conmovida al darse cuenta del faltante de gran valor! El sarcófago del faraón Usermaatra-Meriamón Ramsés-Heqaiunu, mejor conocido como Ramsés III. El criminal fue muy prolijo y la escena del crimen no contaba con pista alguna, su misión como detective es desifrar el responsable de tal crímen y apresarlo."
		 val objetoRobado = "Tumba del faraón"
		 
		 val plan = new ArrayList<Pais>()
		 plan.add(argentina)
		 plan.add(brazil)
		 plan.add(venezuela)
		 caso = new Caso(villanoCS,	plan, reporteDelCrimen, objetoRobado, argentina)
		 caso.pistasDelPlanDeEscape = caso.pistasDelRecorrido(plan)
//		 ver que otra cosa puede ser... o dejar de usar
		 
		 /**
		  * Detective
		  */
		doc = new Detective()
		
	}
	
	
}