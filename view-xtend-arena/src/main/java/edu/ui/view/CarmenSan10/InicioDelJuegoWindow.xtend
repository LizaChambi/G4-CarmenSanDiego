package edu.ui.view.CarmenSan10

import edu.ui.domain.CarmenSan10.Caso
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import edu.ui.domain.CarmenSan10.Detective
import edu.ui.domain.CarmenSan10.ACME
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.ColumnLayout
import edu.ui.domain.AppModel.ResolverMisterioAppModel
import org.uqbar.commons.model.IModel

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
		panelDelCaso.layout = new VerticalLayout()
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