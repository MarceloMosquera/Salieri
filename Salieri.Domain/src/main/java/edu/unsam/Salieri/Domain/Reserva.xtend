package edu.unsam.Salieri.Domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import java.util.List

@Accessors
class Reserva {
	int id
	Date fecha
	List<Vuelo> escalas
	
	new (Asiento unAsiento, Usuario unUsuario) {
		
	}
}