package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import MongoDB.RepoLogConsultas

class DBContextSql implements IDBContext {

	static IRepoUsuarios _repoUsuarios = null
	static IRepoVuelos _repoVuelos = null
	static IRepoReservas _repoReservas = null
	static IRepoAeropuertos _repoAeropuertos = null
	static IRepoLogConsultas _repoLogConsultas = null

	override IRepoUsuarios repoUsuarios() {
		if (_repoUsuarios == null) {
			_repoUsuarios = new RepoHybernateUsuarios()
		}
		_repoUsuarios;
	}

	override IRepoVuelos repoVuelos() {
		if (_repoVuelos == null) {
			_repoVuelos = new RepoHybernateVuelos()
		}
		_repoVuelos;
	}

	override IRepoReservas repoReservas() {
		if (_repoReservas == null) {
			_repoReservas = new RepoHybernateReservas()
		}
		_repoReservas;
	}

	override IRepoAeropuertos repoAeropuertos() {
		if (_repoAeropuertos == null) {
			_repoAeropuertos = new RepoHybernateAeropuertos()
		}
		_repoAeropuertos;
	}

	new() {
	}

	override repoLogConsultas() {
		if (_repoLogConsultas == null) {
			_repoLogConsultas = new RepoLogConsultas()
		}
		_repoLogConsultas;
	}

}
