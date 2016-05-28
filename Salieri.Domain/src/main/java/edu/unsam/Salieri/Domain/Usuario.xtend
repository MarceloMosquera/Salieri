package edu.unsam.Salieri.Domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
@org.mongodb.morphia.annotations.Entity
class Usuario {
	@Id
	@GeneratedValue
	public Long id
	
	@org.mongodb.morphia.annotations.Id ObjectId idd

	
	@Column(length=20)
	String nick
	@Column(length=50)
	String nombre
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
