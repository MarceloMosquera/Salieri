package edu.unsam.Salieri.Domain.Descuento

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DescuentoMonto implements IDescuentoMonto {
	
	float monto
	
	new(float unMonto){
		monto = unMonto
	}
	
	override float obtenerPrecioConDescuento(float unPrecio) {
		return unPrecio - monto
	}
}