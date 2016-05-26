package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Front.AppModel.LogConsultasAppModel
import edu.unsam.Salieri.Front.AppModel.LogDetalleVuelosConsultasAppModel
import edu.unsam.Salieri.Util.SSDate
import org.apache.commons.collections15.Transformer
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
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

class LogConsultasWindow extends TransactionalDialog<LogConsultasAppModel> {
	
	new(WindowOwner owner, LogConsultasAppModel model) {
		super(owner, model)
		title = "Log Consultas realizadas"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		crearPanelBusqueda(mainPanel)
		createGrillaConsultasHechas(mainPanel)
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
	
	def crearPanelBusqueda(Panel panel) {
		var panelPrincipal = new Panel(panel).layout = new HorizontalLayout
		var panelBuscar = new Panel(panelPrincipal).layout = new HorizontalLayout
		var panelUsuario = new Panel(panelPrincipal).layout = new HorizontalLayout
		crearMiniPanelHorizontal("Fecha desde","fechaDesde",true,panelBuscar)
		crearMiniPanelHorizontal("Fecha hasta","fechaHasta",true,panelBuscar)
		crearMiniPanelHorizontal("Usuario","usuarioLogueado",false,panelUsuario)
	}
	
	
	def crearColumna(String titulo, String binder, Table grilla){
		new Column<Consulta>(grilla) => [
			fixedSize = 150
			title = titulo
			bindContentsToProperty(binder)
		]
	}

	def crearColumna(String titulo, String binder,Transformer transformer, Table grilla){
			new Column<Consulta>(grilla) => [
				fixedSize = 150
				title = titulo
				bindContentsToProperty(binder).transformer = transformer
			]
	}
	
	def createGrillaConsultasHechas(Panel mainPanel) {
		new Label(mainPanel) => [
			text = "Consultas hechas"
		]
		val grilla = new Table(mainPanel, typeof(Consulta)) => [
			height = 200
			numberVisibleRows = 6
			bindItemsToProperty("consultas")
			bindValueToProperty("consultaSeleccionada")
		]
		
		crearColumna("Fecha","fechaConsulta",[fecha|SSDate.toShow(fecha)],grilla)
		
		crearColumna("Criterio de busqueda","criterio",grilla)
		crearColumna("Vuelos","vuelosConsultados.size",grilla)
		
	}
	
	
	def createBotones(Panel panel) {
		val elementSelected = new NotNullObservable("consultaSeleccionada")

		var panelHorizonal1 = new Panel(panel).layout = new HorizontalLayout
		new Button(panelHorizonal1) => [
			caption = "Ver vuelos"
			width = 150
			onClick [|verVuelos]
			bindEnabled(elementSelected)
		]
	var panelHorizonal2 = new Panel(panel).layout = new HorizontalLayout
		new Button(panelHorizonal2) => [
			caption = "Buscar"
			width = 150
			onClick [|modelObject.buscar]
		]
	}
	

	def verVuelos() {
			new DetalleLogWindow(this, new LogDetalleVuelosConsultasAppModel(modelObject.consultaSeleccionada)).open
	}

}