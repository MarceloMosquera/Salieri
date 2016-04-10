package edu.unsam.Salieri.Domain

import java.util.ArrayList
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Vuelo {
	String nroVuelo
	String aerolinea
	Aeropuerto origen
	Aeropuerto destino
	Date fechaSalida
	Date fechaArribo
	List<Asiento> asientos
	List<Escala> escalas
	float tarifaDefault

	new(
		String elNroVuelo,
		String laAerolinea,
		Aeropuerto elOrigen,
		Aeropuerto elDestino,
		Date laFechaSalida,
		Date laFechaArribo, 
		float laTarifa
	) {
		nroVuelo = elNroVuelo
		aerolinea = laAerolinea
		origen = elOrigen
		destino = elDestino
		fechaSalida = laFechaSalida
		fechaArribo = laFechaArribo
		tarifaDefault = laTarifa
		asientos = new ArrayList
		escalas = new ArrayList
		generarAsientos()

	}

	private def void generarAsientos() {
		var int i
		var int j
		asientos = new ArrayList
		for (i = 1; i <= 10; i++) {
			for (j = 0; j < 3; j++) {
				asientos.add(new Asiento(i,j, this))
			}
		}
	}

	def boolean vueloConLugar() {
		asientos.exists[asiento | asiento.estaDisponible]
	}

	
	
	def int cantidadAsientosLibres(){
		val libres = asientos.filter[asiento | asiento.estaDisponible].toList
		libres.size 
	}
	def int cantidadAsientosLibresPorMenosDe(float montoMax){
		val libres = asientos.filter[asiento | asiento.estaDisponible && (montoMax == 0 || asiento.obtenerPrecio() <= montoMax)].toList
		libres.size 
	}
	def int cantidadAsientosReservados(){
		asientos.size - cantidadAsientosLibres
	}

	def boolean saleEntre(Date fechaMin, Date fechaMax) {
		(fechaMin == null || fechaSalida.after(fechaMin)) 
		&& (fechaMax== null || fechaSalida.before(fechaMax))
	}

	def boolean porMenosDe(float montoMax) {
		montoMax == 0 ||
		asientos.exists[ asi | asi.obtenerPrecio() <= montoMax ]  
	}
	
	def boolean saleDe(Aeropuerto aerop) {
		aerop == null || aerop.equals(Aeropuerto.aeropuertoVacio) || origen.equals(aerop)
	}
	def boolean pasaPor(Aeropuerto aerop) {
		aerop == null || aerop.equals(Aeropuerto.aeropuertoVacio) || destino.equals(aerop)
		|| escalas.exists[escala | escala.enAeropuerto(aerop)  ]
	}

	def List<Asiento> getAsientosDisponibles() {
		asientos.filter[asiento|asiento.estaDisponible].toList
	}

	def agregarEscala(Escala unaEscala){
		escalas.add(unaEscala)
		unaEscala.orden = escalas.size
	}
	
	def cantidadDeEscalas()
	{
		escalas.size
	}
	def cantidadDeEscalasEntre(Aeropuerto unAeropuerto, Aeropuerto otroAeropuerto)
	{
		var ordenDestino = escalas.findFirst[esc|esc.enAeropuerto(otroAeropuerto)].orden
		var ordenOrigen = escalas.findFirst[esc|esc.enAeropuerto(unAeropuerto)].orden 
		ordenDestino - ordenOrigen
	}
	
	def int maxAsientos(){
		asientos.size
	}
   def  obtenerAsientosDeFila(int fila){
    	asientos.filter[asiento|asiento.estaEnFila(fila)]
    }

	def obtenerAsiento(int fila, int ubicacion){
    	asientos.findFirst[asiento|asiento.estaEnFila(fila) && asiento.estaEnUbicacion(ubicacion)]
    }    

}
