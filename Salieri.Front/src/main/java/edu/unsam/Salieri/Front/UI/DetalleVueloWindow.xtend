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
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.windows.Dialog

class DetalleVueloWindow extends TransactionalDialog<DetalleVueloAppModel> {

	new(WindowOwner owner, DetalleVueloAppModel model) {
		super(owner, model)
		title = "Detalle del Vuelo " + modelObject.nombreVuelo()
	}

	override protected createFormPanel(Panel mainPanel) {
	}

	override def createMainTemplate(Panel mainPanel) {

		val panel0 = new Panel(mainPanel).setLayout(new HorizontalLayout)
		val panelColunmaIzquierda = new Panel(panel0).setLayout(new VerticalLayout)

		// Panel1 = Origen , Destino , FechaSalida , FechaArribo , Usuario
		val panelIzquierdoLinea1 = new Panel(panelColunmaIzquierda).setLayout(new HorizontalLayout)
		val panel1A = new Panel(panelIzquierdoLinea1).setLayout(new VerticalLayout)
		new Label(panel1A).text = "Partida"
		new Label(panel1A) => [
			bindValueToProperty("vueloSeleccionado.origen")
		]
		new Label(panel1A) => [
			bindValueToProperty("vueloSeleccionadoFechaSalida")
		]
		val panel1B = new Panel(panelIzquierdoLinea1).setLayout(new VerticalLayout)
		new Label(panel1B).text = "Llegada"
		new Label(panel1B) => [
			bindValueToProperty("vueloSeleccionado.destino")
		]
		new Label(panel1B) => [
			bindValueToProperty("vueloSeleccionadoFechaArribo")
		]
		val panel1C = new Panel(panelIzquierdoLinea1).setLayout(new VerticalLayout)
		new Label(panel1C).text = "Usuario"
		new Label(panel1C) => [
			bindValueToProperty("usuarioLogueado.nombre")
		]

		// Panel2 = Tramos , Aerolinea
		val panelIzquierdoLinea2 = new Panel(panelColunmaIzquierda).setLayout(new HorizontalLayout)
//		val panel2A = new Panel(panelIzquierdoLinea2).setLayout(new VerticalLayout)
//		new Label(panel2A).text = "Tramos"
//		new Label(panel2A) => [
//			bindValueToProperty("vueloSeleccionado.origen")
//		]
//		new Label(panel2A) => [
//			bindValueToProperty("vueloSeleccionadoFechaSalida")
//		]
		// Metodo para crear grilla de tramos//
		val panel2A = new Panel(panelIzquierdoLinea2).setLayout(new VerticalLayout)
		var tablaTramos = new Table(panel2A, typeof(Escala))
		tablaTramos.height = 200
		tablaTramos.width = 500
		tablaTramos.numberVisibleRows = 5
		tablaTramos.bindItemsToProperty("vueloSeleccionado.escalas")
		new Column<Escala>(tablaTramos).setTitle("Destino intermedio").setFixedSize(175).
			bindContentsToProperty("aeropuerto")
		new Column<Escala>(tablaTramos).setTitle("Llegada").setFixedSize(175).
			bindContentsToProperty("fechaLlegada").transformer = [fecha|SSDate.toShow(fecha)]

		val panel2B = new Panel(panelIzquierdoLinea2).setLayout(new VerticalLayout)
		new Label(panel2B).text = "Aerolínea"
		new Label(panel2B) => [
			bindValueToProperty("vueloSeleccionado.aerolinea")
		]

		// crear asientos
		val panelColunmaDerecha = new Panel(panel0).setLayout(new VerticalLayout)
		val panelAsientos = new Panel(panelColunmaDerecha).setLayout(new VerticalLayout)
		(0 .. 9).forEach [ i |
			val filaPanel = new Panel(panelAsientos)
			filaPanel.layout = new HorizontalLayout
			modelObject.vueloSeleccionado.asientoDeFila(i).forEach [ asiento |
//				val asientoDiponible = new NotNullObservable("this.disponible")
				new Button(filaPanel) => [
					if (asiento.disponible) {
						background = Color.GREEN
					} else {
						background = Color.RED
						bindEnabledToProperty("asientoFalso")
					}
					caption = asiento.toString
					onClick [|modelObject.asientoSeleccionado = asiento]
				]
				
			]
		]
		// Nos falla el doble binding
		val panelIzquierdoLinea3 = new Panel(panelColunmaIzquierda).setLayout(new HorizontalLayout)
		
		val panel3A = new Panel(panelIzquierdoLinea3).setLayout(new VerticalLayout)
		new Label(panel3A) => [
			text = "Asiento seleccionado: "
			
		]
			new Label(panel3A)=>[
				bindValueToProperty("hayAsientoSeleccionado")
			]

		val panel3B = new Panel(panelIzquierdoLinea3).setLayout(new VerticalLayout)
		new Label(panel3B) => [
			text = "Monto a pagar: "
		]
		if (modelObject.asientoSeleccionado == null) {
			new Label(panel3B).text = "$ __"
		} else {
			//new Label(panel3B).text = "$ "+"Falla el p... binding"
			new Label(panel3B).text = modelObject.asientoSeleccionado.toString()
		}
		
		val elementSelected = new NotNullObservable("asientoSeleccionado")
		val panelIzquierdoLinea4 = new Panel(panelColunmaIzquierda).setLayout(new HorizontalLayout)
		new Button(panelIzquierdoLinea4) => [
			//width = 150
			caption = "Reservar"
			onClick [ | modelObject.reservarAsiento()
				accept
			]
			
			bindEnabled(elementSelected)
			
			
		]
		
		
		
	}
	
	
	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|]
		dialog.open
	}

//		super.createMainTemplate(mainPanel)
//		this.createGrillaRecetas(mainPanel)
//		this.creatGrillaAcciones(mainPanel)
}
