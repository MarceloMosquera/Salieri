package edu.unsam.Salieri.Domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {
	String nombre
	String password
	
	new(){}
	
	new(String elNombre){
		nombre = elNombre
	}
}