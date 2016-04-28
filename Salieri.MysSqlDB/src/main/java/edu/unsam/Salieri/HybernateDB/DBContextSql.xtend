package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Descuento.Descuento
import edu.unsam.Salieri.Domain.Descuento.DescuentoMonto
import edu.unsam.Salieri.Domain.Descuento.DescuentoPorcentaje
import edu.unsam.Salieri.Domain.Descuento.DescuentoRegla72HsAntes
import edu.unsam.Salieri.Domain.Descuento.DescuentoReglaSiempre
import edu.unsam.Salieri.Domain.Escala
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Util.SSDate
import java.util.Date

class DBContextSql implements IDBContext {
	

	static IRepoUsuarios _repoUsuarios = null
	static IRepoVuelos _repoVuelos = null
	static IRepoReservas _repoReservas = null
	static IRepoAeropuertos _repoAeropuertos = null

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

	
}