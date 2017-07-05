package edu.ui.view.CarmenSan10

import edu.ui.domain.AppModel.ResolverMisterioAppModel
import edu.ui.domain.CarmenSan10.Villano
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class OrdenArrestoWindow extends SimpleWindow<ResolverMisterioAppModel>{
	
	new(WindowOwner parent, ResolverMisterioAppModel model) {
		super(parent, model)
		title = "Resolviendo:" + modelObject.nombreDelCaso
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val form = new Panel(mainPanel)
		
		new Label(form) => [
			text = "Orden de arresto emitida contra:"
		]
		
		val list = new Panel(form) => [
			layout = new HorizontalLayout
		]
		
		new Label(list) => [
			text = "Villano:"
		]
		
		new Selector<Villano>(list) => [
			allowNull(false)
			items <=> "expediente.villanos"
			value <=> "villanoSeleccionado"
			val propiedadModelos = bindItems(new ObservableProperty(modelObject, "expediente.villanos"))
			propiedadModelos.adaptWith(typeof(Villano), "nombre") // tipo y propiedad de cada elemento con ese tipo
		]
		
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Generar orden de arresto"
			onClick ([|generarOrdenDeArresto()])
		]
	}
	
	protected def void generarOrdenDeArresto() 
	{
		modelObject.generarOrdenDeArrestoPara
		this.close()
	}
	
	def defaultTitle(String tituloDelCaso) {
		"Resolviendo: " + tituloDelCaso
	}
	
}