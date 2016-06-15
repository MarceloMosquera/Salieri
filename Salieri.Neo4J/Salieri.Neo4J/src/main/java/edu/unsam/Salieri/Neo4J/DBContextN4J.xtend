package edu.unsam.Salieri.Neo4J

//import MongoDB.RepoLogConsultas
import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos

class DBContextN4J implements IDBContext {

	static IRepoUsuarios _repoUsuarios = null
	static IRepoVuelos _repoVuelos = null
	static IRepoReservas _repoReservas = null
	static IRepoAeropuertos _repoAeropuertos = null
	static IRepoLogConsultas _repoLogConsultas = null

	private static DBContextN4J instance
	def static DBContextN4J getInstance() {
		if (instance == null) {
			instance = new DBContextN4J
		}
		instance
	}


	override IRepoUsuarios repoUsuarios() {
		if (_repoUsuarios == null) {
			_repoUsuarios = new RepoNeo4JUsuarios()
		}
		_repoUsuarios;
	}

	override IRepoVuelos repoVuelos() {
		if (_repoVuelos == null) {
			_repoVuelos = new RepoNeo4JVuelos()
		}
		_repoVuelos;
	}

	override IRepoReservas repoReservas() {
		if (_repoReservas == null) {
			_repoReservas = new RepoNeo4JReservas()
		}
		_repoReservas;
	}

	override IRepoAeropuertos repoAeropuertos() {
		if (_repoAeropuertos == null) {
			_repoAeropuertos = new RepoNeo4JAeropuertos()
		}
		_repoAeropuertos;
	}

	new() {
	}

	override repoLogConsultas() {
		if (_repoLogConsultas == null) {
			_repoLogConsultas = new RepoNeo4JLogConsultas()
		}
		_repoLogConsultas;
	}

	def void cleanDB()
	{
		
	}
	
}