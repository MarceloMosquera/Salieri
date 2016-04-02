package edu.unsam.Salieri.Domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Escala {
	int orden
	Aeropuerto aeropuerto
	Date fechaSalida
	Date fechaLlegada
	
	new(Aeropuerto unAeropuerto, Date unaFechaSalida, Date unaFechaLlegada){
		aeropuerto = unAeropuerto
		fechaSalida = unaFechaSalida
		fechaLlegada = unaFechaLlegada
	}
	
	def boolean enAeropuerto(Aeropuerto unAeropuerto){
		aeropuerto.equals(unAeropuerto)
	}
	
}