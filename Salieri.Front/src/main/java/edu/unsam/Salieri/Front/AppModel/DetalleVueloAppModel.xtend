package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class DetalleVueloAppModel extends BaseAppModel {
	Vuelo vueloSeleccionado
	Asiento asientoSeleccionado
	Usuario usuarioLogueado
	new (Vuelo elVueloSeleccionado){
		vueloSeleccionado = elVueloSeleccionado
		usuarioLogueado = super.usuarioLogeado()
	}
	
	def String nombreVuelo(){
		vueloSeleccionado.nroVuelo
	} 
	
	def void reservarAsiento(){
		vueloSeleccionado.reservarAsiento(asientoSeleccionado,usuarioLogueado)
	}
	
	
}