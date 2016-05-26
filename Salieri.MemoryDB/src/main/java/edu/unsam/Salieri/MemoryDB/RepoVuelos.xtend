package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoVuelos
import java.util.ArrayList
import java.util.List
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Domain.Aeropuerto
import java.util.Date

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
	
	override todos(){
		vuelos.toList
	}		
	
	
	override List<Vuelo> buscar(VueloBusqueda unBusqueda) {
//		var resultado = todos()
//		resultado = buscarVuelosPorOrigen(VueloBusqueda.origen, resultado)
//		resultado = buscarVuelosPorDestino(VueloBusqueda.destino, resultado)
//		resultado = buscarVuelosPorRangoDeFechas(VueloBusqueda.fechaMin, VueloBusqueda.fechaMax, resultado)
//		resultado = buscarVuelosPorMontoMaximo(VueloBusqueda.montoMax, resultado)
//		vuelosConsultados = resultado
	}

	def buscarVuelosConLugar(List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.vueloConLugar].toList
	}

	def buscarVuelosPorOrigen(Aeropuerto unOrigen, List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleDe(unOrigen)].toList
	}

	def buscarVuelosPorDestino(Aeropuerto unDestino, List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.pasaPor(unDestino)].toList
	}

	def buscarVuelosPorRangoDeFechas(Date fechaMin, Date fechaMax, List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.saleEntre(fechaMin, fechaMax)].toList
	}

	def buscarVuelosPorMontoMaximo(float montoMaximo, List<Vuelo> lista) {
		lista.filter[vuelo|vuelo.porMenosDe(montoMaximo)].toList
	}
	
}