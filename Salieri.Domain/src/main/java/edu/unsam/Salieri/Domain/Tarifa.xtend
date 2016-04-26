package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Domain.Descuento.Descuento
import java.util.ArrayList
import java.util.List
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Tarifa {
	@Id
	@GeneratedValue
	private Long id

	@Column
	float precio
	
	@ManyToOne()
	Vuelo vuelo
	
	
	List<Descuento> descuentos = new ArrayList
	
	new(){}
	
	new (float unPrecio, Vuelo unVuelo) {
		precio = unPrecio
		vuelo = unVuelo
	}
	
	def float obtenerPrecio (){
		descuentos.fold ( precio, [ acum, desc |
			if (desc.regla.seDebeAplicar(vuelo)) {
				desc.monto.obtenerPrecioConDescuento(acum)
			} else {
				acum
			}
		] )
	}
	def agregarDescuento(Descuento unDescuento) {
		descuentos.add(unDescuento)		
	}

}