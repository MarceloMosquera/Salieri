package edu.unsam.Salieri.Domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Asiento {

	boolean disponible
	int fila
	int ubicacion
	List<String> ubicacionesPosibles= #["Pasillo", "Centro", "Ventana"]
	
	new(int laFila, int laUbicacion){
		fila = laFila
		ubicacion = laUbicacion
		disponible = true
	}
	
	def void reservar() {
		if (disponible) {
			disponible = false
		} else {
			throw new BusinessException("El asiento ya se encuentra reservado.")
		}
	}

	def Boolean estaDisponible() {
		disponible
	}

	
	override toString(){
		(fila +1) + ubicacionesPosibles.get(ubicacion).substring(0,1)
	}

}
