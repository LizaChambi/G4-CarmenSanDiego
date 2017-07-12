package edu.ui.web.rest

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import edu.ui.domain.Dummy.CarmenSan10Dummy
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.commons.model.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import edu.ui.domain.CarmenSan10.Villano
import edu.ui.dominioXTrest.ExpedienteRest
import edu.ui.dominioXTrest.MapamundiRest
import org.uqbar.xtrest.api.annotation.Put
import edu.ui.dominioXTrest.PaisSinID
import edu.ui.dominioXTrest.EmitirOrdenRequest
import edu.ui.dominioXTrest.ViajeRequest
import edu.ui.dominioXTrest.CasoRest
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.CarmenSan10.LugarDeInteres
import edu.ui.dominioXTrest.PistaRest
import edu.ui.dominioXTrest.PaisConID
import java.util.List

@Controller
class CarmenSan10RestAPI {
	extension JSONUtils = new JSONUtils
	
	CarmenSan10Dummy carmenSan10
	
	new (CarmenSan10Dummy dummy) 
	{
		carmenSan10 = dummy
	}
	
	/**
	 * paises - devuelve todos los paises
	 */
	@Get("/paises")
	def getPaises() {
		response.contentType = ContentType.APPLICATION_JSON
		val mapamundi = new MapamundiRest(carmenSan10.mapamundi.paises) // comparte o calcula?
		ok(mapamundi.minificador.toJson)
	}
	
	
	/**
	 * pais - devuelve los datos del país 
	 */
	@Get("/pais/:id")
	def getPaisById() {
		response.contentType = ContentType.APPLICATION_JSON
		try{
			var pais = carmenSan10.mapamundi.getPais(Integer.valueOf(id))
			val mapamundi = new MapamundiRest(carmenSan10.mapamundi.paises) // puede ser un new() {}???
			val resConexiones = mapamundi.minificador(pais.paisesConexionAerea)
			
			var pais_mini = mapamundi.miniPais(pais, resConexiones)
			// que onda los notFoundo o bad request?
			if(pais == null) { //pais_mini == null || 
				notFound("no existe el pais con ese ID")
			} else {
				ok(pais_mini.toJson)
			}
		
		} catch (NumberFormatException ex) {
			badRequest(getErrorJson("El id debe ser un numero entero"))
		}
	}
	
	
	/**
	 * pais - eliminar un pais por su id
	 * Atiende requests de la forma DELETE /paises/4.
	 */
	@Delete("/pais/:id")
	def deletePaisById() {
		response.contentType = ContentType.APPLICATION_JSON
		
		try {
			carmenSan10.mapamundi.eliminarPaisMini(Integer.valueOf(id))
			ok()
		} catch (NumberFormatException exception) {
			badRequest("El id debe ser un numero entero")
		}
	}
	
	
	@Put("/pais/:id")
	def actualizarPais(@Body String body)
	{
		response.contentType = ContentType.APPLICATION_JSON
		val PaisConID paisActualizado = body.fromJson(PaisConID) // pais nuevo
	    val Integer idP = Integer.valueOf(id) // id del villano a modificar
	     
	    val List<Pais> conexionesNuevas = carmenSan10.mapamundi.conexionesDelPais(paisActualizado.conexionesIds);
		
		println(conexionesNuevas)
		
		try 
		{
			carmenSan10.mapamundi.editarPais(paisActualizado.nombre, paisActualizado.lugares, conexionesNuevas, idP)
			ok("Pais actualizado correctamente".toJson)  
        } 
        catch (UnrecognizedPropertyException exception) 
        {
        	badRequest(getErrorJson("El body debe ser un Pais"))
        }
		
	}
	
	@Post("/pais")
	def createPais(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		
		val PaisSinID pais = body.fromJson(PaisSinID)
		val mapamundi = new MapamundiRest(carmenSan10.mapamundi.paises)
		var paisMaxi = mapamundi.maximizar(pais, carmenSan10.mapamundi)
		carmenSan10.mapamundi.setPaisMini(paisMaxi)
		
		ok(carmenSan10.mapamundi.getPais(paisMaxi.nombrePais).id.toJson)
	}
	
	
	/**
	 * inicia un juego y devuelve un caso
	 */
	 @Post("/iniciarJuego")
	 def getIniciarJuego() {
	 	response.contentType = ContentType.APPLICATION_JSON

		val pais = carmenSan10.caso.paisDelRobo
	 	
	 	carmenSan10.doc.viajarA(pais)
	 	
	 	//val paisRobo = carmenSan10.mapamundi.getPais(pais.id)
	 	
	 	val mapamundi = new MapamundiRest(carmenSan10.mapamundi.paises)
	 	
	 	val resConexiones = mapamundi.minificador(pais.paisesConexionAerea)
	 	
	 	val casoMax = carmenSan10.caso
	 	val docMax = carmenSan10.doc
	 	
	 	val casoRest = new CasoRest(casoMax, docMax, mapamundi, resConexiones)
	 	
	 	ok(casoRest.toJson)
	 }
	 
	
	/**
	 * How to pass url query params?
	 * For eg: http://www.abx.com?x=2&y=3
	 */
	@Get("/pistaDelLugar")
	def getPistaDelLugar(String lugar, String caso) {
		response.contentType = ContentType.APPLICATION_JSON
		
//		val lugarJson = "{'nombre':" + lugar + "}" 
//		val lugarP = lugarJson.fromJson(LugarDeInteres)
		
//		val lugarParam = parseo O String - ubicacionActual

		val LugarDeInteres parse = LugarDeInteres.valueOf(lugar)
		
		//val paisActual = carmenSan10.doc.ubicacionActual
		
		//val mostrarPista = carmenSan10.caso.mostrarPista(paisActual, parse)
		val mostrarPista = carmenSan10.doc.pedirPista(carmenSan10.caso, parse)
		
		val pista = new PistaRest(mostrarPista)
		
		ok(pista.toJson)
	}
	
	
	/**
	 * villanos - devuelve todos los villanos
	 */
	@Get("/villanos")
	def getVillanos() {
		response.contentType = ContentType.APPLICATION_JSON
		val expedientes = new ExpedienteRest(carmenSan10.expediente.villanos)
		ok(expedientes.minificador.toJson)
	}
	
