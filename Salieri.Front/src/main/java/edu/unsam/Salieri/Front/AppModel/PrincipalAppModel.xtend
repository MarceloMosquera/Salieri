package edu.unsam.Salieri.Front.AppModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Reserva
import java.util.List
import edu.unsam.Salieri.Domain.Asiento
import java.util.Date
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.Aeropuerto

@Accessors
@Observable
class PrincipalAppModel extends BaseAppModel{

	Usuario usuarioLogin
	List<Reserva> reservasEfectuadas
	Reserva reservaSeleccionada = null
	
	new() {
		//esto se debe reemplazar por el repo de reservas
		//con las reservas relacionadas con el usuario logueado
		
		var Reserva reserva1
		var Usuario usuarioLogueado
		var Asiento asientoReservado = new Asiento(1,2)//"centro")
		usuarioLogueado = new Usuario("Adrian")
		var Vuelo vuelo
		var Aeropuerto aeropuertoOrigen
		aeropuertoOrigen = new Aeropuerto("Buenos Aires1","Buenos Aires","Argentina")
		
		var Aeropuerto aeropuertoDestino
		aeropuertoDestino = new Aeropuerto("Buenos Aires2","Mar del Plata","Argentina")
		
		vuelo = new Vuelo("1","austral",aeropuertoOrigen, aeropuertoDestino,new Date(), new Date())
		vuelo.reservarAsiento(asientoReservado,usuarioLogueado)
		reserva1 = new Reserva(asientoReservado,usuarioLogueado,vuelo)
		
		reservasEfectuadas = newArrayList
		reservasEfectuadas.add(reserva1)
		usuarioLogin = usuarioLogueado
		
		var Reserva reserva2
		var Asiento asientoReservado2 = new Asiento(5,3)
		usuarioLogueado = new Usuario("Adrian")
		var Vuelo vuelo2
		var Aeropuerto aeropuertoOrigen2
		aeropuertoOrigen2 = new Aeropuerto("Buenos Aires3","Buenos Aires","Argentina")
		
		var Aeropuerto aeropuertoDestino2
		aeropuertoDestino2 = new Aeropuerto("Buenos Aires4","Bariloche","Argentina")
		
		vuelo2 = new Vuelo("1","Aerolieas Argentinas",aeropuertoOrigen2, aeropuertoDestino2,new Date(), new Date())
		vuelo2.reservarAsiento(asientoReservado2,usuarioLogueado)
		reserva2 = new Reserva(asientoReservado2,usuarioLogueado,vuelo2)
		
		reservasEfectuadas.add(reserva2)
	}
	
}
