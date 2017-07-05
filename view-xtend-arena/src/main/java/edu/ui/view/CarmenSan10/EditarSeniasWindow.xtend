package edu.ui.view.CarmenSan10

import edu.ui.domain.AppModel.VillanoAppModel
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.arena.widgets.tables.Table

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.bindings.NotNullObservable

class EditarSeniasWindow extends TransactionalDialog<VillanoAppModel>{
	
	new(EditarVillanoWindow window, VillanoAppModel model) {
		super(window, model)
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = defaultTitle()
		
		val general = new Panel(mainPanel)
		
		val elementSelected = new NotNullObservable("seniaSeleccionada")
		
		val table = new Table<Caracteristicas>(general, typeof(Caracteristicas)) => [
			items <=> "villano.seniasParticulares"
			value <=> "seniaSeleccionada"
		]
		
		new Column<Caracteristicas>(table) => [
			title = "Seña"
			bindContentsToProperty("nombre")
		]
		
		new Button(general) => [
			caption = "Eliminar"
			onClick([| modelObject.eliminarSeniaSelecionada])
			bindEnabled(elementSelected)
		]
		
		val editHor = new Panel(general) =>[
			layout = new HorizontalLayout
		]
		
		new TextBox(editHor) => [
			value <=> "textNuevaSenia"
			width = 200
		]
		
		new Button(editHor) => [
			caption = "Agregar"
			onClick([| this.modelObject.agregarSenia])
		]
		
		new Button(general) => [
			caption = "Aceptar"
			onClick([| this.accept])
		]
	}
	
	def defaultTitle() {
		"Editar Señas Particulares"
	}
	
}