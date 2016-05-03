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

@Accessors
@Observable
@Entity
class Reserva {
	@Id
	@GeneratedValue
	public Long id
	
	@Column
	Date fecha

	@Column
	Date fechaBaja

	@ManyToOne
	Usuario usuario

	@ManyToOne
	Asiento asiento

	@ManyToOne
	Vuelo vuelo

	def void cancelar() {
		asiento.setDisponible(true)
		fechaBaja = new Date()
	}
	
	new(){}
	
	new(Asiento unAsiento, Usuario unUsuario, Vuelo unVuelo) {
		usuario = unUsuario
		asiento = unAsiento
		vuelo = unVuelo
		fecha = new Date()
		fechaBaja = null
		asiento.reservar()
	}
	
	def boolean reservaDelUsuario(Usuario unUsuario) {
		(!asiento.disponible) && (!estaDadoDeBaja) && usuario.equals(unUsuario)
	}
	
	def boolean estaDadoDeBaja(){
		(fechaBaja != null)
	}
	
	

}
