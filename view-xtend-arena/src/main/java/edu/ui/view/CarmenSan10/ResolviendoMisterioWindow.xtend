package edu.ui.view.CarmenSan10

import edu.ui.domain.AppModel.ResolverMisterioAppModel
import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.AppModel.LugarInteresAppModel
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.List

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
					
					new Label(it).text = "Estás en:" + this.modelObject.nombrePaisActual().toUpperCase // lo pasa a mayuscula
					
					new Button(it) => [
						caption = "Orden De Arresto"
						onClick ([|abrirOrdenDeArresto])
					]
					
					new Label(it) => [
						fontSize = 8
						text = estadoDeLaOrdenDeArresto() // no esta funcionando: actualizar el estado
					]
					
					new Button(it) => [
						caption = "Viajar"
						onClick ([|abrirViajarAPais])
						// Al viajar debe deshabilitarse los botones en caso de poder viajar o no.
					]
				
					new Button(it) => [
						caption = "Expedientes"
						onClick ([|verExpedientes])
					]
				]
				
				val right = new Panel(it) => [
					
					new Label(it).text = "Lugares:"
					
					new Button(it) => [
						caption = modelObject.nombreDel1erLugarInteres
						onClick ([|abrir1erLugarDeInteres])
					]
					
					new Button(it) => [
						caption = modelObject.nombreDel2doLugarInteres
						onClick ([|abrir2erLugarDeInteres])
					]
					
					new Button(it) => [
						caption = modelObject.nombreDel3erLugarInteres
						onClick ([|abrir3erLugarDeInteres])
					]		
				]
			]
			
			val estado = new Panel(mainPanel) => [
				layout = new VerticalLayout
			
				new Label(it).text = "Recorrido criminal:"
				new Label(it).text = recorridoDelCriminal()
				
				new Label(it).text = "Destinos fallidos:"
				
				// mejor pasarlo a tabla si se puede
				new List<Pais> (mainPanel) => [
					bindItemsToProperty("paisesFallidos").adapter = new PropertyAdapter(Pais, "nombrePais")
				]
				
			]
		]
		
	}
	
	def recorridoDelCriminal() 
	{
		val nombrePaises = modelObject.recorridoCriminal
		var res = ""
		nombrePaises.reverse
		for (p : nombrePaises)
		{
			res = res + "<-" + p
		}
		res
	}
	
	def abrir3erLugarDeInteres() 
	{
		val model = new LugarInteresAppModel(modelObject.lugar3, modelObject.caso, modelObject.detective)
		new LugaresWindow(this, model).open
	}
	
	def abrir2erLugarDeInteres() 
	{
		val model = new LugarInteresAppModel(modelObject.lugar2, modelObject.caso, modelObject.detective)
		new LugaresWindow(this, model).open
	}
	
	protected def void abrir1erLugarDeInteres() 
	{
		val model = new LugarInteresAppModel(modelObject.lugar1, modelObject.caso, modelObject.detective)
		new LugaresWindow(this, model).open
	}
	
	def verExpedientes() 
	{
		//val model = new ExpedienteAppModel(modelObject.expediente)
		//new ExpedientesResolverMisterioView(this, model).open
		// Abrir el expediente que es solo de visualizacion.
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
	
	def recorridoCriminal(Panel panelPrincipal) 
	{
		val panelRecorrido = new Panel (panelPrincipal)
		panelRecorrido.layout = new VerticalLayout
		new Label(panelRecorrido).text = "Argentina" + "<-" + "Peru" + "<-" + "Italia" + "<-" + "Egipto"
	}
	
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