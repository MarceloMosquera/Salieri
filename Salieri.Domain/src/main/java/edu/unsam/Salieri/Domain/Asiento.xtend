package edu.unsam.Salieri.Domain

class Asiento {

	//Reserva reserva
	boolean disponible
	float costo
	int fila
	int ubicacion
	//evaluar si pasar a un booleano, doble referencia, o referencia simple//
	
	new(int laFila, int laUbicacion){
		fila = laFila
		ubicacion = laUbicacion
		disponible = true
	}
	
	def void reservar(Vuelo unVuelo, Usuario unUsuario) {
		if (disponible) {
			new Reserva(this, unUsuario, unVuelo)
			disponible = false
		} else {
			throw new BusinessException("El asiento ya se encuentra reservado.")
		}
	}

	def Boolean estaDisponible() {
		disponible
	}

	def boolean costoMenorA(float montoMax) {
		costo < montoMax
	}

}
