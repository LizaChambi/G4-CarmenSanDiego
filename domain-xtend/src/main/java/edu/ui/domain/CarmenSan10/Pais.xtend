package edu.ui.domain.CarmenSan10

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import edu.ui.domain.Exceptions.YaEstaAgregadaEsaConexion
import org.uqbar.commons.utils.TransactionalAndObservable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import java.util.Random

@Accessors
@TransactionalAndObservable
class Pais {
	
	public String nombrePais
	List<Caracteristicas> caracteristicaPais
	List<LugarDeInteres> lugares
	List<Pais> paisesConexionAerea
	Ocupante ocupante
	Integer id
	
	new() {}
	
	new(String nombre) {
		nombrePais = nombre
		caracteristicaPais = new ArrayList<Caracteristicas>()
		lugares = new ArrayList<LugarDeInteres>()
		paisesConexionAerea = new ArrayList<Pais>()
		ocupante = new Cuidador()
	}
	
	new(String nombre, List<LugarDeInteres> lugarest, List<Pais> conex_rest) {
		nombrePais = nombre
		lugares = lugarest
		paisesConexionAerea = conex_rest
		caracteristicaPais = new ArrayList<Caracteristicas>()
		ocupante = new Cuidador()
		
	}
	
//	def List<String> getNombreLugares() {
//		lugares.map[l| l.nombre]
//		//lugares.get(0).nombre
//	}
// Suena extraño porque NO puedo borrar/comentar la linea setNombreLugares y correr la app
	
	def void setNombreLugares(List<LugarDeInteres> plugares) {}
	
	def void setNombreCaracteristica(List<Caracteristicas> pfeature) {}
	

	
	def tieneConexionAereaCon(Pais pais) {
		paisesConexionAerea.exists[p | p.nombrePais == pais.nombrePais]
	}
	
	def agregarConexionesAerea(Pais unPais) {
			paisesConexionAerea.add(unPais)
	}
	
	def agregarConexionSiPuede(Pais unPais) {
		if (! paisesConexionAerea.contains(unPais)) {
			agregarConexionesAerea
		} else {
			throw new YaEstaAgregadaEsaConexion("Tenes un conexion/pais ya definida")
		}
	}
	
	def borrarConexionAerea(Pais unPais) {
		paisesConexionAerea.remove(unPais)
	}
	
	def esElFinalDelRecorrido(List<Pais> recorrido)
	{
		val Pais paisDestino = recorrido.get(recorrido.size - 1)
		this.esIgualA(paisDestino.nombrePais)
	}
	
	def esIgualA(String nombreAComparar) 
	{
		nombrePais == nombreAComparar
	}
	
	def estaDentroDelRecorrido(List<Pais> recorrido)
	{
		recorrido.exists[pais| pais.esIgualA(nombrePais)]
	}
	
	def estaFueraDelRecorrido (List<Pais> recorrido)
	{
		! estaDentroDelRecorrido(recorrido)
	}
	
	def seEncuentraEnRecorridoSinElUltimoPais(List<Pais> recorrido)
	{
		val recorridoAux = recorrido
		var recorridoSinUltimoPais = recorrido.filter[pais| pais.noEsElUltimoDelRecorrido(recorridoAux)].toList
		estaDentroDelRecorrido(recorridoSinUltimoPais)
	}
	
	def noEsElUltimoDelRecorrido(List<Pais> recorrido) 
	{
		! esElFinalDelRecorrido(recorrido)
	}
	
	def validar() {
//		if(nombrePais == null) {
//			throw new UserException("El nombre no puede quedar vacion")
//		}
//		
//		if(caracteristicaPais.isEmpty) {
//			throw new UserException("Al menos debe tener 1 caracteristica")
//		}
//		
		if(lugares.size != 3) {
			throw new UserException("Te faltan agregar mas Lugar para visitar")
		}
		
	}
	
	def agregarCaracteristica(Caracteristicas caracteristica) {
		caracteristicaPais.add(caracteristica)
	}
	
	def eliminarCaracteristica(Caracteristicas caracteristica) {
		caracteristicaPais = caracteristicaPais.filter[c | c.nombre != caracteristica.nombre].toList
		//caracteristicaPais.remove(caracteristica)
	}
	
	/**
	 * @PROPÓSITO: Retorna un lugar de los lugares de interes del país de manera aleatoria.
	 */
	def lugarDelVillano() 
	{
		var Random rnd = new Random
		var int lugar = rnd.nextInt(3)
		lugares.get(lugar)
	}
	
	def pistaDeSusCaracteristicas() 
	{
		var Random rnd = new Random
		var int caracteristica = rnd.nextInt(caracteristicaPais.size)
		caracteristicaPais.get(caracteristica).nombre
	}
	
