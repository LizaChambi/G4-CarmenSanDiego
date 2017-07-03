package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import edu.ui.domain.CarmenSan10.Expediente
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.tables.Column
import edu.ui.domain.CarmenSan10.Villano
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.ui.domain.AppModel.ExpedienteAppModel

class ExpedientesResolverMisterioView extends SimpleWindow<ExpedienteAppModel> {
	
	new (WindowOwner parent, ExpedienteAppModel model){
		super(parent, model)
	}
	
	override def createMainTemplate (Panel mainPanel){
		title = "Resolviendo: misterio - Expedientes"
		super.createMainTemplate(mainPanel)

	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panelDividido = new Panel (mainPanel) =>[
			layout = new ColumnLayout (2)
		]
		//a este panel lo divido en dos uno para la tabla y el otro para las demas cosas 
		this.createLeftPanel(panelDividido)
		// en este panel llevara la tabla de villanos
		this.createRightPanel (panelDividido)
		// este panel pondre los demas chiches...
	}
	
	
	def createLeftPanel(Panel panelPadre) {
		val panelIzquierdo = new Panel (panelPadre)=>[
			layout = new VerticalLayout // es el layout por defecto
		]
		
		var table = new Table<Villano>(panelIzquierdo, typeof(Villano)) => [
			height = 200 //ni idea
			width = 450  //tampoco
			bindItemsToProperty("villanos")
			bindValueToProperty("selectedVillano")
		]
			
		new Column<Villano>(table) => [
			title = "Villano"
			fixedSize = 150 // ni idea
			bindContentsToProperty("nombre")
		]
	
	}
	
	def createRightPanel(Panel panelPadre) {
		val panelDerecho = new Panel (panelPadre)
		this.crearPanelDetallesVillano (panelDerecho)
		new Label (panelDerecho) => [
			text = "Señas Particulares"
			//foreground = Color.BLUE 
		]
		// luego pongo la tabla
		var tablaDeArriba = new Table<Villano>(panelDerecho, typeof(Villano)) => [
			height = 200
			width = 450
			bindItemsToProperty("señas")
			bindValueToProperty("selectedSeña")
		]
			
		new Column<Villano>(tablaDeArriba) => [
			title = "Seña"
			fixedSize = 150 // ni idea
			bindContentsToProperty("razgosParticulares")//bindeamos a la seña del villano en cuestion
		]
		
		new Label (panelDerecho) => [
			text = "Hobbies"
			//foreground = Color.BLUE 
		]
		// ahora la otra tabla
		var tablaDeAbajo = new Table<Villano>(panelDerecho, typeof(Villano)) => [
			height = 200 
			width = 450 
			bindItemsToProperty("hobbies")
			bindValueToProperty("selectedHobbie")
		]
			
		new Column<Villano>(tablaDeAbajo) => [
			title = "Hobbie"
			fixedSize = 150 // ni idea
			bindContentsToProperty("hobbie")//bindeamos al nombre del villano en cuestion
		]
	}
	
	def crearPanelDetallesVillano(Panel panelDependiente) {
		val detallesPanel = new Panel (panelDependiente)=> [
			layout = new ColumnLayout(2)
		]
		new Label (detallesPanel) => [
			text = "Nombre"
			//foreground = Color.BLUE
		]
		new Label (detallesPanel) => [
			value <=> "nombre"
		]
		new Label (detallesPanel) => [
			text = "Sexo"
			//foreground = Color.BLUE 
		]
		new Label (detallesPanel) => [
			value <=> "sexo"
		]
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
}