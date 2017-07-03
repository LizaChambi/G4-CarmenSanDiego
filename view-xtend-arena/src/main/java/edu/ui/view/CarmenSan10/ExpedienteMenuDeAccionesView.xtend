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
import edu.ui.domain.CarmenSan10.Expediente

class ExpedienteMenuDeAccionesView extends SimpleWindow<ExpedienteAppModel> {
	
	new(WindowOwner parent, Expediente exp) {
		super(parent, new ExpedienteAppModel(exp))
		title = defaultTitle
	}
	
	def defaultTitle() {
		"Expedientes"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val general = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]
		
		val ladoIzq = new Panel(general)
		
		var table = new Table<Villano>(ladoIzq, typeof(Villano)) => [
			height = 200
			width = 450
			bindItemsToProperty("todosLosVillanos")
			bindValueToProperty("selectedVillano")
		
		]
			
		new Column<Villano>(table) => [
			title = "Villano"
			fixedSize = 150
			bindContentsToProperty("nombre")
		]
		
		new Button(ladoIzq) => [
			caption = "Nuevo"
		]
		
		new Button(ladoIzq) => [
			caption = "Editar"
		]
	}
	
	override protected addActions(Panel actionsPanel) {
		
	}
	
	
}