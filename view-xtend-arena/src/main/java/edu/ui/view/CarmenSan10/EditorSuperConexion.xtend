package edu.ui.view.CarmenSan10

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.bindings.ObservableProperty
import edu.ui.domain.AppModel.PaisAppModel

class EditorSuperConexion extends TransactionalDialog<PaisAppModel>{
	
	new(WindowOwner owner, PaisAppModel model) {
		super(owner, model)
		title = defaultTitle()
	}
	
	def defaultTitle() {
		"Editar Conexiones"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val general = new Panel(mainPanel)
		
		val table = new Table<Pais>(general, typeof(Pais)) => [
			items <=> "pais.paisesConexionAerea"
			value <=> "paisDeConexSeleccionado"
		]
		
		new Column<Pais>(table) => [
			title = "Conexiones"
			bindContentsToProperty("nombrePais")
		]
		
		new Button(general) => [
			caption = "Eliminar"
			onClick([| modelObject.eliminarConexionSelecionada])
		]
		
		val editHor = new Panel(general) =>[
			layout = new HorizontalLayout
		]
		
		new Selector<Pais>(editHor) => [
			allowNull(false)
			value <=> "paisDeConexNuevoSeleccionado"
			val propiedadModelos = bindItems(new ObservableProperty(this.modelObject, "paises"))
			propiedadModelos.adaptWith(typeof(Pais), "nombrePais") // opción A
		]
		
		new Button(editHor) => [
			caption = "Agregar"
			onClick([| this.modelObject.agregarConexionAerea])
		]
		
		new Button(general) => [
			caption = "Aceptar"
			onClick([| validarEdicion()])
		]
	}
	
	def validarEdicion()
	{
		//modelObject.validarEdicion()
		this.accept
	}
	
}