package edu.unsam.Salieri.Domain.Descuento

class DescuentoPorcentaje implements IDescuentoMonto {

	float porcentaje
	
	new(float unPorcentaje){
		porcentaje = unPorcentaje
	}
	
	override float obtenerPrecioConDescuento(float unPrecio) {
		return unPrecio * (1-porcentaje)
	}
	
}