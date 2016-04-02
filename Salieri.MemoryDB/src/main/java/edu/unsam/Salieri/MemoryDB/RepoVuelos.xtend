package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Repository.IRepoVuelos
import java.util.ArrayList
import java.util.Date
import java.util.List

class RepoVuelos implements IRepoVuelos {
	List<Vuelo> vuelos
	new(){
		vuelos = new ArrayList
	}
	
	override agregarVuelo(Vuelo unVuelo) {
		vuelos.add(unVuelo)
	}
	
	override quitarVuelo(Vuelo unVuelo) {
		vuelos.remove(unVuelo)
	}
	
	override buscarVuelos(VueloBusqueda vueloBusqueda) {		
		var resultado = buscarVuelosConLugar()
		resultado = buscarVuelosPorOrigen(vueloBusqueda.origen ,resultado)
		resultado = buscarVuelosPorDestino(vueloBusqueda.destino ,resultado)
		resultado = buscarVuelosPorRangoDeFechas(vueloBusqueda.fechaMin,vueloBusqueda.fechaMax,resultado)
		resultado = buscarVuelosPorMontoMaximo(vueloBusqueda.montoMax ,resultado)
	}
	
	override buscarVuelosConLugar() { 
		vuelos.filter[vuelo|vuelo.vueloConLugar].toList
	}
	
	override buscarVuelosPorOrigen(Aeropuerto unOrigen,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleDe(unOrigen)].toList
	}
	
	override buscarVuelosPorDestino(Aeropuerto unDestino,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.pasaPor(unDestino)].toList 
	}
	
	override buscarVuelosPorRangoDeFechas(Date fechaMin, Date fechaMax,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleEntre(fechaMin,fechaMax)].toList 
	}
	
	override buscarVuelosPorMontoMaximo(float montoMaximo,List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.asientoPorMenosDe(montoMaximo)].toList
	}
		
}