	/**
     * Permite obtener un villano por su id.
     * 
     * Atiende requests de la forma GET /villanos/17.
     */
    @Get("/villano/:id")
    def getVillanosById() {
        response.contentType = ContentType.APPLICATION_JSON
        try {        	
            var villano = carmenSan10.expediente.obtenerVillanoDeId(Integer.valueOf(id))
            if (villano == null) 
            {
            	notFound(getErrorJson("No existe un villano con ese id"))
            } 
            else 
            {
            	ok(villano.toJson)
            }
        }
        catch (NumberFormatException ex) 
        {
        	badRequest(getErrorJson("El id debe ser un numero entero"))
        }
    }
    
    /**
     * Permite eliminar un villano por su id.
     * 
     * Atiende requests de la forma DELETE /villanos/7.
     */
    @Delete('/villanos/:id')
    def borrarVillano() {
        response.contentType = ContentType.APPLICATION_JSON
        try {
        	var villano = carmenSan10.expediente.obtenerVillanoDeId(Integer.valueOf(id))
        	if (villano.equals(null))
        	{
        		notFound(getErrorJson("No existe un villano con ese id"))
        	}
        	else
        	{
        		carmenSan10.expediente.eliminarVillanoDeId(Integer.valueOf(id))
        		ok()
        	}
        }
        catch (NumberFormatException ex) {
        	badRequest(getErrorJson("El id debe ser un numero entero"))
        }
    }
    
     /**
     * Permite crear un villano.
     * 
     * Atiende requests de la forma POST /villanos con un villano en el body (en formato JSON).
     */
    @Post("/villano")
    def crearVillano(@Body String body) {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val Villano villano = body.fromJson(Villano)
	        try 
	        {
				carmenSan10.expediente.agregarVillanoNuevo(villano)
				ok(carmenSan10.expediente.idDelVillano(villano.nombre).toJson)
	        }
	        catch (UserException exception) {
	        	badRequest(getErrorJson(exception.message))
	        }
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un Villano"))
        }
    }
    
     /**
     * Permite editar un villano.
     * 
     * Atiende requests de la forma POST /villanos/2 con un villano en el body (en formato JSON).
     */
    @Put("/villano/:id")
    def modificarVillano(@Body String body) 
    {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val Villano villano = body.fromJson(Villano) // villano nuevo
	        val Integer idV = Integer.valueOf(id) // id del villano a modificar
	        try 
	        {
				carmenSan10.expediente.editarVillanoSiPuede(villano, idV)
				ok("Villano actualizado correctamente".toJson)
	        }
	        catch (UserException exception) 
	        {
	        	badRequest(getErrorJson(exception.message))
	        }
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un Villano"))
        }
    }
    
     /**
     * Permite emitir una orden de arresto.
     * 
     * Atiende requests de la forma POST /emitirOrdenPara con un EmitirOrdenRequest en el body (en formato JSON).
     */
    @Post("/emitirOrdenPara")
    def emitirOrdenRequest(@Body String body) {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val EmitirOrdenRequest ordenDeArresto = body.fromJson(EmitirOrdenRequest)
	       	val villano = carmenSan10.expediente.obtenerVillanoDeId(ordenDeArresto.villanoId)
			
			if (villano.equals(null))
        	{
        		notFound(getErrorJson("No existe un villano con ese id"))
        	}
        	else
        	{
        		carmenSan10.doc.ordenarArresto(villano)
				ok("Orden emitida correctamente")
        	}
			
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un EmitirOrdenRequest"))
        }
    }
    
    /**
     * Permite viajar una a otro pais.
     * 
     * Atiende requests de la forma POST /viajar con un ViajeRequest en el body (en formato JSON).
     */
    @Post("/viajar")
    def viajar(@Body String body) 
    {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val ViajeRequest viaje = body.fromJson(ViajeRequest) 
	        val Pais destino = carmenSan10.mapamundi.getPais(viaje.destinoId)
	        try 
	        {
				carmenSan10.doc.viajarSiPuedeA(destino)
				
				// En vez de crear un mamaundiRest, podría mandarle a CasoRest el original y que sea él quien..
				//  se encargue de crear el MamamundiRest, quien sabe minificar.
				val mapamundi = new MapamundiRest(carmenSan10.mapamundi.paises)
	 			val conexiones = mapamundi.minificador(destino.paisesConexionAerea)
	 			
				val CasoRest casoRespuesta = new CasoRest (carmenSan10.caso, carmenSan10.doc, mapamundi, conexiones)
				
				ok(casoRespuesta.toJson) //"Orden emitida correctamente"
	        }
	        catch (UserException exception) {
	        	badRequest(getErrorJson(exception.message))
	        }
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un ViajeRequest"))
        }
    }
    
    
    private def getErrorJson(String message) { // es indiferente
        '{ "error": "' + message + '" }'
    }
}