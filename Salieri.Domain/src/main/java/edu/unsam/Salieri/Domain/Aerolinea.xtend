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
class Aerolinea {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	String nombre

	new() {
	}

	new(String unNombre) {
		nombre = unNombre
	}

}
