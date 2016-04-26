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
class Usuario {
	@Id
	@GeneratedValue
	public Long id
	@Column
	String nick
	@Column
	String nombre
	@Column
	String password

	new() {
	}

	new(String elNombre) {
		nombre = elNombre
	}

	def boolean esPasswordValida(String unaPassword) {
		(password != null) && (password.equals(unaPassword))
	}

	override toString() {
		return nombre
	}
}
