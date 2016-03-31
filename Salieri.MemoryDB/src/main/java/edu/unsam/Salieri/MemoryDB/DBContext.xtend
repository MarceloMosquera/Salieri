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
		init()
	}

	def void init() {
		val diego = new Usuario("diego")
		val ivan = new Usuario("ivan")
		val nicolas = new Usuario("nicolas")
		val marcelo = new Usuario("marcelo")
		repoUsuarios.agregarUsuarioConContraseña(diego, "diego")
		repoUsuarios.agregarUsuarioConContraseña(ivan, "ivan")
		repoUsuarios.agregarUsuarioConContraseña(nicolas, "nicolas")
		repoUsuarios.agregarUsuarioConContraseña(marcelo, "marcelo")

		val ezeiza = new Aeropuerto("Ezeiza (EZE)", "Buenos Aires", "Argentina")
		val marDelPlata = new Aeropuerto("Mar del Plata (MDQ)", "Buenos Aires", "Argentina")
		val mendoza = new Aeropuerto("Mendoza (MDZ)", "Mendoza", "Argentina")
		val guarulhos = new Aeropuerto("Aeropuerto Internacional de Guarulhos (GRU)", "São Paulo", "Brasil")
		val n2346 = new Vuelo("N2346", "LAN AR", ezeiza, mendoza, new Date(2016, 03, 15, 8, 15, 23),
			new Date(2016, 03, 15, 10, 00, 00))
		val i9573 = new Vuelo("I9573", "Aerolinas Argentinas", marDelPlata, guarulhos,
			new Date(2016, 03, 16, 8, 15, 23), new Date(2016, 03, 16, 15, 00, 00))

		repoVuelos.agregarVuelo(n2346)
		repoVuelos.agregarVuelo(i9573)

		val asiento1 = n2346.asientos.get(1)
		val asiento2 = n2346.asientos.get(2)
		val asiento3 = i9573.asientos.get(3)
		val asiento4 = i9573.asientos.get(4)

		n2346.reservarAsiento(asiento1, ivan)
		n2346.reservarAsiento(asiento2, diego)
		n2346.reservarAsiento(asiento3, nicolas)
		n2346.reservarAsiento(asiento4, marcelo)
	}

}
