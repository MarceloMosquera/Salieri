package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Front.AppModel.LoginAppModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class LoginWindow extends SimpleWindow<LoginAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new LoginAppModel)
		title = "Login"
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new HorizontalLayout

		new Button(panel) => [
			caption = "Ok"
			onClick [ | entrar ]
			setAsDefault
		]

		
		new Button(panel) => [
			caption = "Cancelar"
			onClick [ | cancelar ]
		]
		

	}
	
	def cancelar() {
		modelObject.limpiar
	}
	def entrar() {
		modelObject.login
//				this.entrar
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)
		
		new Label(panelTexto).text="Usuario"
		new TextBox(panelTexto) =>[
			width = 150
			value <=> "nombreUsuarioABuscar"
			]
		
		new Label(panelTexto).text="Contraseña"
		new TextBox(panelTexto) =>[
			width = 150
			value <=> "contrasenia"
			]	
		
		new Label(panelTexto) =>[
			value <=> "mensajeError"
			visible <=> "mensajeError"
			]	
			

	}
	
//	def void entrar() {
//		this.openDialog(
//			new ConsultaDeRecetaWindow(this, modelObject.usuarioLogin))
//	}
//	def openDialog(Dialog<?> dialog) {
//		dialog.open
//	}
	
	
}