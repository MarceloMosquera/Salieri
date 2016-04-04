package edu.unsam.Salieri.Domain.Descuento

import edu.unsam.Salieri.Domain.Vuelo

class DescuentoReglaSiempre implements IDescuentoRegla {

	override boolean seDebeAplicar(Vuelo vuelo){
		true
	}
		
}