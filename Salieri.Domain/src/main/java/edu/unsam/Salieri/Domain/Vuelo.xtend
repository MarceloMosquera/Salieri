package edu.unsam.Salieri.Domain

import java.util.ArrayList
import java.util.Date
import java.util.List

class Vuelo {
	//Int id
	String nroVuelo
	Aerolinea aerolinea
	Aeropuerto origen
	Aeropuerto destino
	Date fechaSalida
	Date fechaArribo
	List<Asiento> asientos
	
	new(String elNroVuelo,Aerolinea laAerolinea,
		Aeropuerto elOrigen,Aeropuerto elDestino,
		Date laFechaSalida,Date laFechaArribo
	){
		nroVuelo = elNroVuelo
		aerolinea=laAerolinea
		origen=elOrigen
		destino=elDestino
		fechaSalida=laFechaSalida
		fechaArribo=laFechaArribo
		asientos = new ArrayList
		asientos = generarAsientos()
		
	}
	
	def List<Asiento> generarAsientos() {
		// genera el array de asientos (hay que ver como hacemos con el enum)
	}
	
	def boolean vueloConLugar(){
		true //temporal, super hardcodeado
	}
	
	def void reservarAsiento (Asiento unAsiento){
		
	}
	
	def boolean saleEntre(Date fechaMin, Date fechaMax) {
		fechaSalida.after(fechaMin) && fechaSalida.before(fechaMax)
	}
	
	def boolean asientoPorMenosDe(float montoMax) {
		
		asientosDisponibles.exists[asiento|asiento.costoMenorA(montoMax)]
		
	}
	
	def List<Asiento> getAsientosDisponibles() {
		asientos.filter[asiento|asiento.asientoDisponible].toList
	}

	
}