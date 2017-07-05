package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.AppModel.ExpedienteAppModel

class NuevoVillanoWindow extends EditarVillanoWindow
{
	
	new(WindowOwner parent, ExpedienteAppModel model) {
		super(parent, model)
	}
	
	override def defaultTitle() 
	{
		"Expediente - Nuevo Villano"
	}
	
	override def realizarCambios()
	{
		// Agregar el nuevo villano
		modelObject.validarEdicion()
		modelObject.agregarNuevoVillano()
		this.accept
	}
}