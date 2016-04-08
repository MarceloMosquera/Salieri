package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Domain.Descuento.Descuento
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Tarifa {
	
	float precio
	Vuelo vuelo
	List<Descuento> descuentos = new ArrayList
	
	new (float unPrecio, Vuelo unVuelo) {
		precio = unPrecio
		vuelo = unVuelo
	}
	
	def float obtenerPrecio (){
		var seed = precio
		descuentos.fold ( seed, [ acum, desc |
			if (desc.regla.seDebeAplicar(vuelo)) {
				desc.monto.obtenerPrecioConDescuento(acum)
			} else {
				acum
			}
		] )
		return seed
	}
	def agregarDescuento(Descuento unDescuento) {
		descuentos.add(unDescuento)		
	}

}