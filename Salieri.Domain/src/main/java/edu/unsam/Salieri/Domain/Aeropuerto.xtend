package edu.unsam.Salieri.Domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
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

	static Aeropuerto _aeropuertoVacio = new Aeropuerto("", "", "")
	def static Aeropuerto aeropuertoVacio()
	{
		_aeropuertoVacio
	}
	
	def boolean mismoNombre(String unNombre){
		nombre.equalsIgnoreCase(unNombre)
	}
	
	override toString(){
		return nombre
	}
}