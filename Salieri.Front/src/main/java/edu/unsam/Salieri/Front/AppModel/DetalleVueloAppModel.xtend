package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Util.SSDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.unsam.Salieri.Domain.Reserva
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class DetalleVueloAppModel extends BaseAppModel {
	Vuelo vueloSeleccionado
	float montoMax
	Asiento asientoSeleccionado
	new (Vuelo elVueloSeleccionado, float elMontoMax){
		vueloSeleccionado = elVueloSeleccionado
		montoMax = elMontoMax
	}
	
	def String nombreVuelo(){
		vueloSeleccionado.nroVuelo
	} 
	
	def void reservarAsiento(){
		this.DBContext().repoReservas().agregarReserva(new Reserva( asientoSeleccionado, usuarioLogueado, vueloSeleccionado))
	}
	
	def getVueloSeleccionadoFechaSalida() {
        return SSDate.toShow(vueloSeleccionado.fechaSalida);
    }
    
    def getVueloSeleccionadoFechaArribo() {
        return SSDate.toShow(vueloSeleccionado.fechaArribo);
    }
    
    def Boolean asientoFalso(){
    	false
    }
    
    def String montoAPagar(){
    	if(asientoSeleccionado == null)
    	{
    		""
    	}else{
    		"$ " + asientoSeleccionado.obtenerPrecio().toString
    	}
    }
    
    def getAsientoSeleccionado(){
    	ObservableUtils.firePropertyChanged(this, "montoAPagar", montoAPagar()) 
    	asientoSeleccionado
    }


}