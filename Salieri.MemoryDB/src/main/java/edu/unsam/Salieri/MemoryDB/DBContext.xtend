package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Domain.Usuario

class DBContext implements IDBContext {
	static IRepoUsuarios _repoUsuarios = null
	
	override IRepoUsuarios repoUsuarios() {
		if (_repoUsuarios == null) {
			_repoUsuarios = new RepoUsuarios()
		}
      _repoUsuarios;
	}
	
	new (){
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("adrian"), "adrian")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("ivan"), "ivan")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("nicolas"), "nicolas")
		repoUsuarios.agregarUsuarioConContraseña(new Usuario("marcelo"), "marcelo")
	}
	//123
}