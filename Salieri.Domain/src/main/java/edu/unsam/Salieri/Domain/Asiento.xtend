package edu.unsam.Salieri.Domain

class Asiento {

	Reserva reserva
	float costo

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
