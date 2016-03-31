package edu.unsam.Salieri.Domain

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Reserva {
	int id
	Date fecha
	Date fechaBaja
	List<Vuelo> escalas
	Usuario usuario
	Asiento asiento
	//new (Asiento unAsiento, Usuario unUsuario) {}
	
	new (Asiento unAsiento,Usuario unUsuario) {
		usuario = unUsuario
		asiento = unAsiento
				
	}

	
	def boolean reservaDelUsuario(Usuario unUsuario){
		usuario.equals(unUsuario)
	}
	
}