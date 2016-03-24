package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Domain.Usuario
import java.util.List
import java.util.Map
import java.util.HashMap

class RepoUsuarios implements IRepoUsuarios {
	
	List<Usuario> todosLosUsuarios = newArrayList
	Map<Usuario, String> usuarioContrasenia = new HashMap<Usuario, String>
	
	public new() {
	}
	
	override void agregarUsuarioConContraseña(Usuario usuario, String contrasenia){
		todosLosUsuarios.add(usuario)
		usuarioContrasenia.put(usuario,contrasenia)
	}
	
	override void quitarUsuario(Usuario usuario, String contrasenia){
		todosLosUsuarios.remove(usuario)
		usuarioContrasenia.remove(usuario)
	}
	
	override boolean compararContraseña(String usr, String contraseniaIngresada){
		val Usuario usuario = this.obtenerUsuario(usr)
		usuarioContrasenia.get(usuario).equals(contraseniaIngresada)	
	} 
	
	
	override obtenerUsuario(String nombre){
		todosLosUsuarios.findFirst[usr|usr.nombre.matches(nombre) ]
	}
}