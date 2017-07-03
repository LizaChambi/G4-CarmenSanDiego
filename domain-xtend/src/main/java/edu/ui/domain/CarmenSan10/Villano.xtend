package edu.ui.domain.CarmenSan10

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import edu.ui.domain.Exceptions.YaExisteLaSeniaParticularException
import edu.ui.domain.Exceptions.YaExisteElHobbieException
import org.uqbar.commons.utils.TransactionalAndObservable
import java.util.Random
import org.apache.commons.lang.StringUtils

@Accessors
@TransactionalAndObservable
class Villano extends Ocupante {
	
	Integer id
	// Esta propiedad la hereda de ocupante
	//String nombre
	String sexo
	List<Caracteristicas> seniasParticulares
	List<Caracteristicas> hobbies
	
	new () 
	{
		
	}
	
	/** PROPÓSITO: Crea un Villano con un nombre, sexo, señas particulares y hobbies. 
	 * 
	 * @param unNombre Es el nombre que tendrá el Villano.
	 * @param unSexo Es el sexo que tendrá el Villano.
	 * @param variasSenias Son las señas que caracterizan al Villanos.
	 * @param variosHobbies Son los hobbies que tendrá el Villano.
	 */
	new(String unNombre, String unSexo, List<Caracteristicas> variasSenias, List<Caracteristicas> variosHobbies) 
	{
		nombre = unNombre
		sexo = unSexo
		seniasParticulares = variasSenias
		hobbies = variosHobbies
	}
	
	/**
	 * PROPÓSITO: Pregunta si el Villano tiene el mismo nombre que se especifica por parámetro.
	 * 
	 * @param unNombre Es el nombre por el cual se hace la verificación
	 */
	def tieneElMismoNombreQue(String unNombre) 
	{
		nombre == unNombre
	}
	
	/** PROPÓSITO: Agrega un hobbie al villano.
	 * 
	 * @param hobbie Es el hobbie al que se le agrega al villano.
	 */
	def agregarHobbie (Caracteristicas hobbie)
	{
		hobbies.add(hobbie)
	}
	
	/** PROPÓSITO: Agrega un hobbie al Villano solo si no fue agregada anteriormente.
	 * @param hobbie Es el hobbie que se quiere intentar agregar.
	 * */
	def agregarHobbieSiPuede (Caracteristicas hobbie)
	{
		if (! tieneElHobbie(hobbie))
			agregarHobbie (hobbie)
		else
			throw new YaExisteElHobbieException ("El hobbie ya fue cargado anteriormente")
	}
	
	/** PROPÓSITO: Pregunta si el Villano ya tiene el hobbie especificada por parámetro.
	 * @param hobbie Es el hobbie por el que se hace la verificación.
	 */
	def tieneElHobbie(Caracteristicas hobbie) 
	{
		hobbies.contains(hobbie)
	}
	
	/** PROPÓSITO: Saca un hobbie al villano.
	 * 
	 * @param hobbie Es el hobbie al que se le quita al villano.
	 */
	def borrarHobbie (String hobbie)
	{
		hobbies.remove(hobbie)
	}
	
	/** PROPÓSITO: Borra una senia particular del villano.
	 * 
	 * @param senia Es la senia que se le agrega al villano.
	 */
	def borrarSenia(String senia)
	{
		seniasParticulares.remove(senia)
	}
	
	/** PROPÓSITO: Agrega una senia particular al villano.
	 * 
	 * @param senia Es la senia que se le quita al villano.
	 */
	def agregarSenia(Caracteristicas senia)
	{
		seniasParticulares.add (senia)
	}
	
	/** PROPÓSITO: Agrega una senia particular al Villano solo si no fue agregada anteriormente.
	 * @param senia Es la senia particular que se quiere intentar agregar.
	 * */
	def agregarSeniaSiPuede (Caracteristicas senia)
	{
		if (! existeLaSenia(senia))
			agregarSenia(senia)
		else
			throw new YaExisteLaSeniaParticularException("La seña particular ya se encuentra agregada")
	}
	
	/** PROPÓSITO: Pregunta si el Villano ya tiene la senia particular especificada por parámetro.
	 * @param senia Es la senia particular por la que se hace la verificación.
	 * 
	 */
	def existeLaSenia(Caracteristicas senia) 
	{
		seniasParticulares.contains(senia)
	}
	
	override responderAlDetective(Caso caso, LugarDeInteres unLugar, Pais paisActual)
	{
		if (seEncuentraElVillanoEnElLugar(caso, unLugar))
			"ALTO!! Detengase"
		else
			"CUIDADO DETECTIVE!! Ah estado a punto de caer en una trampa... La persona que busca está en la ciudad"
		
	}
	
	def seEncuentraElVillanoEnElLugar(Caso caso, LugarDeInteres interes) 
	{
		interes == caso.lugarDelVillano
	}
	
	/**
	 * PROPÓSITO: Devuelve un hobbie del Villano.
	 */
	def pistaDeHobbies() 
	{
		var Random rnd = new Random
		var int numeroPista = rnd.nextInt(hobbies.size)
		hobbies.get(numeroPista).nombre
	}
	
	def pistaDeSeniasParticulares() 
	{
		var Random rnd = new Random
		var int numeroPista = rnd.nextInt(seniasParticulares.size)
		seniasParticulares.get(numeroPista).nombre
	}
	
	override actualizar(List<Pais> ps, Pais p, Villano v) 
	{
		
	}
	
	def dar2PistasSeniasParticulares() 
	{
		var senias = seniasParticulares
		
		var Random rnd = new Random
		var Integer pista1 = rnd.nextInt(senias.size)
		val senia1 = senias.get(pista1)
		
		val pistasRestantes = senias.filter[v | v.nombre != senia1.nombre].toList
		
		var Integer pista2 = rnd.nextInt(pistasRestantes.size)
		val senia2 = pistasRestantes.get(pista2)
		
		senia1.nombre + " " + senia2.nombre
	}
	
	def tieneLaId(Integer id) 
	{
		this.id == id 
	}
	
	def estaCompleto() 
	{
		StringUtils.isNotBlank(nombre) && StringUtils.isNotBlank(sexo)
	}
	
	def faltanSeniasParticulares() 
	{
		seniasParticulares.size < 2
	}
	
	def faltaAgregarHobbie() 
	{
		hobbies.size < 1
	}
	
	def actualizarInformacion(String nuevoNombre, String nuevoSexo, List<Caracteristicas> nuevasSenias, List<Caracteristicas> nuevosHobbies) 
	{
		nombre = nuevoNombre
		sexo = nuevoSexo
		seniasParticulares = nuevasSenias
		hobbies = nuevosHobbies
	}
	
	def static void main(String[] args) {
		
		val senia01_Julian = new Caracteristicas("Tiene el pelo azul.")
		val senia02_Julian = new Caracteristicas("Se rasca la oreja de forma extraña.")
		//val senia03_Julian = new Caracteristicas("")
		
		val hobbie01_Julian = new Caracteristicas("Plantar tomate.")
		val hobbie02_Julian = new Caracteristicas("Comer chupentines.")
		//val hobbie03_Julian = new Caracteristicas("")
		
		val Villano nn = new Villano() => [ 
			nombre = "Julian"
			seniasParticulares = #[senia01_Julian, senia02_Julian]
			hobbies = #[hobbie01_Julian, hobbie02_Julian]
		]
		
		//var pistas = nn.dar2PistasSeniasParticulares
		
		println("señas particulares = " + nn.seniasParticulares.size)
		println("hobbies = " + nn.hobbies.size)
		println(nn.dar2PistasSeniasParticulares)
		
	}
	
}
