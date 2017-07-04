package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.Dialog
import edu.ui.domain.AppModel.MapamundiAppModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import edu.ui.domain.AppModel.LugarInteresAppModel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button

class FinDelJuegoWindow extends Dialog<LugarInteresAppModel>{
	
	new(WindowOwner owner, LugarInteresAppModel model) {
		super(owner, model)
		
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = modelObject.nombreDelCaso + "- Resuelto"
		
		new Label(mainPanel) => [
						value <=> "tituloDelResultado"
					]
		new Label(mainPanel) => [
						value <=> "estadoFinalDelCaso"
					]
					
		new Label(mainPanel) => [
						value <=> "resumenFinal"
					]
		
		new Button(mainPanel) => [
						caption = modelObject.estadoBoton
						onClick ([|this.close()])
					]	
	}
	
}