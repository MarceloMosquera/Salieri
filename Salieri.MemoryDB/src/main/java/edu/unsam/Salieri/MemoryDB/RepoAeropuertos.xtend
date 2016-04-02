package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import java.util.ArrayList
import java.util.List

class RepoAeropuertos implements IRepoAeropuertos{
	
	List<Aeropuerto> aeropuertos
	
	new(){
		aeropuertos = new ArrayList
	}
	
	override agregarAeropuerto(Aeropuerto unAeropuerto){
		aeropuertos.add(unAeropuerto)
	}
	
	override quitarAeropuerto(Aeropuerto unAeropuerto){
		aeropuertos.remove(unAeropuerto)
	}
	
	override todos(){
		aeropuertos.toList
	}

	override buscarAeropuertoPorNombre(String aeropuertoNombre){
		//aeropuertos.filter[aeropuerto | aeropuerto.nombre == aeropuertoNombre ].toList
	}
	
}