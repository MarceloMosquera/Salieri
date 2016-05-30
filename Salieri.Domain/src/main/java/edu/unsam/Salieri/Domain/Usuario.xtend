package edu.unsam.Salieri.Domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Transient
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
@org.mongodb.morphia.annotations.Entity
class Usuario {
	@Id
	@org.mongodb.morphia.annotations.Id
	@GeneratedValue
	public Long id
	
	@Column(length=20)
	String nick
	@Column(length=50)
	String nombre
	
	@Transient
	@Column(length=10)
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
