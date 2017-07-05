package edu.ui.view.CarmenSan10

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.aop.windows.TransactionalDialog
import edu.ui.domain.AppModel.ExpedienteAppModel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.ui.domain.CarmenSan10.Caracteristicas
import edu.ui.domain.AppModel.VillanoAppModel
import org.uqbar.arena.layout.HorizontalLayout

class EditarVillanoWindow extends TransactionalDialog<ExpedienteAppModel>
{	
	new(WindowOwner parent, ExpedienteAppModel model) 
	{
		super(parent, model)
		title = defaultTitle
	}
	
	// reimplementar este metodo
	def defaultTitle() 
	{
		"Expediente - Editar Villano"
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		var generalPanel = new Panel(mainPanel)
		
			val editItem = new Panel(generalPanel) => [
				layout = new ColumnLayout(2)
			]
			
			new Label(editItem) => [
				text = "Nombre:"
			]
			
			new TextBox(editItem) => [
				value <=> "villanoSeleccionado.nombre"
				width = 200
			]
			
			new Label(editItem) => [
				text = "Sexo:"
			]
			
			new TextBox(editItem) => [
				value <=> "villanoSeleccionado.sexo"
				width = 200
			]
			
			new Label(editItem) => [
				text = "Señas Particulares:"
			]
			
			new Button(editItem) => [
				caption = "Editar Señas Particulares"
				onClick([| this.editarSeniasParticulares])
			]
			
			var tablaSenias = new Table<Caracteristicas>(generalPanel, typeof(Caracteristicas)) => [
				items <=> "villanoSeleccionado.seniasParticulares"
			]
				new Column<Caracteristicas>(tablaSenias) => [
					title = "Seña"
					bindContentsToProperty("nombre")
				]
			
			
			val editItem2 = new Panel(generalPanel) => [
				layout = new ColumnLayout(2)
			]
			
			new Label(editItem2) => [
				text = "Hobbies:"
			]
			
			new Button(editItem2) => [
				caption = "Editar Hobbies"
				onClick([| this.editarHobbies])
			]
			
			val tablaHobbies = new Table<Caracteristicas>(generalPanel, typeof(Caracteristicas)) => [
				items <=> "villanoSeleccionado.hobbies"
			]
				new Column<Caracteristicas>(tablaHobbies) => [
					title = "Hobbie"
					bindContentsToProperty("nombre")
				]
		
			val editHor = new Panel(generalPanel) => [
					layout = new HorizontalLayout
				]
			
				new Button(editHor) => [
					caption = "Aceptar"
					onClick([| realizarCambios() ])
					setAsDefault
					disableOnError
				]
	}
	
	def editarHobbies() 
	{
		val model = new VillanoAppModel(modelObject.villanoSeleccionado)
		new EditarHobbiesWindow (this, model).open()
	}
	
	def editarSeniasParticulares() 
	{
		val model = new VillanoAppModel(modelObject.villanoSeleccionado)
		new EditarSeniasWindow(this, model).open()
	}
	
	override protected addActions(Panel actionsPanel) 
	{
	}
	
	def realizarCambios() 
	{
		modelObject.validarEdicion() 
		this.accept
	}
	
}