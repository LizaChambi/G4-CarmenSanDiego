package edu.ui.view.CarmenSan10

import edu.ui.domain.AppModel.ExpedienteAppModel
import edu.ui.domain.AppModel.LugarInteresAppModel
import edu.ui.domain.AppModel.ResolverMisterioAppModel
import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.ui.domain.CarmenSan10.LugarDeInteres

class ResolviendoMisterioWindow extends SimpleWindow<ResolverMisterioAppModel>
{
	new(WindowOwner parent, ResolverMisterioAppModel model) 
	{
		super(parent, model)
	}
	
	override createFormPanel(Panel mainPanel) 
	{
		title = "Resolviendo:" + modelObject.tituloDelCaso
		val generalPanel = new Panel(mainPanel) => [
			layout = new VerticalLayout
				
			val juego = new Panel(mainPanel) => [
			layout = new HorizontalLayout
			
				val left = new Panel(it) => [
					
					val titulo = new Panel(it) => [
						layout = new ColumnLayout(2)
						
						new Label(it) => [
							text = "Estas en: "
						]
						
						new Label(it) => [
						value <=> "nombrePaisActual"
						]	
					]
					
					new Button(it) => [
						caption = "Orden De Arresto"
						onClick ([|abrirOrdenDeArresto])
					]
					
					// Estado de la orden de arresto
					val estadoDeLaOrden = new Panel(it) => [
						layout = new ColumnLayout(2)
						
						new Label(it) => [
							value <=> "estadoDeLaOrdenDeArresto"
							fontSize = 8
						]
						
						new Label(it) => [
							fontSize = 8
							value <=> "ordenPara"
						]	
					]
					
					new Button(it) => [
						caption = "Viajar"
						onClick ([|abrirViajarAPais])
					]
				
					new Button(it) => [
						caption = "Expedientes"
						onClick ([|verExpedientes])
					]
				]
				
				val right = new Panel(it) => [
					
					new Label(it).text = "Lugares:"
					
					new Button(it) => [
						caption = modelObject.lugar1.nombre
						onClick ([|abrirLugarDeInteres(modelObject.lugar1)])
					]
					
					new Button(it) => [
						caption = modelObject.lugar2.nombre
						onClick ([|abrirLugarDeInteres(modelObject.lugar2)])
					]
					
					new Button(it) => [
						caption = modelObject.lugar3.nombre
						onClick ([|abrirLugarDeInteres(modelObject.lugar3)])
					]		
				]
			]
			
			// Historial de los viajes realizados
			val estado = new Panel(mainPanel) => [
				layout = new VerticalLayout
			
				new Label(it).text = "Recorrido criminal:"
				
				new Label(it) => [
					value <=> "paisesAcertados"
				]	
				
				new Label(it).text = "Destinos fallidos:"
				
				// mejor pasarlo a tabla si se puede
				new List<Pais> (mainPanel) => [
					bindItemsToProperty("paisesFallidos").adapter = new PropertyAdapter(Pais, "nombrePais")
				]	
			]
		]
	}
//
//	def botonDePedirPista(Panel p, LugarDeInteres lugar)
//	{
//		new Button(p) => [
//						caption = lugar.nombre
//						onClick ([|abrirLugarDeInteres(lugar)])
//					]	
//	}
	

	def abrirLugarDeInteres(LugarDeInteres lugar) 
	{
		val model = new LugarInteresAppModel(lugar, modelObject.caso, modelObject.detective)
		new LugaresWindow(this, model).open
	}
	
	def verExpedientes() 
	{
		val model = new ExpedienteAppModel(modelObject.expediente, modelObject.tituloDelCaso)
		new ExpedientesResolverMisterioView(this, model).open
	}
	
	def abrirViajarAPais() 
	{
		new ViajarWindow(this, modelObject).open
	}
	
	def abrirOrdenDeArresto() 
	{
		new OrdenArrestoWindow(this, modelObject).open
	}
	
	def void destinosFallidos(Panel panelPrincipal) 
	{
		val panelDestinosFallidos = new Panel (panelPrincipal)
		panelDestinosFallidos.layout = new VerticalLayout
		new Label(panelDestinosFallidos).text = "Destinos fallidos:"
		tablaDePaises(panelDestinosFallidos)
	}
	
	def tablaDePaises(Panel panelPrincipal) 
	{
		// Add componente propio de Lista/Tabla
	}
	
//	def recorridoCriminal(Panel panelPrincipal) 
//	{
//		val panelRecorrido = new Panel (panelPrincipal)
//		panelRecorrido.layout = new VerticalLayout
//		new Label(panelRecorrido).text = "Argentina" + "<-" + "Peru" + "<-" + "Italia" + "<-" + "Egipto"
//	}
	
	def estadoDeLaOrdenDeArresto() 
	{
		if (modelObject.detective.ordenDeArresto == "")
		{
			"Sin emitir orden de arresto."
		}
		else
		{
			"Orden ya emitida:" + modelObject.detective.ordenDeArresto
		}
	}
	
	
	override addActions(Panel actionsPanel) 
	{
	}
	
}