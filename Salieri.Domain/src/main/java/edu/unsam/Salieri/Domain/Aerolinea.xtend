package edu.unsam.Salieri.Domain

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Aerolinea {
	String nombre
	
	new(String unNombre){
		nombre = unNombre
	}
	
}