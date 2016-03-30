package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos

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

	new (){
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("adrian"), "adrian")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("ivan"), "ivan")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("nicolas"), "nicolas")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("marcelo"), "marcelo")
	}
}