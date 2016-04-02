package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import java.util.ArrayList
import java.util.List

class RepoAeropuertos implements IRepoAeropuertos{
	
	List<Aeropuerto> aeropuertos
	
	new(){
		aeropuertos = new ArrayList
		aeropuertos.add(Aeropuerto.aeropuertoVacio())
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
	override todosSinVacio(){
		aeropuertos.filter[ aerop | !aerop.equals(Aeropuerto.aeropuertoVacio())  ].toList
	}

	override buscarAeropuertoPorNombre(String aeropuertoNombre){
		//aeropuertos.filter[aeropuerto | aeropuerto.nombre == aeropuertoNombre ].toList
	}
	
}