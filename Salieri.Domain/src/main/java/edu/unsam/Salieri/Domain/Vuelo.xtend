package edu.unsam.Salieri.Domain

import java.util.ArrayList
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.text.DateFormat;
import java.text.SimpleDateFormat
import edu.unsam.Salieri.Util.SSDate

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

	new(
		String elNroVuelo,
		String laAerolinea,
		Aeropuerto elOrigen,
		Aeropuerto elDestino,
		Date laFechaSalida,
		Date laFechaArribo
	) {
		nroVuelo = elNroVuelo
		aerolinea = laAerolinea
		origen = elOrigen
		destino = elDestino
		fechaSalida = laFechaSalida
		fechaArribo = laFechaArribo
		asientos = new ArrayList
		escalas = new ArrayList
		generarAsientos()

	}

	def void generarAsientos() {
		var int i
		var int j
		asientos = new ArrayList
		for (i = 0; i < 10; i++) {
			for (j = 0; j < 3; j++) {
				asientos.add(new Asiento(i, j))
			}
		}
	}

	def boolean vueloConLugar() {
		true // TODO: para revisar
	}

	def Reserva reservarAsiento(Asiento unAsiento, Usuario unUsuario) {
		unAsiento.reservar(this, unUsuario)
	}
	
	def int cantidadAsientosLibres(){
		val libres = asientos.filter[asiento | asiento.estaDisponible].toList
		libres.size 
	}
	def int cantidadAsientosReservados(){
		asientos.size - cantidadAsientosLibres
	}

	def boolean saleEntre(Date fechaMin, Date fechaMax) {
		(fechaMin == null || fechaSalida.after(fechaMin)) 
		&& (fechaMax== null || fechaSalida.before(fechaMax))
	}

	def boolean asientoPorMenosDe(float montoMax) {
		asientosDisponibles.exists[asiento|asiento.costoMenorA(montoMax)]
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
    def getFechaSalida() {
        return SSDate.toShow(fechaSalida);
    }
    
    def getFechaArribo() {
        return SSDate.toShow(fechaArribo);
    }
   def  asientoDeFila(int i){
    	asientos.filter[asiento|asiento.fila.equals(i)]
    }

}
