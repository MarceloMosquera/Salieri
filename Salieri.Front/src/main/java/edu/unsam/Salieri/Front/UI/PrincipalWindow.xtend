package edu.unsam.Salieri.Front.UI

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.tables.Table
import edu.unsam.Salieri.Domain.Reserva
import org.uqbar.arena.widgets.tables.Column
import edu.unsam.Salieri.Front.AppModel.PrincipalAppModel
import java.awt.Color
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.bindings.NotNullObservable

class PrincipalWindow extends SimpleWindow<PrincipalAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new PrincipalAppModel)
		title = "Pantalla principal"
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new VerticalLayout

		this.createGrillaReservasEfectuadas(panel)
		this.createBotones(panel)
		
	}
	
	def createBotones(Panel panel) {
		val elementSelected = new NotNullObservable("reservaSeleccionada")
		
		var panelHorizonal1 = new Panel(panel).layout = new HorizontalLayout
		new Button(panelHorizonal1) => [
			caption = "Cancelar Reserva"
			width = 150
//			onClick [ | entrar ]
			background = Color.darkGray
			bindEnabled(elementSelected)
		]
		
		
		var panelHorizonal2 = new Panel(panel).layout = new HorizontalLayout
		
		new Label(panelHorizonal2)=>[
			text =  ""
			width = 30
		]
		
		new Button(panelHorizonal2) => [
			caption = "Busqueda de vuelos"
			width = 350
//			onClick [ | entrar ]
			background = Color.BLUE
		]
		
		new Button(panelHorizonal2) => [
			caption = "Log de consultas hechas"
			width = 350
//			onClick [ | entrar ]
			setAsDefault
			background = Color.ORANGE
		]
	}
	
		
	def createGrillaReservasEfectuadas(Panel mainPanel) {
//		new Label(mainPanel).bindValueToProperty("labelResultado")

		new Label(mainPanel)=>[
			text =  "Reservas Efectuadas"
		]
		val gridReceta = new Table(mainPanel, typeof(Reserva)) => [
//			width = 2000
			height = 200
			numberVisibleRows = 3
			bindItemsToProperty("reservasEfectuadas")
			bindValueToProperty("reservaSeleccionada")
		]

		new Column<Reserva>(gridReceta) => [
			fixedSize = 150
			title = "Origen"
			bindContentsToProperty("vuelo.origen")
		]
		
		new Column<Reserva>(gridReceta) => [
			fixedSize = 150
			title = "Destino"
			bindContentsToProperty("vuelo.destino")
		]
		
		new Column<Reserva>(gridReceta) => [
			fixedSize = 120
			title = "Salida"
			bindContentsToProperty("vuelo.fechaSalida")
			]
			
		new Column<Reserva>(gridReceta) => [
			fixedSize = 120
			title = "Llegada"
			bindContentsToProperty("vuelo.fechaArribo")
			]
		
		new Column<Reserva>(gridReceta) => [
			fixedSize = 80
			title = "Tramos"
			bindContentsToProperty("escalas.size")
			]
			
		new Column<Reserva>(gridReceta) => [
			fixedSize = 120
			title = "Asiento Reservado"
			bindContentsToProperty("asiento")
			]	
//			new Column<Reserva>(gridReceta) => [
//			fixedSize = 150
//			title = "Salida"
//			bindContentsToProperty("salida")
//			bindBackground("acceso").transformer = [ Object recibe |
//				if ((recibe as RecetaAcceso).usuarioCarga.equals(modelObject.usuarioLogIn)) {
//					Color.GREEN
//				} else if (modelObject.usuarioLogIn.grupos.exists[u|
//					u.participantes.exists [ p |
//						p.nombre.toLowerCase.contains(
//							(recibe as RecetaAcceso).usuarioCarga.nombre.toLowerCase
//						)
//					]]) {
//					Color.BLUE
//				} else {
//					Color.LIGHT_GRAY
//				}
//			]
		

	}

	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)
		
		val subpanelTexto = new Panel(panelTexto)
		subpanelTexto.layout = new HorizontalLayout
		
		new Label(subpanelTexto)=>[
			text =  "Usuario : "
		]
		new Label(subpanelTexto).bindValueToProperty("usuarioLogin")
	}
	
}