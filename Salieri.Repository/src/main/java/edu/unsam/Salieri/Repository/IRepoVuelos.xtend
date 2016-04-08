package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Vuelo
import java.util.List

interface IRepoVuelos {
	
	def void agregarVuelo(Vuelo unVuelo)
	
	def void quitarVuelo(Vuelo unVuelo)
	
	def List<Vuelo> todos()

}