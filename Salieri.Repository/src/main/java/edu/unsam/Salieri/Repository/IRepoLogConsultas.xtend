package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Consulta
import java.util.List

interface IRepoLogConsultas {

	def void quitarConsulta(Consulta unaConsulta)

	def List<Consulta> buscarConsultas()
	
	def void agregarConsulta(Consulta unaConsulta)

}
