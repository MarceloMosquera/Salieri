package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoUsuarios
import java.util.Iterator
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoNeo4JUsuarios extends Neo4JAbstractRepo implements IRepoUsuarios {

	override agregarUsuarioConContraseña(Usuario usuario, String contrasenia) {
		val transaction = graphDb.beginTx
		try {
			usuario.password = contrasenia
			usuario.nick = usuario.nombre
			
			var Node nodoUsuario = null
			if (usuario.id == null) {
				nodoUsuario = graphDb.createNode(EntityLabels.USUARIO)
			} else {
				nodoUsuario = getNodoUsuario(usuario.id)
			}
			convertToNode(usuario,nodoUsuario)
			transaction.success
			usuario.id = nodoUsuario.id
		} finally {
			cerrarTransaccion(transaction)
		}

	}

	private def Node getNodoUsuario(Long id) {
		basicSearch(" where ID(user) = " + id).head
	}

	override quitarUsuario(Usuario usuario) {
	}

	override obtenerUsuario(String nombre) {
		convertToUsuario(basicSearch(" where user.nombre = '" + nombre+"' ").head)
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (user:" + EntityLabels.USUARIO.toString() + ") " + where + " return user")
		val Iterator<Node> usuario_column = result.columnAs("user")
		return usuario_column
	}

	def void cleanDB() {
		val transaction = graphDb.beginTx
		try {
			graphDb.execute("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r")
			transaction.success
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	

	def convertToUsuario(Node nodeUsuario) {
		new Usuario => [
			id = nodeUsuario.id
			nombre = nodeUsuario.getProperty("nombre") as String
			password = nodeUsuario.getProperty("password") as String
			nick =  nodeUsuario.getProperty("nick") as String
		]
	}
	
	def convertToNode(Usuario usuario, Node nodeUsuario) {
		nodeUsuario => [
			setProperty("nombre", usuario.nombre+"")
			setProperty("password", usuario.password+"")
			setProperty("nick",usuario.nick+"")
		]
	}
}
