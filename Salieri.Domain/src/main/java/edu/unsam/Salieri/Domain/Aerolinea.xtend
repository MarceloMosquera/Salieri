package edu.unsam.Salieri.Domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors

class Aerolinea {
	String nombre
	
	new(String unNombre){
		nombre = unNombre
	}
	
}