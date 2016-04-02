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
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.commons.utils.ApplicationContext
import edu.unsam.Salieri.Domain.Usuario

class LoginWindow extends SimpleWindow<LoginAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new LoginAppModel)
		title = "Login"
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new HorizontalLayout
		val anchoBotones = 52
		
		new Button(panel) => [
			caption = "Entrar"
			width = anchoBotones
			onClick [ | entrar ]
			setAsDefault
		]

		
		new Button(panel) => [
			width = anchoBotones
			caption = "Resetear"
			onClick [ | cancelar ]
		]
		
		new Button(panel) => [
			width = anchoBotones
			caption = "Salir"
			onClick[
				| System.exit(0)
			]
		
		]
		

	}
	
	def cancelar() {
		modelObject.limpiar
	}
	def entrar() {
		if (!modelObject.login) { 
			ApplicationContext.instance.configureSingleton(typeof(Usuario), modelObject.usuarioLogin)
			abrirPrincipal
		}
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)
		
		new Label(panelTexto).text="Usuario"
		new TextBox(panelTexto) =>[
			width = 150
			value <=> "nombreUsuarioABuscar"
			]
		
		new Label(panelTexto).text="Contraseña"
		new PasswordField(panelTexto) =>[
			width = 150
			value <=> "contrasenia"
			]	
		
		new Label(panelTexto) =>[
			value <=> "mensaje"
			visible <=> "mensaje"
			]	
	}
	
	def void abrirPrincipal() {
		this.close
		this.openWindow(
			new PrincipalWindow(this))
	}
	def openWindow(SimpleWindow<?> window) {
		window.open
	}
	
	
}