package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import edu.ui.domain.AppModel.LugarInteresAppModel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import java.awt.Color

class FinDelJuegoWindow extends Dialog<LugarInteresAppModel>{
	
	Color fgcolor
	
	new(WindowOwner owner, LugarInteresAppModel model, Color c) {
		super(owner, model)
		fgcolor = c
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = modelObject.nombreDelCaso + "- Resuelto"
		
		agregarCampo(mainPanel, "tituloDelResultado") => [foreground = fgcolor]
		agregarCampo(mainPanel, "estadoFinalDelCaso")
		agregarCampo(mainPanel, "resumenFinal")
		
		new Button(mainPanel) => [
			caption = modelObject.estadoBoton
			onClick ([|this.close()])
		]	
	}
	
	def agregarCampo(Panel p, String label) 
	{
		new Label(p) => [
			value <=> label
		]
	}
	
}