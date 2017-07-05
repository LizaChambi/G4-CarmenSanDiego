package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import edu.ui.domain.AppModel.ResolverMisterioAppModel

class InicioDelJuegoWindow extends SimpleWindow<ResolverMisterioAppModel> 
{
	new(WindowOwner parent, ResolverMisterioAppModel model) 
	{
		super(parent, model)
		
	}
	
	override createFormPanel(Panel mainPanel) 
	{
		title = modelObject.nombreDelCaso
		val panelDelCaso = new Panel(mainPanel)
		
		//panelDelCaso.layout = new VerticalLayout()
		
		new Label(panelDelCaso).text = "Detective, tenemos un caso para usted!"
		val detalleDelCaso = new Panel(panelDelCaso)
		
		detalleDelCaso.layout = new VerticalLayout
		
		new Label(detalleDelCaso).text = modelObject.reporteDelActoCriminal
		
	}
	
	override addActions(Panel actionsPanel) 
	{
		new Button(actionsPanel) => [
			caption = "Aceptar el caso"
			onClick [ | resolverMisterio ]
			]
	}
	
	def resolverMisterio() 
	{
		new ResolviendoMisterioWindow(this, modelObject).open
	}
}