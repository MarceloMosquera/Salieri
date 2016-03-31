package edu.unsam.Salieri.Domain

class Asiento {

	Reserva reserva
	float costo
	int fila
	int ubicacion
	//evaluar si pasar a un booleano, doble referencia, o referencia simple//
	
	new(int laFila, int laUbicacion){
		fila = laFila
		ubicacion = laUbicacion
	}
	
	def void reservar(Usuario unUsuario) {
		if (asientoDisponible) {
			reserva = new Reserva(this, unUsuario)
		} else {
			throw new BusinessException("El asiento ya se encuentra reservado.")
		}
	}

	def Boolean asientoDisponible() {
		reserva == null
	}

	def boolean costoMenorA(float montoMax) {
		costo < montoMax
	}

}
