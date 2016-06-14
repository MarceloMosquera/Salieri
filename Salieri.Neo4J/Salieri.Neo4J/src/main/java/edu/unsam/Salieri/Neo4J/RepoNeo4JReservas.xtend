package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoReservas
import java.util.Date
import java.util.Iterator
import java.util.List
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

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

//TODO: Necesario??
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
			val rel_usuario = nodeReserva.getRelationships(RelacionesReserva.RESERVA_USUARIO)
			usuario = rel_usuario.getProperty(RelacionesReserva.RESERVA_USUARIO,"usuario") as Usuario
			asiento = nodeReserva.getProperty("asiento") as Asiento
			vuelo = nodeReserva.getProperty("vuelo") as Vuelo
		]
	}

	def void saveOrUpdateReserva(Reserva reserva) {
		val transaction = graphDb.beginTx
		try {
			var Node nodoReserva = null
			if (reserva.id == null) {
				nodoReserva = graphDb.createNode
				nodoReserva.addLabel(labelReserva)
			} else {
				nodoReserva = getNodoReserva(reserva.id)
			}
			actualizarReserva(reserva, nodoReserva)
			transaction.success
			reserva.id = nodoReserva.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	// TODO: revisar como buscar nuestros nodos
	private def getNodosReservas(String valor) {
		basicSearch("peli.title =~ '(?i).*" + valor + ".*'")
	}

	private def Node getNodoReserva(Long id) {
		basicSearch("ID(peli) = " + id).head
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (peli:Movie) where " + where + " return peli")
		val Iterator<Node> peli_column = result.columnAs("peli")
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
		// trame todas las relaciones Usuario_Asiento
	}

	private def void actualizarReserva(Reserva reserva, Node nodeReserva) {
		nodeReserva => [
			if(reserva.fechaBaja !=null){
			setProperty("fechaBaja", reserva.fechaBaja)
			}
			// Borro las relaciones que tenga ese nodo
			relationships.forEach[it.delete]
			// Creo relaciones nuevas
//TODO: Corregir esto que no va a funcionar una mierda, necesitamos que se puedan comunicar entre los repos
			val Node nodeUsuario = DBContextN4J.repoUsuarios.getNodoUsuarioById(reserva.usuario.id)
			val relUsuario = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_USUARIO)

			val Node nodeVuelo = DBContextN4J.repoVuelos.getNodoVueloById(reserva.vuelo.id)
			val relVuelo = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_VUELO)

			val Node nodeAsiento = DBContextN4J.repoVuelos.getAsientoDelVueloById(reserva.asiento.id)
			val relAsiento = nodeUsuario.createRelationshipTo(it, RelacionesReserva.RESERVA_ASIENTO)

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


	private def Label labelReserva() {
		Label.label("Reserv")
	}

}
