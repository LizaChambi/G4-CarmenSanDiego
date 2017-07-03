package edu.ui.view.CarmenSan10

import edu.ui.view.CarmenSan10.EditorSuperConexion
import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.TextBox
import edu.ui.domain.CarmenSan10.Caracteristicas
import org.uqbar.arena.bindings.NotNullObservable
import edu.ui.domain.AppModel.PaisAppModel

class EditorCaracteristicaWindow extends EditorSuperConexion {
	
	new(WindowOwner owner, PaisAppModel model) {
		super(owner, model)
	}
	
	override defaultTitle() {
		"Editar Características"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val general = new Panel(mainPanel)
		
		val elementSelected = new NotNullObservable("carSeleccionada")
		
		val table = new Table<Caracteristicas>(general, typeof(Caracteristicas)) => [
			
			items <=> "pais.caracteristicaPais"
			value <=> "carSeleccionada"
		]
		
		new Column<Caracteristicas>(table) => [
			title = "Caracteristicas"
			bindContentsToProperty("nombre")
		]
		
		new Button(general) => [
			caption = "Eliminar"
			bindEnabled(elementSelected)
			onClick([| modelObject.eliminarCaracteristicaSelecionada])
		]
		
		val editHor = new Panel(general) =>[
			layout = new HorizontalLayout
		]
		
		new TextBox(editHor) => [
			value <=> "textCaracteristica"
			width = 200
		]
		
		new Button(editHor) => [
			caption = "Agregar"
			onClick([| this.modelObject.agregarCaracteristica])
		]
		
		new Button(general) => [
			caption = "Aceptar"
			onClick([| this.accept])
		]
	}
	
}