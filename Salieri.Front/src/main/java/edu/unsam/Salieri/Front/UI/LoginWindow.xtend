package edu.unsam.Salieri.Front.UI

import org.uqbar.arena.windows.SimpleWindow
import edu.unsam.Salieri.Front.AppModel.LoginAppModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog

class LoginWindow extends SimpleWindow<LoginAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new LoginAppModel)
		title = "Login"
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new HorizontalLayout

		new Button(panel) => [
			caption = "Ok"
//			onClick = [|
//				modelObject.autorizarLogin
//				this.entrar
//			]
			setAsDefault
			disableOnError
		]

		new Button(panel) => [
			caption = "Cancelar"
//			onClick = [|modelObject.clear]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)
		
		new Label(panelTexto).text="Usuario"
		new TextBox(panelTexto) =>[
			width = 150
			]
		
		new Label(panelTexto).text="Contraseña"
		new TextBox(panelTexto) =>[
			width = 150
			]	

	}
	
	def void entrar() {
//		this.openDialog(
//			new ConsultaDeRecetaWindow(this, modelObject.usuarioLogin))
	}
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
	
}