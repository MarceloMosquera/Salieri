package edu.unsam.Salieri.Domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
class Aeropuerto {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String nombre
	
	@Column
	String ciudad
	
	@Column
	String pais

	new() {
	}

	new(String unNombre, String unaCiudad, String unPais) {
		nombre = unNombre
		ciudad = unaCiudad
		pais = unPais
	}

	static Aeropuerto _aeropuertoVacio = new Aeropuerto("", "", "")

	def static Aeropuerto aeropuertoVacio() {
		_aeropuertoVacio
	}

	def boolean mismoNombre(String unNombre) {
		nombre.equalsIgnoreCase(unNombre)
	}

	override toString() {
		return nombre
	}
}
