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
import java.awt.Color

class LoginWindow extends SimpleWindow<LoginAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new LoginAppModel)
		title = "Login"
	}
	
	override void createMainTemplate(Panel mainPanel) {
		this.createFormPanel(mainPanel);
		this.createActionsPanel(mainPanel);
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new HorizontalLayout
		val anchoBotones = 73
		
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
	
	override protected createFormPanel(Panel mainPanel) {
		val anchoControles = 220
		val panelTexto = new Panel(mainPanel)
		new Label(panelTexto).text="Usuario"
		new TextBox(panelTexto) =>[
			width = anchoControles
			value <=> "nombreUsuarioABuscar"
			]
		
		new Label(panelTexto).text="Contraseña"
		new PasswordField(panelTexto) =>[
			width = anchoControles
			value <=> "contrasenia"
			]	
		
		new Label(panelTexto) =>[
			value <=> "mensaje"
			visible <=> "mensaje"
			foreground = Color.red
			]	
	}
	
	def cancelar() {
		modelObject.limpiar
	}
	def entrar() {
		if (modelObject.login) { 
			ApplicationContext.instance.configureSingleton(typeof(Usuario), modelObject.usuarioLogin)
			abrirPrincipal
		}
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