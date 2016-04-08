package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoVuelos
import java.util.ArrayList
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
	
	override todos(){
		vuelos.toList
	}		
}