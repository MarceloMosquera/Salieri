package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Front.AppModel.ConsultaVuelosAppModel
import edu.unsam.Salieri.Front.AppModel.DetalleVueloAppModel
import edu.unsam.Salieri.Util.SSDate
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ConsultaVuelosWindow extends SimpleWindow<ConsultaVuelosAppModel> {
	
	new(WindowOwner parent) {
		super(parent, new ConsultaVuelosAppModel)
		title = "Consulta de Vuelos"
	}
	
	override protected addActions(Panel actionsPanel) {
		val panel = new Panel(actionsPanel).layout = new HorizontalLayout

		this.createGrillaVuelosEncontrados(panel)
		this.createBotones(panel)
	}
	
	
	def createBotones(Panel panel) {
		val elementSelected = new NotNullObservable("vueloSeleccionado")
		
		var panelHorizonal1 = new Panel(panel).layout = new HorizontalLayout
		new Button(panelHorizonal1) => [
			caption = "Reservar"
			width = 150
			onClick [|
//				modelObject.guardarConsulta(vueloSeleccionado)
				this.openDialog(
					new DetalleVueloWindow(
						this,
						new DetalleVueloAppModel(modelObject.vueloSeleccionado)
					))
			]
			bindEnabled(elementSelected)
		]
		
	}
	
		
	def createGrillaVuelosEncontrados(Panel mainPanel) {
		new Label(mainPanel)=>[
			text =  "Vuelos"
		]
		val gridVuelos = new Table(mainPanel, typeof(Vuelo)) => [
			height = 200
			numberVisibleRows = 6
			bindItemsToProperty("vuelosEncontrados")
			bindValueToProperty("vueloSeleccionado")
		]

		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 150
			title = "Origen"
			bindContentsToProperty("origen")
		]
		
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 150
			title = "Destino"
			bindContentsToProperty("destino")
		]
		
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 120
			title = "Salida"
			bindContentsToProperty("fechaSalida").transformer = [ fecha | SSDate.toShow(fecha)]
			]
			
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 120
			title = "Llegada"
			bindContentsToProperty("fechaArribo").transformer = [ fecha | SSDate.toShow(fecha)]
			]
			
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 120
			title = "Precio"
			bindContentsToProperty("obtenerPrecio")
			]
			
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 80
			title = "Tramos"
			bindContentsToProperty("cantidadDeEscalas")
			]
			
		new Column<Vuelo>(gridVuelos) => [
			fixedSize = 120
			title = "Asientos Libres"
			bindContentsToProperty("cantidadAsientosLibres")
			]	
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)
		panelTexto.layout = new HorizontalLayout 

		val searchFormPanel = new Panel(panelTexto)
		searchFormPanel.layout = new ColumnLayout(2)//new HorizontalLayout 
		
		new Label(searchFormPanel).text="Origen"
		new Selector<String>(searchFormPanel) => [
			allowNull = true
			bindValueToProperty = "vueloBusqueda.origen"
			bindItems(new ObservableProperty("aeropuertosOrigen"))
		]

		new Label(searchFormPanel).text="Destino"
		new Selector<String>(searchFormPanel) => [
			allowNull = true
			bindValueToProperty = "vueloBusqueda.destino"
			bindItems(new ObservableProperty("aeropuertosDestino"))
		]

		new Label(searchFormPanel).text="Fecha Desde"
		new TextBox(searchFormPanel) =>[
			width = 150
			value <=> "vueloBusqueda.fechaMin"
			]	
		
		new Label(searchFormPanel).text="Fecha Hasta"
		new TextBox(searchFormPanel) =>[
			width = 150
			value <=> "vueloBusqueda.fechaMax"
			//transformer = new DateAdapter
			]	

		new Label(searchFormPanel).text="$ maximo"
		new TextBox(searchFormPanel) =>[
			width = 150
			value <=> "vueloBusqueda.montoMax"
			]

		new Button(searchFormPanel) => [
			caption = "Buscar"
			width = 150
			onClick [ | modelObject.buscar ]
			background = Color.darkGray
		]

	}
	
		def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|]
		dialog.open
	}

	
}