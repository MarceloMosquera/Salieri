package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Consulta
import java.util.Date
import java.util.List
import edu.unsam.Salieri.Domain.Usuario

interface IRepoLogConsultas {

	def void quitarConsulta(Consulta unaConsulta)

	def List<Consulta> buscarConsultas(Consulta unEjemplo)
	
	def void agregarConsulta(Consulta unaConsulta)
	
	def List<Consulta> listarTodas()

}
