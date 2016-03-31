package edu.unsam.Salieri.Domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Reserva {
	int id
	Date fecha
	Date fechaBaja
	//List<Vuelo> escalas
	Usuario usuario
	Asiento asiento
	Vuelo vuelo
	//new (Asiento unAsiento, Usuario unUsuario) {}
	
	
	//Resolver como se maneja el tema de las escalas y asientos.
	
	new (Asiento unAsiento,Usuario unUsuario, Vuelo unVuelo) {
		usuario = unUsuario
		asiento = unAsiento
		vuelo = unVuelo		
	}

	
	def boolean reservaDelUsuario(Usuario unUsuario){
		usuario.equals(unUsuario)
	}
	
}