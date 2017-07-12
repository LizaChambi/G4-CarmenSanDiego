package edu.ui.domain.CarmenSan10

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import edu.ui.domain.Exceptions.YaEstaAgregadaEsaConexion
import org.uqbar.commons.utils.TransactionalAndObservable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import java.util.Random
import edu.ui.domain.Exceptions.NoSePuedeAgregarMasLugaresException
import edu.ui.domain.Exceptions.ElLugarYaFueAgregadoException

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
	
	def validarCaracteristicas(String nombre, List<LugarDeInteres> lugares, List<Pais> conexiones)
	{
		if (nombrePais.isEmpty) throw new UserException("El nombre no puede quedar vacio")
		if (lugares.size != 3) throw new UserException("Debe haber 3 lugares de interes")
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
	
	def agregarLugarSiPuede(LugarDeInteres lugar) 
	{
		if (lugares.size == 3)
		{
			throw new NoSePuedeAgregarMasLugaresException("Un pais no puede tener más de 3 lugares de interes.")
		}
		else
		{
			lugares.add(lugar)
		}
	}
	
	def elLugarYaFueAgregado(LugarDeInteres interes) 
	{
		lugares.exists[l | l.nombre == interes.nombre]
	}
	
	def editarCaracteristicas(String nombre, List<LugarDeInteres> lugares, List<Pais> conexiones) 
	{
		this.nombrePais = nombre
		this.lugares = lugares
		this.paisesConexionAerea = conexiones
	}
	
}