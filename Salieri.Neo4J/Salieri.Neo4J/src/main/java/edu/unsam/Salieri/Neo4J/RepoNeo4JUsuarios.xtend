package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Domain.Usuario

class RepoNeo4JUsuarios  extends Neo4JAbstractRepo implements IRepoUsuarios {
	
	override agregarUsuarioConContraseña(Usuario usuario, String contrasenia) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override quitarUsuario(Usuario usuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override obtenerUsuario(String nombre) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}