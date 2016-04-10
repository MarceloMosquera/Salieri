package edu.unsam.Salieri.Domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Asiento {

	boolean disponible
	int fila
	int ubicacion
	List<String> ubicacionesPosibles= #["Pasillo", "Centro", "Ventana"]
	Tarifa tarifa
	Vuelo vuelo
	
	new(int laFila, int laUbicacion, Vuelo elVuelo){
		fila = laFila
		ubicacion = laUbicacion
		vuelo = elVuelo
		tarifa = new Tarifa(vuelo.tarifaDefault, vuelo)
		disponible = true
	}
	
	def void reservar() {
		if (disponible) {
			disponible = false
		} else {
			throw new BusinessException("El asiento ya se encuentra reservado.")
		}
	}

	def Boolean estaDisponible() {
		disponible
	}

    def float obtenerPrecio (){
		return tarifa.obtenerPrecio
	}

	def boolean estaEnFila(int laFila)
	{
		fila.equals(laFila)	
	}
	def boolean estaEnUbicacion(int laUbicacion)
	{
		ubicacion.equals(laUbicacion)
	}
	
	override toString(){
		(fila) + ubicacionesPosibles.get(ubicacion).substring(0,1)
	}

}
