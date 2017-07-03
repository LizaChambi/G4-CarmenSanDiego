package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.SimpleWindow
 import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.AppModel.MapamundiAppModel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.bindings.NotNullObservable
import edu.ui.domain.CarmenSan10.Caracteristicas
import edu.ui.domain.CarmenSan10.Mapamundi

class MapamundiWindow extends SimpleWindow<MapamundiAppModel>{
	
	new(WindowOwner parent, Mapamundi model) {
		super(parent, new MapamundiAppModel(model))
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Mapamundi"
		
		val general = new Panel(mainPanel) => [
				layout = new HorizontalLayout
		]
				
			val elementSelected = new NotNullObservable("itemSeleccionado")
				
			val ladoIzq = new Panel(general)
				
			var table = new Table<Pais>(ladoIzq, typeof(Pais)) => [
				height = 600
				width = 200 
				items <=> "mapa.paises"
				value <=> "itemSeleccionado"
			]
				
				new Column<Pais>(table) => [
					title = "Paises"
					fixedSize = 150
					bindContentsToProperty("nombrePais")
				]
			
				new Button(ladoIzq) => [
					caption = "Eliminar"
					onClick([|modelObject.eliminarPaisSeleccionado])
					bindEnabled(elementSelected)
					
				]
				
				new Button(ladoIzq) => [
					caption = "Editar"
					onClick ([|editarPais])
					bindEnabled(elementSelected)
				]
				
				new Button(ladoIzq) => [
					caption = "Nuevo"
					onClick ([|this.agregarNuevoPais])
				]
			
			val ladoDer = new Panel(general)
				
				val horPanel = new Panel(ladoDer) => [
					layout = new HorizontalLayout
				]
				
				new Label(horPanel) => [
					text = "Nombre:"
				]
				
				new Label(horPanel) => [
					value <=> "itemSeleccionado.nombrePais"
				]
				
			
				new Label(ladoDer).text = "Características"
				
				/**
				 * Es obligatorio definir(Table)
				 * 	- la propiedad items contra una colección de elementos de tipo R
				 *  - al menos una columna
				 */
				
				var tableT = new Table<Caracteristicas>(ladoDer, typeof(Caracteristicas)) => [
					items <=> "itemSeleccionado.caracteristicaPais"
					value <=> "itemSeleccionado"
				]
				
					new Column<Caracteristicas>(tableT) => [
						title = "Caraterísticas"
						fixedSize = 200
						bindContentsToProperty("nombre")
					]
				
				new Label(ladoDer).text = "Conexiones"
				
				var table2 = new Table<Pais>(ladoDer, typeof(Pais)) => [
					items <=> "itemSeleccionado.paisesConexionAerea"
					value <=> "itemSeleccionado"
				]
					
					new Column<Pais>(table2) => [
						title = "Conexiones"
						fixedSize = 200
						bindContentsToProperty("nombrePais")
					]
			
				new Label(ladoDer).text = "Lugares De Interes"
				
				var table3 = new Table<Pais>(ladoDer, typeof(Pais)) => [
					items <=> "itemSeleccionado.lugares"
					value <=> "itemSeleccionado"
				]
				
					new Column<Pais>(table3) => [
						title = "Lugares"
						fixedSize = 200
						bindContentsToProperty("nombreLugares")
					]
	}
	
	def agregarNuevoPais() 
	{
		new NuevoPaisWindow(this, modelObject).open
	}
	
	def editarPais() 
	{
		new EditarPaisWindows(this, modelObject).open
	}
	
	override protected addActions(Panel actionsPanel) {}
	
}