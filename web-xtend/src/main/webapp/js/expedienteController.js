'use strict';

  	carmenApp.controller('ExpedienteController', function ($stateParams, $state, $http, CarmenService) {
 
		var self=this;

		var villanos = [];
		
		this.villanoSeleccionado;
		this.nombre = '';
		this.senias = [];
		this.hobbies = [];
		
		this.seniaSeleccionada;
		this.hobbieSeleccionado;
		
		this.irAMapamundi = function () {
			$state.go("mapamundi");
		}
		
		this.agregarSenia = function() {
			console.log(this.senias);
		
			console.log(this.seniaSeleccionada);
			var caract = {"nombre": this.seniaSeleccionada}
			
			this.senias.push(caract);
			console.log(this.senias);
			this.seniaSeleccionada = "";
	
		}
		
		this.agregarHobbie = function() {
			console.log(this.hobbies);
			console.log(this.hobbieSeleccionado);
			var caract = {"nombre": this.hobbieSeleccionado}
			this.hobbies.push(caract);
			console.log(this.hobbies);
			this.hobbieSeleccionado = "";
		}
		
		this.getSeniaSeleccionada = function () {
			return this.seniaSeleccionada;
		}
		
		this.setNombreVillanoSeleccionado = function(nombreNuevo) {
			this.nombre = nombreNuevo;
		}
		
		this.setSeniasParticulares = function(seniasNuevas) {
			this.senias = seniasNuevas;
		}
		
		this.setHobbies = function(hobbiesNuevos) {
			this.hobbies = hobbiesNuevos;
		}
		
		this.getVillanos = function(){
			return villanos;
		}
		
		this.getSenias = function() {
			return this.senias;
		}
		this.setVillanoSeleccionado = function (nuevoVillano){
			this.villanoSeleccionado = nuevoVillano;
		}
		
		this.setVillanos = function (villanosNuevos) {
			villanos = villanosNuevos;
		}
		
		this.eliminarSenia = function (seniaAEliminar) {
			var seniasAux = [];
			for (var i=0; i<this.senias.length; i++)
			{
				if (this.senias[i].nombre != seniaAEliminar)
				{
					seniasAux.push(this.senias[i]);
				}
			}
			this.senias = seniasAux;
		}
		
		this.eliminarHobbie = function(hobbieAEliminar) {
			var hobiesAux = [];
			for (var i=0; i<this.hobbies.length; i++)
			{
				if (this.hobbies[i].nombre != hobbieAEliminar)
				{
					hobiesAux.push(this.hobbies[i]);
				}
			}
			this.hobbies = hobiesAux;
		}
		
		this.fetchVillanos = function(){
  			CarmenService.fetchVillanos(this);
  		}
		
		this.fetchVillanos();
		
		this.deleteVillanoConId = function(idVillano) {
			console.log(idVillano);
			CarmenService.borrarVillanoConId(idVillano, this);
		}
		
		this.editarVillano = function() {
			this.villanoSeleccionado.nombre = this.nombre;
			this.villanoSeleccionado.sexo = "Hombre"; // cambiar
			this.villanoSeleccionado.seniasParticulares = this.senias;
			this.villanoSeleccionado.hobbies = this.hobbies;
			CarmenService.editarVillanoConId(this.villanoSeleccionado.id, this.villanoSeleccionado, this);
		}
	
		this.getVillanoConId = function(idVillano) {
			CarmenService.villanoConId(idVillano, this);
		}
		
		this.getHobbies = function() {
			return this.hobbies;
		}
		
  });
