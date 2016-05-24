package edu.unsam.Salieri.Repository

interface IDBContext {

	def IRepoUsuarios repoUsuarios()

	def IRepoVuelos repoVuelos()
	
	def IRepoReservas repoReservas()

	def IRepoAeropuertos repoAeropuertos()
	
	def IRepoLogConsultas repoLogConsultas()

}
