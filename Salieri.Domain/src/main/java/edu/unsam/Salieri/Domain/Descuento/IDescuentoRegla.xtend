package edu.unsam.Salieri.Domain.Descuento

import edu.unsam.Salieri.Domain.Vuelo

interface IDescuentoRegla {

	def boolean seDebeAplicar(Vuelo vuelo)
	
}