package edu.unsam.Salieri.Domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Usuario {
	String nick
	String nombre
	String password
	
	new(){}
	
	new(String elNombre){
		nombre = elNombre
	}
	
	def boolean esPasswordValida(String unaPassword){
		(password != null) && (password.equals(unaPassword))
	}
	
	override toString(){
		return nombre
	}	
}