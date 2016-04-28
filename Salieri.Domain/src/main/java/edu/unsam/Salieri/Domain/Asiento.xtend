package edu.unsam.Salieri.Domain

import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
class Asiento {
	@Id
	@GeneratedValue
	private Long id
	@Column
	boolean disponible
	@Column
	int fila
	@Column
	int ubicacion
	
	transient static List<String> ubicacionesPosibles= #["Pasillo", "Centro", "Ventana"]
	
	@ManyToOne
	Tarifa tarifa
	
	@ManyToOne
	Vuelo vuelo
	
	new(){}
	
	new(int laFila, int laUbicacion, Vuelo elVuelo){
		fila = laFila
		ubicacion = laUbicacion
		vuelo = elVuelo
		tarifa = new Tarifa(vuelo.tarifaDefault)
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
		return tarifa.obtenerPrecio(vuelo)
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
