package edu.unsam.Salieri.Domain

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Reserva {
	int id
	Date fecha
	Date fechaBaja
	List<Vuelo> escalas // TODO PASAR A VUELO
	Usuario usuario
	Asiento asiento
	Vuelo vuelo
	//new (Asiento unAsiento, Usuario unUsuario) {}
	
	
	//Resolver como se maneja el tema de las escalas y asientos.
	
	new (Asiento unAsiento,Usuario unUsuario, Vuelo unVuelo) {
		usuario = unUsuario
		asiento = unAsiento
		vuelo = unVuelo
		escalas = newArrayList			
	}

	
	def boolean reservaDelUsuario(Usuario unUsuario){
		usuario.equals(unUsuario)
	}
	
}