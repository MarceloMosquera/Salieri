package edu.unsam.Salieri.Domain

import java.util.Date
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Escala {
	@Id
	@GeneratedValue
	private Long id
	@Column
	int orden
	@OneToMany()
	Aeropuerto aeropuerto
	@Column
	Date fechaSalida
	@Column
	Date fechaLlegada
	
	new(){}

	new(Aeropuerto unAeropuerto, Date unaFechaSalida, Date unaFechaLlegada) {
		aeropuerto = unAeropuerto
		fechaSalida = unaFechaSalida
		fechaLlegada = unaFechaLlegada
	}

	def boolean enAeropuerto(Aeropuerto unAeropuerto) {
		aeropuerto.equals(unAeropuerto)
	}

}
