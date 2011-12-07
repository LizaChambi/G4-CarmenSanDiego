package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.SimpleWindow
import edu.ui.domain.AppModel.MapamundiAppModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Label
import edu.ui.domain.AppModel.ResolverMisterioAppModel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout

class ViajarWindow extends SimpleWindow<ResolverMisterioAppModel>{
	
	new(WindowOwner parent, ResolverMisterioAppModel model) 
	{
		super(parent, model)
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{	
		title = "Viajar"
		
		val titulo = new Panel(mainPanel) => [
						layout = new ColumnLayout(2)
						
						new Label(it) => [
							text = "Estas en: "
						]
						
						new Label(it) => [
						value <=> "nombrePaisActual"
						]	
					]
		
		// Add Table componente propio
		/* 
		val table = new Table<Pais>(mainPanel, typeof(Pais)) => [
			
			items <=> "paisesConexionAerea" // método que contiene la lista de paises
			value <=> "paisSeleccionado" // asocia el valor seleccionado con la propiedad paisSeleccionado
			
			new Column<Pais>(it) => [
					title = "Posibles destinos"
					//background = Color.GRAY
					fixedSize = 200
					//bindContentsToProperty("nombrePais") // nombre de la propiedad con la que bindea en cada Pais
			]
		]
		*/
		
		new List<Pais> (mainPanel) => [
			bindItemsToProperty("conexionesDelPaisActual").adapter = new PropertyAdapter(Pais, "nombrePais")
			bindValueToProperty("paisSeleccionado")
		]
	}
	
	override protected addActions(Panel actionsPanel) {
		
		val elementSelected = new NotNullObservable("paisSeleccionado")
		val inicioDelJuego = new NotNullObservable("enInicioDelJuego")
		
		new Button(actionsPanel) => [
			caption = "Volver al Pais anterior"
			onClick[|regresarAlPaisAnterior]
			bindEnabled(inicioDelJuego)
			setAsDefault // se asocia con el <Enter> del usuario
		]
		
		new Button(actionsPanel) => [
			caption = "Viajar"
			onClick [| viajar]
			bindEnabled(elementSelected)
			setAsDefault
		]
	}
	
	def viajar() 
	{
		modelObject.viajar
		this.close()
	}
	
	def regresarAlPaisAnterior() 
	{
		modelObject.regresarAlPaisAnterior
		this.close()
	}
	
}