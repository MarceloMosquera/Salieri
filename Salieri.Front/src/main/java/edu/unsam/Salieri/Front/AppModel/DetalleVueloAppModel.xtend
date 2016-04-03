package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Util.SSDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class DetalleVueloAppModel extends BaseAppModel {
	Vuelo vueloSeleccionado
	Asiento asientoSeleccionado
	new (Vuelo elVueloSeleccionado){
		vueloSeleccionado = elVueloSeleccionado
	}
	
	def String nombreVuelo(){
		vueloSeleccionado.nroVuelo
	} 
	
	def void reservarAsiento(){
		vueloSeleccionado.reservarAsiento(asientoSeleccionado, usuarioLogueado)
	}
	
	def getVueloSeleccionadoFechaSalida() {
        return SSDate.toShow(vueloSeleccionado.fechaSalida);
    }
    
    def getVueloSeleccionadoFechaArribo() {
        return SSDate.toShow(vueloSeleccionado.fechaArribo);
    }
	
	
}