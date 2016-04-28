package edu.unsam.Salieri.Domain

import java.util.Date
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
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
	
//1 kilo de papas, comprar fideos, masa de tarta x2// NO ME ODIES MARCE!!!!!
	def boolean reservaDelUsuario(Usuario unUsuario) {
		(!asiento.disponible) && (!estaDadoDeBaja) && usuario.equals(unUsuario)
	}
	
	def boolean estaDadoDeBaja(){
		(fechaBaja != null)
	}
	
	

}
