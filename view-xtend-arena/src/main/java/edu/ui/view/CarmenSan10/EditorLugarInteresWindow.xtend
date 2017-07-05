package edu.ui.view.CarmenSan10

import edu.ui.view.CarmenSan10.EditorSuperConexion
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import edu.ui.domain.AppModel.PaisAppModel
import org.uqbar.arena.widgets.Selector
import edu.ui.domain.CarmenSan10.LugarDeInteres
import org.uqbar.arena.bindings.ObservableProperty

class EditorLugarInteresWindow extends EditorSuperConexion {
	
	new(WindowOwner owner, PaisAppModel model) {
		super(owner, model)
	}
	
	override defaultTitle() {
		"Editar Lugares"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val general = new Panel(mainPanel)
		
		val table = new Table<LugarDeInteres>(general, typeof(LugarDeInteres)) => [
			items <=> "pais.lugares"
			value <=> "lugarSeleccionado"
		]
		
		new Column<LugarDeInteres>(table) => [
			title = "Lugares de interés"
			bindContentsToProperty("nombre")
		]
		
		new Button(general) => [
			caption = "Eliminar"
			onClick([| modelObject.eliminarLugarSelecionado])
		]
		
		val editHor = new Panel(general) =>[
			layout = new HorizontalLayout
		]
		
		
		new Selector<LugarDeInteres>(editHor) => [
			allowNull(true)
			value <=> "lugarNuevoSeleccionado"
			val propiedadModelos = bindItems(new ObservableProperty(modelObject, "lugaresPosibles"))
			propiedadModelos.adaptWith(typeof(LugarDeInteres), "nombre")
		]
		
		
		new Button(editHor) => [
			caption = "Agregar"
			onClick([| this.modelObject.agregarLugarSeleccionado])
		]
		
		new Button(general) => [
			caption = "Aceptar"
			onClick([| this.accept])
		]
	}
	
}