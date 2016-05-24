package edu.unsam.Salieri.Domain

import java.util.Date
import java.util.List

class Consulta {
	
	Date fechaConsulta
	Aeropuerto consultaOrigen
	Aeropuerto consultaDestino
	Date consultaFechaMin
	Date consultaFechaMax
	float consultaMontoMax
	List<Vuelo> vuelosConsultados
	Usuario usuarioConsulta
		
	new(VueloBusqueda vueloBusqueda, Usuario usuario){
	fechaConsulta = new Date()
	consultaOrigen = vueloBusqueda.origen
	consultaDestino = vueloBusqueda.destino
	consultaFechaMax = vueloBusqueda.fechaMax
	consultaFechaMin = vueloBusqueda.fechaMin
	consultaMontoMax = vueloBusqueda.montoMax
	vuelosConsultados = vueloBusqueda.vuelosConsultados
	usuarioConsulta = usuario
	
	println(this.toString)
	}
	
	override toString(){
		"fecha consula:" + fechaConsulta.toString + ", usuario:" usuarioConsulta.nombre + ", destino: " + consultaDestino.nombre 
	}
}