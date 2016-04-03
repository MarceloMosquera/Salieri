package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.Front.AppModel.DetalleVueloAppModel
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import edu.unsam.Salieri.Domain.Escala
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Button
import java.awt.Color
import edu.unsam.Salieri.Util.SSDate

class DetalleVueloWindow extends TransactionalDialog<DetalleVueloAppModel> {

	new(WindowOwner owner, DetalleVueloAppModel model) {
		super(owner, model)
		title = "Detalle del Vuelo " + modelObject.nombreVuelo()
	}

	override protected createFormPanel(Panel mainPanel) {
	}

	override def createMainTemplate(Panel mainPanel) {
		//title = "Que estas buscando?"

		val panel1 = new Panel(mainPanel).setLayout(new HorizontalLayout)
		val panel1A = new Panel(panel1).setLayout(new VerticalLayout)
		new Label(panel1A).text = "Partida"
		new Label(panel1A) => [
			bindValueToProperty("vueloSeleccionado.origen")
		]
		new Label(panel1A) => [
			bindValueToProperty("vueloSeleccionadoFechaSalida")
		]
		val panel1B = new Panel(panel1).setLayout(new VerticalLayout)		
		new Label(panel1B).text = "Llegada"
		new Label(panel1B) => [
			bindValueToProperty("vueloSeleccionado.destino")
		]
		new Label(panel1B) => [
			bindValueToProperty("vueloSeleccionadoFechaArribo")
		]
		val panel1C = new Panel(panel1).setLayout(new VerticalLayout)		
		new Label(panel1C).text = "Usuario"
		new Label(panel1C) => [
			bindValueToProperty("usuarioLogueado.nombre")
		]
		
		val panel2 = new Panel(mainPanel).setLayout(new HorizontalLayout)
		val panel2A = new Panel(panel2).setLayout(new VerticalLayout)		
		new Label(panel2A).text = "Tramos"
		new Label(panel2A) => [
			bindValueToProperty("vueloSeleccionado.origen")
		]
		new Label(panel2A) => [
			bindValueToProperty("vueloSeleccionadoFechaSalida")
		]

		val panel2B = new Panel(panel1).setLayout(new VerticalLayout)		
		new Label(panel2B).text = "Aerolínea"
		new Label(panel2B) => [
			bindValueToProperty("vueloSeleccionado.aerolinea")
		]
		
		
		//Metodo para crear grilla de tramos//
		var tablaTramos = new Table(panel2A, typeof(Escala))
		tablaTramos.height = 200
		tablaTramos.width = 500
		tablaTramos.numberVisibleRows = 3
		tablaTramos.bindItemsToProperty("vueloSeleccionado.escalas")
		new Column<Escala>(tablaTramos).setTitle("Destino intermedio").setFixedSize(150).
			bindContentsToProperty("aeropuerto")
		new Column<Escala>(tablaTramos).setTitle("Llegada").setFixedSize(150).
			bindContentsToProperty("fechaLlegada").transformer = [ fecha | SSDate.toShow(fecha)]
		//crear asientos
		(0 .. 9).forEach [ i |
			val filaPanel = new Panel(panel2B)
			filaPanel.layout = new HorizontalLayout
			modelObject.vueloSeleccionado.asientoDeFila(i).forEach [ asiento |
				new Button(filaPanel) => [
					if (asiento.disponible) {
						background = Color.GREEN
					} else {
						background = Color.RED
					}
					caption = asiento.toString
					onClick [ | modelObject.asientoSeleccionado = asiento ]
				]
			]
		]
		//Nos falla el doble binding
/*		new Label(panel2B) => [
			text = "Asiento seleccionado"
			foreground = Color.BLUE
		]
		if(modelObject.asientoSeleccionado==null){
			new Label(panel2B).text = "Seleccione asiento"
		}
		else{
		new Label(panel2B).text = modelObject.asientoSeleccionado.toString()
		} */
	}
		
		
//		super.createMainTemplate(mainPanel)
//		this.createGrillaRecetas(mainPanel)
//		this.creatGrillaAcciones(mainPanel)

		
}
	

