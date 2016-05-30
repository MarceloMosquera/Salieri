package edu.unsam.Salieri.Domain

import java.util.Date
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

@Accessors
@Entity
@Observable
class VueloConsulta {
	@Id ObjectId id

	String nroVuelo

	String aerolinea

	Aeropuerto origen

	Aeropuerto destino

	Date fechaSalida

	Date fechaArribo

	int asientos

	int escalas

	float tarifaDefault

	new(Vuelo vuelo) {
		nroVuelo = vuelo.nroVuelo
		aerolinea = vuelo.aerolinea
		origen = vuelo.origen
		destino = vuelo.destino
		fechaSalida = vuelo.fechaSalida
		fechaArribo = vuelo.fechaArribo
		asientos = vuelo.cantidadAsientosLibres
		escalas = vuelo.cantidadDeEscalas
		tarifaDefault = vuelo.tarifaDefault
	}

	new() {
	}

}
