package edu.unsam.Salieri.Domain

import org.uqbar.commons.utils.Observable

@Observable
class Aeropuerto {
	String nombre
	String ciudad
	String pais
	
	new(String unNombre, String unaCiudad, String unPais){
		nombre = unNombre
		ciudad = unaCiudad
		pais = unPais
	}
	
	override toString(){
		return ciudad
	}
}