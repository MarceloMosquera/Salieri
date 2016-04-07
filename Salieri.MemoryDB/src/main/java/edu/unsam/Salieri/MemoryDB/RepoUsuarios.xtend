package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoUsuarios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class RepoUsuarios implements IRepoUsuarios {
	
	List<Usuario> todosLosUsuarios = newArrayList
	
	public new() {
	}
	
	override void agregarUsuarioConContraseña(Usuario usuario, String contrasenia){
		usuario.password = contrasenia
		todosLosUsuarios.add(usuario)
	}
	
	override void quitarUsuario(Usuario usuario){
		todosLosUsuarios.remove(usuario)
	}
	
	
	override obtenerUsuario(String nombre){
		todosLosUsuarios.findFirst[usr|usr.nombre.matches(nombre) ]
	}
}