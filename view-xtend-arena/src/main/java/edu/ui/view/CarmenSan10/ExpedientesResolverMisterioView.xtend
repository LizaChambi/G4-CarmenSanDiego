package edu.ui.view.CarmenSan10

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.AppModel.ExpedienteAppModel

class ExpedientesResolverMisterioView extends ExpedienteMenuDeAccionesView {
	
	new (WindowOwner parent, ExpedienteAppModel model){
		super(parent, model)
	}
	
	override defaultTitle() {
		"Resolviendo: " + modelObject.nombreDelCaso + " - Expedientes"
	}
	
	override botonesDeEdicion(Panel botonera){}
	
	override protected addActions(Panel actionsPanel) {
	}
	
}