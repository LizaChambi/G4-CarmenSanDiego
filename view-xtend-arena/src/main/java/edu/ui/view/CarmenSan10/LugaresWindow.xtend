package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.Dialog
import edu.ui.domain.AppModel.LugarInteresAppModel

class LugaresWindow extends Dialog<LugarInteresAppModel>{
	
	new(WindowOwner owner, LugarInteresAppModel model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Resolviendo: " + modelObject.nombreDelCaso
		
		val form = new Panel(mainPanel)//.layout = new VerticalLayout
		
		form.width = 200
		
		new Label(form) =>[
			text = "Estas visitando: " + modelObject.nombreDelLugar
		]
		
		new Label(form) => [
			text = modelObject.preguntarAlOcupante
			//width = 200
		]
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Continuar"
			onClick[| validacionParaContinuar]
		]
	}
	
	def validacionParaContinuar() 
	{
		if (modelObject.esElFinDelJuego)
			abrirResultadoDelJuego()	
		this.close()
	}
	
	def abrirResultadoDelJuego() 
	{
		if (modelObject.estaResuelto())
		{
			modelObject.casoResulto()
			new FinDelJuegoWindow(this, modelObject).open
		}
		modelObject.casoImpune()
		new FinDelJuegoWindow(this, modelObject).open
	}
	
}