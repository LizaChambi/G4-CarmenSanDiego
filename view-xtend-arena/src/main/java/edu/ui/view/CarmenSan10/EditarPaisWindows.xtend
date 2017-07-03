package edu.ui.view.CarmenSan10

import edu.ui.domain.CarmenSan10.Pais
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.aop.windows.TransactionalDialog
import edu.ui.domain.Repo.RepoMapamundi
import org.uqbar.commons.utils.ApplicationContext
import edu.ui.domain.AppModel.PaisAppModel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.ui.domain.CarmenSan10.Caracteristicas
import edu.ui.domain.AppModel.MapamundiAppModel
import edu.ui.domain.CarmenSan10.LugarDeInteres

class EditarPaisWindows extends TransactionalDialog<MapamundiAppModel>{
	
	new(WindowOwner parent, MapamundiAppModel model) {
		super(parent, model)
		title = defaultTitle
	}
	
	def defaultTitle() {
		"Mapamundi-Editar Pais"		
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val general = new Panel(mainPanel)
			
			val editCol = new Panel(general) => [
				layout = new ColumnLayout(2)
			]
			
				new Label(editCol) => [
					text = "Nombre:"
				]
				
				new TextBox(editCol) => [
					value <=> "itemSeleccionado.nombrePais"
					width = 200
				]
				
				new Label(editCol) => [
					text = "Caracteristicas"
				]
				
				new Button(editCol) => [
					caption = "Editar Caracteristicas"
					onClick([| this.editarCaracteristica])
				]
			
			val table = new Table<Caracteristicas>(general, typeof(Caracteristicas)) => [
				items <=> "itemSeleccionado.caracteristicaPais"
				value <=> "itemSeleccionado"
			]
			
				new Column<Caracteristicas>(table) => [
					title = "Caracteristicas"
					bindContentsToProperty("nombre")
				]
			
			val editCol2 = new Panel(general) => [
				layout = new ColumnLayout(2)
			]
			
			new Label(editCol2) => [
				text = "Conexiones"
			]
			
			new Button(editCol2) => [
				caption = "Editar Conexiones"
				onClick([| this.editarConexiones])
			]
			
			val table2 = new Table<Pais>(general, typeof(Pais)) => [
				items <=> "itemSeleccionado.paisesConexionAerea"
			]
			
				new Column<Pais>(table2) => [
					title = "Conexiones"
					bindContentsToProperty("nombrePais")
				]
		
			val editCol3 = new Panel(general) => [
				layout = new ColumnLayout(2)
			]
			
				new Label(editCol3) => [
					text = "Lugar de interes"
				]
				
				new Button(editCol3) => [
					caption = "Editar Lugares"
					onClick([| this.editarLugares])
				]
				
				val table3 = new Table<LugarDeInteres>(general, typeof(LugarDeInteres)) => [
					items <=> "itemSeleccionado.lugares"
				]
				
					new Column<LugarDeInteres>(table3) => [
						title = "Lugares de Interes"
						bindContentsToProperty("nombre")
					]
		
				val editHor = new Panel(general) => [
					layout = new HorizontalLayout
				]
			
				new Button(editHor) => [
					caption = "Aceptar"
					onClick([| this.accept])
					setAsDefault
					disableOnError
				]
	}
	
	def editarConexiones() {
		var model = new PaisAppModel(modelObject.itemSeleccionado)
		new EditorSuperConexion(this, model).open
	}
	
	def editarLugares() {
		var model = new PaisAppModel(modelObject.itemSeleccionado)
		new EditorLugarInteresWindow(this, model).open
	}
	
	def editarCaracteristica() {
		var model = new PaisAppModel(modelObject.itemSeleccionado)
		new EditorCaracteristicaWindow(this, model).open
	}

	def realizarCambios() 
	{
		// Falta guardar cambios del pais seleccionado!!!!
		this.close()
	}
	
}