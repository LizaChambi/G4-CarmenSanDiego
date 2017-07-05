package edu.ui.view.CarmenSan10

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout
import edu.ui.domain.CarmenSan10.Mapamundi
import edu.ui.domain.AppModel.CarmenSandiegoAppModel
import edu.ui.domain.CarmenSan10.ACME
import edu.ui.domain.Dummy.CarmenSan10Dummy
import edu.ui.domain.CarmenSan10.Expediente
import edu.ui.domain.AppModel.ResolverMisterioAppModel
import edu.ui.domain.AppModel.ExpedienteAppModel

class MenuDeAccionesWindow extends SimpleWindow<CarmenSandiegoAppModel> {
	/*
	 * esta es la primer ventana que me aparece cuando inicio el juego.
	 */
	 CarmenSan10Dummy dummy = new CarmenSan10Dummy();
	 new (WindowOwner parent, CarmenSan10Dummy dummy){
	 	super (parent, new CarmenSandiegoAppModel(dummy))
	 }
		
		override def createMainTemplate (Panel mainPanel){
			title = "¿Donde esta Carmen Sandiego?"
			// Es importante colocar las siguientes 2 lineas, porque es la superclase la que los ejecuta:
			// Probar qué pasa comentandolas.
			taskDescription = ""
			super.createMainTemplate(mainPanel)
		}
		
		override protected createFormPanel(Panel mainPanel) {
			val panelDelFormulario = new Panel (mainPanel)=>[
				layout = new HorizontalLayout
			]
			new Label (panelDelFormulario)=>[
				text = "¿Qué haremos ahora Detective?"
				//foreground = Color.BLUE
			]
		}
		
		
		override protected addActions(Panel actionsPanel) {
			new Button (actionsPanel)=>[
				caption = "Resolver Misterio"
				onClick ([|iniciarJuego(modelObject.getAcme)])
			]
			new Button (actionsPanel)=>[
				caption = "Mapamundi"
				onClick ([|mapamundi(modelObject.getMapamundi)])
			]
			new Button (actionsPanel)=>[
				caption = "Expedientes"
				onClick ([|expediente(modelObject.getAcme.getVillanos)])
			]
			
		}
	
	def iniciarJuego(ACME acme) 
	{
		val resolviendoMisterio = new ResolverMisterioAppModel (modelObject.acme)
		new InicioDelJuegoWindow(this, resolviendoMisterio).open
		this.close()
	}
	
	def mapamundi(Mapamundi mapa) 
	{
		new MapamundiWindow(this,mapa).open
	}
	
	def expediente(Expediente villanos) 
	{
		val model = new ExpedienteAppModel(modelObject.acme.villanos)
		new ExpedienteMenuDeAccionesView(this, model).open
	}
	
		
}