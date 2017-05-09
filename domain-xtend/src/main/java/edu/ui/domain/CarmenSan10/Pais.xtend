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
class Pais extends Entity implements Cloneable {
	
	String nombrePais
	List<Caracteristicas> caracteristicaPais
	List<LugarDeInteres> lugares
	List<Pais> paisesConexionAerea
	Ocupante ocupante
	int id
	
	new (){}
	
	new(int identi, String nombre) {
		id = identi
		nombrePais = nombre
	}
	
	new(String nombre) {
		nombrePais = nombre
		caracteristicaPais = new ArrayList<Caracteristicas>()
		lugares = new ArrayList<LugarDeInteres>()
		paisesConexionAerea = new ArrayList<Pais>()
		ocupante = new Cuidador()
	}
	
	 override getId() { // xq me pide que redefina el id?
	 	id				// si antes jamas lo habia creado?
	 }					// donde puede estar ese id?
	
//	def List<String> getNombreLugares() {
//		lugares.map[l| l.nombre]
//		//lugares.get(0).nombre
//	}
// Suena extraño porque NO puedo borrar/comentar la linea setNombreLugares y correr la app
	
	def void setNombreLugares(List<LugarDeInteres> plugares) {}
	
	def void setNombreCaracteristica(List<Caracteristicas> pfeature) {}
	
	// y todo lo que se pueda jugar con una lista por cada lista
	
	def tieneConexionAereaCon(Pais pais) {
		paisesConexionAerea.exists[p | p.nombrePais == pais.nombrePais]
	}
	
	def agregarConexionesAerea(Pais unPais) {
			paisesConexionAerea.add(unPais)
	}
	
	def agregarConexionSiPuede(Pais unPais) {
		if (! paisesConexionAerea.contains(unPais)) { // Returns true if this list contains the specified element.
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
		var Pais paisDestino = recorrido.get(recorrido.size - 1)
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
	
	def eliminarCaracteristicaSelecionada(String feature) {
		caracteristicaPais.remove(feature)
	}
	
	/**
	 * @PROPÓSITO: Retorna un lugar de los lugares de interes del país de manera aleatoria.
	 */
	def lugarDelVillano() 
	{
		var Random rnd = new Random
		var int lugar = rnd.nextInt(2)
		lugares.get(lugar)
	}
	
	def pistaDeSusCaracteristicas() 
	{
		var Random rnd = new Random
		var int caracteristica = rnd.nextInt(caracteristicaPais.size-1)
		caracteristicaPais.get(caracteristica).nombre
	}
	
	def dar2PistaDeSusCaracteristicas() 
	{
		var pistas = caracteristicaPais
		
		var Random rnd = new Random
		var int caracteristica = rnd.nextInt(pistas.size-1)
		val pista1 = pistas.get(caracteristica)
		
		pistas.drop(caracteristica).toList
		
		var int caracteristica2 = rnd.nextInt(pistas.size-1)
		val pista2 = pistas.get(caracteristica2)
		
		pista1.nombre + pista2.nombre
		
	}
	
	def cambiarEstado(Caso caso) {
		ocupante.actualizar(caso, this)
	}
	
	def List<String> pistas(Caso caso) 
	{
		val pistasResultantes = new ArrayList<String>
		val pista1 = ocupante.responderAlDetective(caso, lugares.get(0), this)
		val pista2 = ocupante.responderAlDetective(caso, lugares.get(1), this)
		val pista3 = ocupante.responderAlDetective(caso, lugares.get(3), this)
		pistasResultantes.add (pista1)
		pistasResultantes.add (pista2)
		pistasResultantes.add (pista3)
		pistasResultantes
	}
	
}