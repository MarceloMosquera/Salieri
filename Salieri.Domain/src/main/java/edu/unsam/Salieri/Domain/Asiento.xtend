package edu.unsam.Salieri.Domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Asiento {

	//Reserva reserva
	boolean disponible
	int fila
	int ubicacion
	List<String> ubicacionesPosibles
	//evaluar si pasar a un booleano, doble referencia, o referencia simple//
	
	new(int laFila, int laUbicacion){
		fila = laFila
		ubicacion = laUbicacion
		disponible = true
		iniciarUbicaciones
	}
	
	def iniciarUbicaciones() {
		ubicacionesPosibles = #["Pasillo", "Centro", "Ventana"]
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
