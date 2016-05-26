package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Vuelo
import java.util.List
import edu.unsam.Salieri.Domain.VueloBusqueda

interface IRepoVuelos {
	
	def void agregarVuelo(Vuelo unVuelo)
	
	def void quitarVuelo(Vuelo unVuelo)
	
	def List<Vuelo> todos()
	
	def List<Vuelo> buscar(VueloBusqueda unBusqueda)
	

}