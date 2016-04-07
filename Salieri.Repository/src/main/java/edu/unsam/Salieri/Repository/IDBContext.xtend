package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Reserva

interface IDBContext {

	def IRepoUsuarios repoUsuarios()

	def IRepoVuelos repoVuelos()
	
	def IRepoReservas repoReservas()

	def IRepoAeropuertos repoAeropuertos()
	

}
