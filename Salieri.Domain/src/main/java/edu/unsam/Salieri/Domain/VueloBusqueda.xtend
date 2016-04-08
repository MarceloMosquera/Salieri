package edu.unsam.Salieri.Domain

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VueloBusqueda {
 	Aeropuerto origen
 	Aeropuerto destino
 	Date fechaMin
 	Date fechaMax
 	float montoMax 	


 	def buscarVuelos(List<Vuelo> losVuelos) {		
		var resultado = buscarVuelosConLugar(losVuelos)
		resultado = buscarVuelosPorOrigen(origen , resultado)
		resultado = buscarVuelosPorDestino(destino ,resultado)
		resultado = buscarVuelosPorRangoDeFechas(fechaMin,fechaMax,resultado)
		resultado = buscarVuelosPorMontoMaximo(montoMax ,resultado)
	}
	
	def buscarVuelosConLugar(List<Vuelo> lista) { 
		lista.filter[vuelo|vuelo.vueloConLugar].toList
	}
	
	def buscarVuelosPorOrigen(Aeropuerto unOrigen,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleDe(unOrigen)].toList
	}
	
	def buscarVuelosPorDestino(Aeropuerto unDestino,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.pasaPor(unDestino)].toList 
	}
	
	def buscarVuelosPorRangoDeFechas(Date fechaMin, Date fechaMax,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleEntre(fechaMin,fechaMax)].toList 
	}
	
	def buscarVuelosPorMontoMaximo(float montoMaximo,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.porMenosDe(montoMaximo)].toList
	}


}