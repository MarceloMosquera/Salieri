package edu.unsam.Salieri.Domain

import org.uqbar.commons.utils.Observable
import java.util.List
import java.util.ArrayList
import javax.swing.text.Position.Bias

@Observable
class Asiento {

	//Reserva reserva
	boolean disponible
	float costo
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
		ubicacionesPosibles = newArrayList
		ubicacionesPosibles.add("Pasillo")
		ubicacionesPosibles.add("Centro")
		ubicacionesPosibles.add("Ventana")
	}
	
	def Reserva reservar(Vuelo unVuelo, Usuario unUsuario) {
		if (disponible) {
			disponible = false
			return new Reserva(this, unUsuario, unVuelo)
		} else {
			throw new BusinessException("El asiento ya se encuentra reservado.")
		}
	}

	def Boolean estaDisponible() {
		disponible
	}

	def boolean costoMenorA(float montoMax) {
		montoMax == 0 || (costo < montoMax)
	}
	
	override toString(){
		(fila +1) + ubicacionesPosibles.get(ubicacion).substring(0,1)
	}

}
