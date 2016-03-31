package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.Aeropuerto
import java.util.Date

class DBContext implements IDBContext {

	static IRepoUsuarios _repoUsuarios = null
	static IRepoVuelos _repoVuelos = null

	override IRepoUsuarios repoUsuarios() {
		if (_repoUsuarios == null) {
			_repoUsuarios = new RepoUsuarios()
		}
		_repoUsuarios;
	}

	override IRepoVuelos repoVuelos() {
		if (_repoVuelos == null) {
			_repoVuelos = new RepoVuelos()
		}
		_repoVuelos;
	}

	new() {
		initUsuarios()
	}

	def void initUsuarios() {
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("adrian"), "adrian")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("ivan"), "ivan")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("nicolas"), "nicolas")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("marcelo"), "marcelo")
	}

	def void initVuelos() {
		
		val ezeiza = new Aeropuerto("Ezeiza (EZE)", "Buenos Aires", "Argentina")
		val marDelPlata = new Aeropuerto("Mar del Plata (MDQ)", "Buenos Aires", "Argentina")
		val mendoza = new Aeropuerto("Mendoza (MDZ)", "Mendoza", "Argentina")
		val guarulhos = new Aeropuerto("Aeropuerto Internacional de Guarulhos (GRU)", "São Paulo", "Brasil")
		val n2346 = new Vuelo ("N2346", "LAN AR",ezeiza,mendoza,new Date(2016, 03, 15, 8, 15, 23),new Date(2016, 03, 15, 10, 00, 00))
		val i9573 = new Vuelo("I9573", "Aerolinas Argentinas",marDelPlata,guarulhos,new Date(2016, 03, 16, 8, 15, 23),new Date(2016, 03, 16, 15, 00, 00))	
		
		repoVuelos.agregarVuelo(n2346)
		repoVuelos.agregarVuelo(i9573)

	}

}
