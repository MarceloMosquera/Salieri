package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Front.AppModel.LogDetalleVuelosConsultasAppModel
import edu.unsam.Salieri.Util.SSDate
import org.apache.commons.collections15.Transformer
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.unsam.Salieri.Domain.VueloConsulta

class DetalleLogWindow extends TransactionalDialog<LogDetalleVuelosConsultasAppModel> {

	new(WindowOwner owner, LogDetalleVuelosConsultasAppModel model) {
		super(owner, model)
		title = "Vuelos Consultados"
	}

	
	override protected createFormPanel(Panel mainPanel) {
		createPanelHeader(mainPanel)
		createGrillaVuelosEncontrados(mainPanel)
		createBotones(mainPanel)
	}
	
	
	def crearMiniPanelHorizontal(String label, String binder,Boolean editable, Panel panel) {
		var panelPrincipal = new Panel(panel).layout = new VerticalLayout
		new Label(panelPrincipal).text = label
		if(editable){
			
		new TextBox(panelPrincipal) => [
			width = 150
			value <=> binder
		]
		}else{
			new Label(panelPrincipal).bindValueToProperty = binder
		}
	}
	
	def crearColumna(String titulo, String binder, Table grilla){
		new Column<VueloConsulta>(grilla) => [
			fixedSize = 150
			title = titulo
			bindContentsToProperty(binder)
		]
	}
	
	//caso de necesitar transformer
	def crearColumna(String titulo, String binder,Transformer transformer, Table grilla){
			new Column<VueloConsulta>(grilla) => [
				fixedSize = 150
				title = titulo
				bindContentsToProperty(binder).transformer = transformer
			]
	}
	
	
	def createPanelHeader(Panel panel) {
		var panelPrincipal = new Panel(panel).layout = new HorizontalLayout
		crearMiniPanelHorizontal("Horario de la consulta","consultaSeleccionada.fechaConsultaMejorada",false,panelPrincipal)
		crearMiniPanelHorizontal("Criterio","consultaSeleccionada.criterio",false,panelPrincipal)
	}


	

	def createGrillaVuelosEncontrados(Panel mainPanel) {
		var panelVertical1 = new Panel(mainPanel).layout = new VerticalLayout
		
		new Label(panelVertical1 ) => [
			text = "Vuelos"
		]
		val gridVuelos = new Table(panelVertical1 , typeof(VueloConsulta)) => [
			height = 200
			numberVisibleRows = 6
			bindItemsToProperty("consultaSeleccionada.vuelosConsultados")
		]
		
		crearColumna("Nombre","nroVuelo",gridVuelos)
		crearColumna("Origen","origen",gridVuelos)
		crearColumna("Destino","destino",gridVuelos)
		
		crearColumna("Salida","fechaSalida",[fecha|SSDate.toShow(fecha)],gridVuelos)
		crearColumna("Llegada","fechaArribo",[fecha|SSDate.toShow(fecha)],gridVuelos)
		
		crearColumna("Tramos","escalas",gridVuelos)
		crearColumna("Asientos Libres","asientos",gridVuelos)
	}
		
	def createBotones(Panel panel) {
		var panelVertical1 = new Panel(panel).layout = new VerticalLayout

		new Button(panelVertical1) => [
			caption = "Volver"
			width = 150
			onClick [|
				cancel
			]
		]

	}

}
