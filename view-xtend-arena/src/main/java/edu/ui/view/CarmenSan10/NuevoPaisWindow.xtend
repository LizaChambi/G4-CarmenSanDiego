package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.CarmenSan10.Pais
import edu.ui.domain.AppModel.MapamundiAppModel

class NuevoPaisWindow extends EditarPaisWindows{
	
	new(WindowOwner parent, MapamundiAppModel model) {
		super(parent, model)
	}
	
	override defaultTitle() {
		"Mapamundi - Nuevo Pais"
	}
	
	override def realizarCambios() 
	{
		// Agregar al pais seleccionado en mapamundi
		modelObject.agregarPais()
		this.close()
	}
}