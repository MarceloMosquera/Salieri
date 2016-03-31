package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Repository.IRepoVuelos
import java.util.ArrayList
import java.util.Date
import java.util.List

class RepoVuelos implements IRepoVuelos {
	List<Vuelo> resultado
	List<Vuelo> vuelos
	new(){
		vuelos = new ArrayList
		resultado = new ArrayList
	}
	
	override agregarVuelo(Vuelo unVuelo) {
		vuelos.add(unVuelo)
	}
	
	override quitarVuelo(Vuelo unVuelo) {
		vuelos.remove(unVuelo)
	}
	
	override buscarVuelos(VueloBusqueda vueloBusqueda) {		
		resultado = buscarVuelosConLugar()
		resultado = buscarVuelosPorOrigen(vueloBusqueda.origen ,resultado)
		resultado = buscarVuelosPorDestino(vueloBusqueda.origen ,resultado)
		resultado = buscarVuelosPorRangoDeFechas(vueloBusqueda.fechaMin,vueloBusqueda.fechaMax,resultado)
		resultado = buscarVuelosPorMontoMaximo(vueloBusqueda.montoMax ,resultado)
	}
	
	override buscarVuelosConLugar() { 
		vuelos.filter[vuelo|vuelo.vueloConLugar].toList
	}
	
	override buscarVuelosPorOrigen(Aeropuerto unOrigen,List<Vuelo> resultado) {
		//Hay que definir como hacemos esto
	}
	
	override buscarVuelosPorDestino(Aeropuerto unDestino,List<Vuelo> resultado) {
		//Hay que definir como hacemos esto
	}
	
	override buscarVuelosPorRangoDeFechas(Date fechaMin, Date fechaMax,List<Vuelo> resultado) {
		vuelos.filter[vuelo|vuelo.saleEntre(fechaMin,fechaMax)].toList 
	}
	
	override buscarVuelosPorMontoMaximo(float montoMaximo,List<Vuelo> resultado) {
		vuelos.filter[vuelo|vuelo.asientoPorMenosDe(montoMaximo)].toList
	}
		
}