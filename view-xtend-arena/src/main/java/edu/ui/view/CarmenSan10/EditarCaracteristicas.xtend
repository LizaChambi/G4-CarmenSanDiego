package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.WindowOwner
import edu.ui.domain.CarmenSan10.Pais

class EditarCaracteristicas extends EditorSuperConexion {
	
	new(WindowOwner owner) {
		super(owner, new Pais)
	}
	
	override defaultTitle() 
	{
		"Editar Característica"
	}
	
}