	def dar2PistaDeSusCaracteristicas() 
	{
		var pistas = caracteristicaPais
		
		var Random rnd = new Random
		var Integer caracteristica = rnd.nextInt(pistas.size)
		val pista1 = pistas.get(caracteristica)
		
		val pistasRestantes = pistas.filter[c | c.nombre != pista1.nombre].toList
		
		var Integer caracteristica2 = rnd.nextInt(pistasRestantes.size)
		val pista2 = pistasRestantes.get(caracteristica2)
		pista1.nombre + " " + pista2.nombre
	}
	
	def void cambiarEstado(List<Pais> ps, Villano v) // este funciona realmente
	{
		// cambie los parametros del mensaje Actualizar
		ocupante = ocupante.actualizar(ps, this, v)
	}
	
	def List<String> pistas(Caso caso) 
	{
		val pistasResultantes = new ArrayList<String>
		val pista1 = ocupante.responderAlDetective(caso, lugares.get(0), this)
		val pista2 = ocupante.responderAlDetective(caso, lugares.get(1), this)
		val pista3 = ocupante.responderAlDetective(caso, lugares.get(2), this)
		pistasResultantes.add (pista1)
		pistasResultantes.add (pista2)
		pistasResultantes.add (pista3)
		pistasResultantes
	}
	
	def static void main(String[] args) {
		
		val feature01_panama = new Caracteristicas("Mucho viento del norte.")
		val feature02_panama = new Caracteristicas("Mi bandera es mi patria.")
		val feature03_panama = new Caracteristicas("Este lugar es poco visitado.")
		
		val Pais panama = new Pais("Panama")
		panama.ocupante = new Informante()
		panama.caracteristicaPais = #[feature01_panama, feature02_panama, feature03_panama]
		
		val lugares02 = #[LugarDeInteres.BIBLIOTECA, LugarDeInteres.CLUB, LugarDeInteres.EMBAJADA]
	
		val venezuela = new Pais("Venezuela")
		venezuela.lugares = lugares02
		venezuela.ocupante = new Informante()
		
		val belgica = new Pais("Belgica")
		
		val argentina = new Pais("Argentina")
		
		////////////////////////////////////////////////////////////////////////////
		
		val senia01_Julian = new Caracteristicas("Tiene el pelo azul.")
		val senia02_Julian = new Caracteristicas("Se rasca la oreja de forma extraña.")
		val senia03_Julian = new Caracteristicas("Canta Bandana en el tren")
		
		val hobbie01_Julian = new Caracteristicas("Plantar tomate.")
		val hobbie02_Julian = new Caracteristicas("Comer chupentines.")
		val hobbie03_Julian = new Caracteristicas("Juega LoL")
		
		val Villano nn = new Villano() => [ 
			nombre = "Julian"
			seniasParticulares = #[senia01_Julian, senia02_Julian, senia03_Julian]
			hobbies = #[hobbie01_Julian, hobbie02_Julian, hobbie03_Julian]
		]
		
		val hard = new Caso() => [
			planDeEscape = #[venezuela, panama, argentina, belgica]
			responsable = nn
		]
		
		var pistas = venezuela.pistas(hard)
		
		//belgica.cambiarEstado(hard)
		//argentina.cambiarEstado(hard)
		
		println("----------------------------------------")
		
		println(panama.caracteristicaPais.get(0).nombre)
		println(panama.caracteristicaPais.get(1).nombre)
		println(panama.caracteristicaPais.get(2).nombre)
		
		println("pista --> " + panama.pistaDeSusCaracteristicas)
		println("2 pistas --> " + panama.dar2PistaDeSusCaracteristicas)
		
		println("----------------------------------------")
		
		println("cantidad de pistas = " + pistas.size)
		println(pistas.get(0))
		println(pistas.get(1))
		println(pistas.get(2))
		
	}
	
	def eliminarLugarDeInteres(LugarDeInteres interes) 
	{
		lugares = lugares.filter[l | l.nombre != interes.nombre].toList
	}
	
	def eliminarConexionAerea(Pais pais) 
	{
		paisesConexionAerea = paisesConexionAerea.filter[p | p.nombrePais != pais.nombrePais].toList
	}
	
	def lugarDeInteres1 ()
	{
		lugares.get(0)
	}
	
	def lugarDeInteres2 ()
	{
		lugares.get(1)
	}
	
	def lugarDeInteres3 ()
	{
		lugares.get(2)
	}
	
	def nombreDelLugar1() 
	{
		lugarDeInteres1.nombre
	}
	
	def nombreDelLugar2()
	{
		lugarDeInteres2.nombre
	}
	
	def nombreDelLugar3()
	{
		lugarDeInteres3.nombre
	}
	
}