'use strict';

carmenApp.service("CarmenService", function ($http) {

	this.fetchPaises = function(ctrl){
    //return
	$http.get("http://localhost:9000/paises").then(function(response) {
			console.log(response.data);
			ctrl.setPaises(response.data);
			/*
			var paisesRest = response.data;
			
			paisesRest.forEach(function(pais){
				paises.push(pais);
			})
			*/
			
			//paises = response.data;
			}
	)}
	
	this.fetchVillanos = function(ctrl){
	$http.get("http://localhost:9000/villanos").then(function(response) {
			console.log(response.data);
			ctrl.setVillanos(response.data);
			}
	)}
	
	this.villanos = function(){
	//return
	$http.get("http://localhost:9000/villanos").then(function(response) {
			console.log(response.data);
			return response.data;
	}
	)}
	
	this.paisConId = function(idPais, ctrl) {
	//return
	$http.get("http://localhost:9000/pais/" + idPais).then(function(response) {
			console.log(response.data);
			ctrl.setPaisSeleccionado(response.data);
			ctrl.setNombrePaisSeleccionado(response.data.nombre);
			ctrl.setConexionesAereas(response.data.mini_conexiones);
			ctrl.setLugaresDeInteres(response.data.lugares);
			console.log(response.data.lugares);
			//return response.data;
	}
	)}
	
	this.borrarPaisConId = function(idPais, ctrl) {
	$http.delete("http://localhost:9000/pais/" + idPais).then(function(response) {
			console.log("Pais " + idPais + " borrado");
			ctrl.setPaisSeleccionado(new Object);
			ctrl.setNombrePaisSeleccionado("");
			ctrl.setConexionesAereas([]);
			ctrl.setLugaresDeInteres([]);
			ctrl.fetchPaises();
	}
	)}
	
	this.borrarVillanoConId = function(idVillano, ctrl) {
	$http.delete("http://localhost:9000/villanos/" + idVillano).then(function(response) {
			console.log("Villano " + idVillano + " borrado");
			ctrl.setVillanoSeleccionado(null);
			ctrl.setNombreVillanoSeleccionado("");
			ctrl.setSeniasParticulares([]);
			ctrl.setHobbies([]);
			ctrl.fetchVillanos();
	}
	)}
	
	this.formarConexionDePais = function(conexion) {
		return {"nombre": conexion.nombre, "id": conexion.id};
	}
	
	this.formarConexiones = function(conexiones) {
		var conexionesAux = [];
		for (var i=0; i<conexiones.length; i++)
		{
			conexionesAux.push(this.formarConexionDePais(conexiones[i]));
		}
		return conexionesAux;
	}
	
	this.formarCaracteristicaDelVillano = function(senia) {
		return {"nombre": senia.nombre};
	}
	
	this.formarCaracteristicas = function(senias) {
		var seniasAux = [];
		for (var i=0; i<senias.length; i++)
		{
			seniasAux.push(this.formarCaracteristicaDelVillano(senias[i]));
		}
		return seniasAux;
	}
	
	this.editarPaisConId = function(paisId, pais, ctrl) {
			// un metodo que dado un arreglo, donde a cada elemento lo meto en un nuevo json 
			var paisJson = {
			  "id": pais.id,
			  "nombre": pais.nombre,
			  "lugares": pais.lugares,
			  "mini_conexiones": this.formarConexiones(pais.mini_conexiones)
			}
	$http.put("http://localhost:9000/pais/" + paisId, JSON.stringify(paisJson)).then(function(response) {
			ctrl.setNombrePaisSeleccionado("");
			ctrl.setConexionesAereas([]);
			ctrl.setLugaresDeInteres([]);
			
			console.log("El pais ya fue editado");
			ctrl.fetchPaises(); // Actualizo las listas de paises.
	}
	)}
	
	this.editarVillanoConId = function(villanoId, villano, ctrl) {
			// metodo donde arregla las caracteristicas
			var villanoJson = {
			  "id": villano.id,
			  "nombre": villano.nombre,
			  "sexo": villano.sexo,
			  "seniasParticulares": this.formarCaracteristicas(villano.seniasParticulares),
			  "hobbies": this.formarCaracteristicas(villano.hobbies)
			}
			
	$http.put("http://localhost:9000/villano/" + villanoId, JSON.stringify(villanoJson)).then(function(response) {
			ctrl.setNombreVillanoSeleccionado("");
			ctrl.setSeniasParticulares([]);
			ctrl.setHobbies([]);
			
			console.log("El villano ya fue editado");
			ctrl.fetchVillanos(); // Actualizo las listas de paises.
	}
	)}
	
	
	/* 	NO SE EJECUTA
	
	this.crearNuevoPais = function(paisNuevo, ctrl) {
	$http.post("http://localhost:9000/pais").then(function(response) {
			ctrl.setPaisSeleccionado(new Object);
			ctrl.setNombrePaisSeleccionado("");
			ctrl.setConexionesAereas([]);
			ctrl.setLugaresDeInteres([]);
			console.log("Nuevo pais " + response.data.id + " creado");
			ctrl.fetchPaises(); // Actualizo las listas de paises.
	}
	)}
	*/
	this.villanoConId = function(idVillano, ctrl) {
	$http.get("http://localhost:9000/villano/" + idVillano).then(function(response) {
			console.log(response.data);
			ctrl.setVillanoSeleccionado(response.data);
			ctrl.setNombreVillanoSeleccionado(response.data.nombre);
			ctrl.setSeniasParticulares(response.data.seniasParticulares);
			ctrl.setHobbies(response.data.hobbies);
	}
	)}

});