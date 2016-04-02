package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Aeropuerto
import java.util.List

interface IRepoAeropuertos {
	
	def void agregarAeropuerto(Aeropuerto unAeropuerto){}
	
	def void quitarAeropuerto(Aeropuerto unAeropuerto){}
	
	def List<Aeropuerto> todos(){}
	
	def List<Aeropuerto> buscarAeropuertoPorNombre(String aeropuertoNombre){}
	
}