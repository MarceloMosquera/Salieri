package edu.unsam.Salieri.Domain.Descuento

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Descuento {
	IDescuentoRegla regla
	IDescuentoMonto monto
	
	new(IDescuentoRegla unaRegla, IDescuentoMonto unMonto){
		regla = unaRegla
		monto = unMonto
	}
}