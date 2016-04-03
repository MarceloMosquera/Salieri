package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Util.SSDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Reserva {
	int id
	SSDate fecha
	SSDate fechaBaja
//	List<Vuelo> escalas // TODO PASAR A VUELO
	Usuario usuario
	Asiento asiento
	Vuelo vuelo

	def void cancelar() {
		asiento.setDisponible(true)
		fechaBaja = new SSDate()

	}

	new(Asiento unAsiento, Usuario unUsuario, Vuelo unVuelo) {
		usuario = unUsuario
		asiento = unAsiento
		vuelo = unVuelo
		fecha = new SSDate()
//		escalas = newArrayList			
	}

	def boolean reservaDelUsuario(Usuario unUsuario) {
		if (!asiento.disponible) {
			usuario.equals(unUsuario)
		} else {
			false
		}
	}

}
