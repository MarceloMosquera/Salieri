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
	
	def boolean validarPassword(String password){
		(password != null && password.equals(password))
	}
	
	override toString(){
		return nombre
	}	
}