'use strict';

  	carmenApp.controller('MapamundiController', function ($stateParams, $state, $http, CarmenService) {
  		/*
  		this.ingresar = function () {
    		$state.go("socialPage");
  		};
  		*/
		var self=this;
		
		var paises = [];
		
		this.paisSeleccionado;
		this.nombre = '';
		this.conexiones = [];
		this.lugares = [];
		
		this.conexionSeleccionada;
		this.lugarSeleccionado;
		
		this.lugaresDisponibles = ["EMBAJADA", "BANCO", "CLUB", "BIBLIOTECA"]
		
		var villanos = [];
		var villanoSeleccionado;
		
		//this.getNombrePaisSeleccionado = function() {
		//	return nombre;
		//}
		
		this.irAExpedientes = function() {
			$state.go("expediente");
		}
		
		this.eliminarLugar = function (lugar) {
			var lugaresAux= [];
			for (var i = 0; i < this.lugares.length; i++)
			{
				if (this.lugares[i] != lugar)
					{
						lugaresAux.push(this.lugares[i]);
					}
			}
			this.lugares = lugaresAux;
		}
		
		this.eliminarConexion = function(idPais) {
			var conexionesAux = [];
			console.log(this.conexiones);
			for (var i = 0; i < this.conexiones.length; i++)
			{
				if (paises[i].id != idPais)
					{
						conexionesAux.push(paises[i]);
					}
			}
			this.conexiones = conexionesAux;
			console.log(this.conexiones);
		}
		
		this.agregarLugar = function() {
			this.lugares.push(this.lugarSeleccionado);
		}
		
		this.setNombrePaisSeleccionado = function(nombreNuevo) {
			this.nombre = nombreNuevo;
		}
		
		this.getConexionSeleccionada = function() {
			return this.conexiones;
		}
		
		this.getPaises = function(){
			return paises;
		}
		
		// FILTRAR EL SELECTOR DE CONEXIONES AEREAS
		
		this.noEsElPaisSeleccionado = function(nombre){
			return (nombre!= this.paisSeleccionado.nombre); 
		}
		
		this.getPaisesFiltrados = function() {
			if(this.paisSeleccionado != null)
			{
				var paisesAux = [];
				for (var i = 0; i < paises.length; i++)
				{
					if ( this.noEsElPaisSeleccionado(paises[i].nombre))
						{
							paisesAux.push(paises[i]);
						}
				}
				return paisesAux;
			}
			else
			{
				return paises;
			}
		}
		
		
		
		this.editarPais = function() {
			this.paisSeleccionado.nombre = this.nombre;
			this.paisSeleccionado.mini_conexiones = this.conexiones;
			this.paisSeleccionado.lugares = this.lugares;
			CarmenService.editarPaisConId(this.paisSeleccionado.id, this.paisSeleccionado, this);
		}
		
		this.getPaisSeleccionado = function(){
			console.log(this.paisSeleccionado);
			return this.paisSeleccionado;
		}
		
		this.setPaisSeleccionado = function (pais){
			this.paisSeleccionado = pais;
		}
		
		this.setConexionesAereas = function(paises) {
			this.conexiones = paises;
		}
		
		this.getLugaresPaisSeleccionado = function () {
			return this.lugares;
		}
		
		this.setLugaresDeInteres = function(lugaresDeInteres) {
			this.lugares = lugaresDeInteres;
		}
		
		this.nombreDelPaisSeleccionado = function() {
			return paisSeleccionado.nombre;
		}
		
		this.setPaises = function (paisesNuevos) {
			paises = paisesNuevos;
		}
		
		// Para obtener las conexiones aereas
		this.getConexPaisSeleccionado = function() {
			return this.conexiones;
		}
		
		/* 		FALTA IMPLEMENTAR crearNuevoPais EN EL SERVIDOR
		
		this.createPais = function() {
			var nuevoPais = new Object;
			
			nuevoPais.nombre = this.nombre;
			nuevoPais.lugares = this.lugares;
			nuevoPais.mini_conexiones = this.conexiones;
			
			CarmenService.crearNuevoPais(nuevoPais, this);
		}
		*/
		
		// pido al servidor la lista de paises y busco en ella la de el id especifico y lo agrego a la lista de conexiones
		this.agregarConexion = function() {
			var paisConex = [];
			for (var i=0; i<paises.length; i++)
			{
				if (paises[i].nombre == this.conexionSeleccionada)
				{
					paisConex = paises[i];
				}
			}
			this.conexiones.push(paisConex);
		}
		
  		this.fetchPaises = function(){
  			CarmenService.fetchPaises(this);
  		}
		
		this.fetchPaises();
		
		this.getVillanos = function(){
			villanos = CarmenService.villanos();
		}
	
		this.getPaisConId = function(idPais) {
			CarmenService.paisConId(idPais, this);
		}
		
		this.deletePaisConId = function(idPais) {
			CarmenService.borrarPaisConId(idPais, this);
		}
	
		this.getVillanoConId = function(idVillano) {
			villanoSeleccion
			villanoSeleccionado = CarmenService.villanoConId(idVillano);
		}
		
  });
