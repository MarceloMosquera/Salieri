package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Util.SSDate
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Reserva {
	int id
	Date fecha
	Date fechaBaja
	Usuario usuario
	Asiento asiento
	Vuelo vuelo

	def void cancelar() {
		asiento.setDisponible(true)
		fechaBaja = new Date()
	}

	new(Asiento unAsiento, Usuario unUsuario, Vuelo unVuelo) {
		usuario = unUsuario
		asiento = unAsiento
		vuelo = unVuelo
		fecha = new Date()
		fechaBaja = null
		asiento.reservar()
	}

	def boolean reservaDelUsuario(Usuario unUsuario) {
		(!asiento.disponible) && (!estaDadoDeBaja) && usuario.equals(unUsuario)
	}
	
	def boolean estaDadoDeBaja(){
		(fechaBaja != null)
	}
	
	

}
