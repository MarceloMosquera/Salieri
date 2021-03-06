package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Front.AppModel.ConsultaVuelosAppModel
import edu.unsam.Salieri.Front.AppModel.LogConsultasAppModel
import edu.unsam.Salieri.Front.AppModel.PrincipalAppModel
import edu.unsam.Salieri.Util.SSDate
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

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

	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)

		val subpanelTexto = new Panel(panelTexto)
		subpanelTexto.layout = new HorizontalLayout

		new Label(subpanelTexto) => [
			text = "Usuario : "
		]
		new Label(subpanelTexto).bindValueToProperty("usuarioLogueado")
	}
	

	def createGrillaReservasEfectuadas(Panel mainPanel) {
		new Label(mainPanel) => [
			text = "Reservas Efectuadas"
		]
		val gridReceta = new Table(mainPanel, typeof(Reserva)) => [
			height = 200
			numberVisibleRows = 6
			bindItemsToProperty("reservasEfectuadas")
			bindValueToProperty("reservaSeleccionada")
		]

		new Column<Reserva>(gridReceta) => [
			fixedSize = 150
			title = "Vuelo"
			bindContentsToProperty("vuelo.nroVuelo")
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
			bindContentsToProperty("vuelo.fechaSalida").transformer = [fecha|SSDate.toShow(fecha)]
		]

		new Column<Reserva>(gridReceta) => [
			fixedSize = 120
			title = "Llegada"
			bindContentsToProperty("vuelo.fechaArribo").transformer = [fecha|SSDate.toShow(fecha)]
		]

		new Column<Reserva>(gridReceta) => [
			fixedSize = 80
			title = "Tramos"
			bindContentsToProperty("vuelo.cantidadDeEscalas")
		]

		new Column<Reserva>(gridReceta) => [
			fixedSize = 120
			title = "Asiento Reservado"
			bindContentsToProperty("asiento")
		]
	}

	
	def createBotones(Panel panel) {
		val elementSelected = new NotNullObservable("reservaSeleccionada")

		var panelHorizonal1 = new Panel(panel).layout = new HorizontalLayout
		new Button(panelHorizonal1) => [
			caption = "Cancelar Reserva"
			width = 150
			onClick [|modelObject.cancelarReserva]
			background = Color.darkGray
			bindEnabled(elementSelected)
		]

		var panelHorizonal2 = new Panel(panel).layout = new HorizontalLayout

		new Label(panelHorizonal2) => [
			text = ""
			width = 30
		]

		new Button(panelHorizonal2) => [
			caption = "Busqueda de vuelos"
			width = 350
			onClick [|buscarVuelos]
			background = Color.BLUE
		]

		new Button(panelHorizonal2) => [
			caption = "Log de consultas hechas"
			width = 350
			onClick [|consultaLogs]
			setAsDefault
			background = Color.ORANGE
		]
	}

	def buscarVuelos() {
		this.openDialog(
			new ConsultaVuelosWindow(this, new ConsultaVuelosAppModel())
		)

	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.actualizarLista]
		dialog.open
	}

	def consultaLogs() {
		this.openDialog(
			new LogConsultasWindow(this, new LogConsultasAppModel())
		)
		
	}

	override close() {
		super.close()
		new LoginWindow(this).open
	}

}
