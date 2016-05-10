package edu.unsam.Salieri.Domain

import java.util.Date
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
class Escala {
	@Id
	@GeneratedValue
	private Long id
	@Column
	int orden
	@ManyToOne
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
