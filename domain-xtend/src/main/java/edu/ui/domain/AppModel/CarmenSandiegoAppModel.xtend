package edu.ui.domain.AppModel

import edu.ui.domain.CarmenSan10.Mapamundi
import edu.ui.domain.CarmenSan10.ACME
import org.eclipse.xtend.lib.annotations.Accessors
import edu.ui.domain.Dummy.CarmenSan10Dummy
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class CarmenSandiegoAppModel 
{
	private Mapamundi mapamundi
	private ACME acme
	
	new () {}
	
	new(CarmenSan10Dummy dummy) {
		mapamundi = dummy.mapamundi
		acme = new ACME (dummy.expediente, dummy.doc, dummy.caso)
	}
	
}