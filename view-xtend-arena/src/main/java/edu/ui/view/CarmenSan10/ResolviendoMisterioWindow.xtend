package edu.ui.view.CarmenSan10

import edu.ui.domain.CarmenSan10.Detective
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import edu.ui.view.runnable.CarmenApplication

class ResolviendoMisterioWindow extends SimpleWindow<Detective>
{
	new(CarmenApplication parent, Detective model) 
	{
		super(parent, model)
		title = "Resolviendo:" // + model.tituloDelCaso
	}
	
	override createFormPanel(Panel mainPanel) 
	{
		val panelDeAcciones = new Panel(mainPanel)
		panelDeAcciones.layout = new ColumnLayout(2)
		
		new Label(panelDeAcciones).text = "Estás en:"
		new Label(panelDeAcciones).text = "Lugares"
		
		val panelOrdenDeArresto = new Panel(panelDeAcciones)
		panelOrdenDeArresto.layout= new ColumnLayout(1)
		boton (panelOrdenDeArresto, "Orden de arresto")
		estadoDeLaOrdenDeArresto(panelOrdenDeArresto)
		
		boton (panelDeAcciones, "Biblioteca")
		boton(panelDeAcciones, "Viajar")
		boton(panelDeAcciones, "Club")
		boton (panelDeAcciones, "Expedientes")
		boton(panelDeAcciones, "Embajada")
		
		val panelHistorico = new Panel(mainPanel)
		panelHistorico.layout = new VerticalLayout
		
		new Label(panelHistorico).text = "Recorrido criminal:"
	}
	
	def estadoDeLaOrdenDeArresto(Panel panel) 
	{
		new Label(panel).text = "Orden ya emitida: Carmen Sandiego"
	}
	
	def boton (Panel panel, String nombreDelBoton) 
	{
		new Button(panel) => [
			caption = nombreDelBoton
			//onClick [ | botonDeDialog ]
			]
	}
	
	override addActions(Panel actionsPanel) 
	{
	}
	
}