package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import edu.ui.domain.CarmenSan10.Villano
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import edu.ui.domain.AppModel.ExpedienteAppModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.arena.layout.VerticalLayout

class ExpedienteMenuDeAccionesView extends SimpleWindow<ExpedienteAppModel> {
	
	new(WindowOwner parent, ExpedienteAppModel model) {
		super(parent, model)
		title = defaultTitle
	}
	
	// sobreescribir este metodo
	def defaultTitle() {
		"Expedientes"
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		val general = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]
		
		val panelIzquierdo = new Panel(general)
		
			var table = new Table<Villano>(panelIzquierdo, typeof(Villano)) => [
				height = 200
				width = 450
				bindItemsToProperty("expediente.villanos")
				bindValueToProperty("villanoSeleccionado")
			]
				
			new Column<Villano>(table) => [
				title = "Villano"
				fixedSize = 150
				bindContentsToProperty("nombre")
			]
			
			botonesDeEdicion(panelIzquierdo)
		
			val panelDerecho = new Panel(general)
				
				val panelDeDatos = new Panel(panelDerecho) => [
					layout = new VerticalLayout
				]
				
				val datoNombre = new Panel(panelDeDatos) => [
						layout = new ColumnLayout(2)
						
						new Label(it) => [
							text = "Nombre: "
						]
						
						new Label(it) => [
						value <=> "villanoSeleccionado.nombre"
						]	
				]
					
				val datoSexo = new Panel(panelDeDatos) => [
						layout = new ColumnLayout(2)
						
						new Label(it) => [
							text = "Sexo: "
						]
						
						new Label(it) => [
						value <=> "villanoSeleccionado.sexo"
						]	
				]
				
				new Label(panelDeDatos).text = "Señas Particulares:"
				
				var tablaSenias = new Table<Caracteristicas>(panelDeDatos, typeof(Caracteristicas)) => [
					items <=> "villanoSeleccionado.seniasParticulares"
					value <=> "villanoSeleccionado"
				]
				
				new Column<Caracteristicas>(tablaSenias) => [
					title = "Seña"
					fixedSize = 200
					bindContentsToProperty("nombre")
				]
				
				new Label(panelDeDatos).text = "Hobbies:"
				
				var tablaHobbie = new Table<Caracteristicas>(panelDeDatos, typeof(Caracteristicas)) => [
					items <=> "villanoSeleccionado.hobbies"
					value <=> "villanoSeleccionado"
				]
				
				new Column<Caracteristicas>(tablaHobbie) => [
					title = "Hobbie"
					fixedSize = 200
					bindContentsToProperty("nombre")
				]
		
	}
	
	// sobreescribir este metodo
	def botonesDeEdicion(Panel botonera) 
	{
		val elementedSelected = new NotNullObservable("villanoSeleccionado")
		
		new Button(botonera) => [
			caption = "Nuevo"
			onClick(|agregarNuevoVillano)
		]
		
		new Button(botonera) => [
			caption = "Editar"
			onClick(|editarVillano)
			bindEnabled(elementedSelected)
		]
	}
	
	def editarVillano() 
	{
		// Editar el usuario seleccionado, solo si es validero
		new EditarVillanoWindow(this, modelObject).open()
	}
	
	def agregarNuevoVillano() 
	{
		// agregar al exediente el villano nuevo solo si cumple con los requisitos necesarios
		modelObject.villanoSeleccionado = new Villano()
		new NuevoVillanoWindow(this, modelObject).open()
	}
	
	override protected addActions(Panel actionsPanel) {
		
	}
	
	
}