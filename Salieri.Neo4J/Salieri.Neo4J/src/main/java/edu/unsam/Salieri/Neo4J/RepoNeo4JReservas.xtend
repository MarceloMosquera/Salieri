package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Util.SSDate
import java.util.Date
import java.util.Iterator
import java.util.List
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.ArrayList
import org.neo4j.graphdb.Relationship

class RepoNeo4JReservas extends Neo4JAbstractRepo implements IRepoReservas {

	new() {
	}

	def List<Reserva> getReservas(String valor) {
		val transaction = graphDb.beginTx
		try {
			getNodosReservas(valor).map [ Node node |
				convertToReserva(node, false)
			].toList
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def Reserva getReserva(Long id) {
		val transaction = graphDb.beginTx
		try {
			convertToReserva(getNodoReserva(id), true)
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def convertToReserva(Node nodeReserva, boolean deep) {
		new Reserva => [
			id = nodeReserva.id
			fecha = nodeReserva.getProperty("fecha") as Date
			val fechaBajaNodo = nodeReserva.getProperty("fechaBaja") as Date
			if (fechaBajaNodo != null) {
				fechaBaja = fechaBajaNodo
			}
//				val rel_actuaron = nodePelicula.getRelationships(RelacionesPelicula.ACTED_IN)
			val rel_usuario = nodeReserva.getRelationships(Relationships.RESERVA)
			//usuario = rel_usuario.getProperty(RelacionesReserva.RESERVA_USUARIO,"usuario") as Usuario
			asiento = nodeReserva.getProperty("asiento") as Asiento
			vuelo = nodeReserva.getProperty("vuelo") as Vuelo
		]
	}
	
	def convertToReserva(Relationship relReserva, boolean deep) {
		var repoVuelos = new RepoNeo4JVuelos
		var reserva = new Reserva => [
			id = relReserva.id
			fecha = SSDate.p(relReserva.getProperty("fechaSalida") as String)
//			var fechabaja = relReserva.getProperty("fechaBaja") as String
//			if (fechabaja != ""){
//				fechaBaja = SSDate.p(fechabaja)
//			}
		]
		var relVuelo = relReserva.endNode.getRelationships(Relationships.VUELO_ASIENTO)
		reserva.vuelo = repoVuelos.convertToVuelo(relVuelo.head.startNode)
		reserva.asiento = repoVuelos.convertToAsiento(relReserva.endNode, reserva.vuelo)
		reserva
	}

	def void saveOrUpdateReserva(Reserva reserva) {
		val transaction = graphDb.beginTx
		try {
			var nodeUsuario = getNodoById(EntityLabels.USUARIO, reserva.usuario.id)
			var nodeAsiento = getNodoById(EntityLabels.ASIENTO, reserva.asiento.id)
//			var relReserva = nodeUsuario.getRelationships(Relationships.RESERVA)
//				.findFirst[rel | rel.endNode.equals(nodeAsiento)]
			var relReserva = nodeUsuario.createRelationshipTo(nodeAsiento, Relationships.RESERVA)
			relReserva.setProperty("fechaSalida", SSDate.toPersist(reserva.fecha))
			if (reserva.fechaBaja != null){
				relReserva.setProperty("fechaBaja", SSDate.toPersist(reserva.fechaBaja))
			}
			nodeAsiento.setProperty("disponible", reserva.asiento.disponible)
			transaction.success
			reserva.id = relReserva.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}



	private def getNodosReservas(String valor) {
		basicSearch("reserva.title =~ '(?i).*" + valor + ".*'")
	}

	private def Node getNodoReserva(Long id) {
		basicSearch("ID(reserva) = " + id).head
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (reserva:Movie) where " + where + " return reserva")
		val Iterator<Node> peli_column = result.columnAs("reserva")
		return peli_column
	}

	override void agregarReserva(Reserva unaReserva) {
		saveOrUpdateReserva(unaReserva)
	}

	override void quitarReserva(Reserva unaReserva) {
		unaReserva.cancelar()
		actualizarReserva(unaReserva, getNodoReserva(unaReserva.id))
	}

	override List<Reserva> buscarReservaDelUsuario(Usuario unUsuario) {
		var nodeUsuario = getNodoById(EntityLabels.USUARIO, unUsuario.id)
		nodeUsuario.getRelationships(Relationships.RESERVA)
			.map[rel|convertToReserva(rel, true)].toList
	}

	private def void actualizarReserva(Reserva reserva, Node nodeReserva) {
		nodeReserva => [
			if(reserva.fechaBaja !=null){
			setProperty("fechaBaja", reserva.fechaBaja)
			}
//			// Borro las relaciones que tenga ese nodo
//			relationships.forEach[it.delete]
//			// Creo relaciones nuevas
//			val Node nodeUsuario = DBContextN4J.repoUsuarios.getNodoUsuarioById(reserva.usuario.id)
//			val relUsuario = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_USUARIO)
//
//			val Node nodeVuelo = DBContextN4J.repoVuelos.getNodoVueloById(reserva.vuelo.id)
//			val relVuelo = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_VUELO)
//
//			val Node nodeAsiento = DBContextN4J.repoVuelos.getAsientoDelVueloById(reserva.asiento.id)
//			val relAsiento = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_ASIENTO)

		// como lo hiso dodain con una lista
//			reserva.personajes.forEach [ personaje |
//				val Node nodoActor = RepoActores.instance.getNodoActorById(personaje.actor.id)
//				val relPersonaje = nodoActor.createRelationshipTo(it, RelacionesPelicula.ACTED_IN)
//				
//				// Manganeta para usar arrays porque el [] se confunde con el bloque
//				val roles = personaje.roles		
//				var String[] _roles = #[]
//				_roles = roles.toArray(_roles)
//				relPersonaje.setProperty("roles", _roles)	
//			]
		]
	}


}
