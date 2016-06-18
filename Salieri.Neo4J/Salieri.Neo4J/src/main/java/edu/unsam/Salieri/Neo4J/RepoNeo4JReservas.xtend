package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Util.SSDate
import java.util.List
import org.neo4j.graphdb.Relationship

class RepoNeo4JReservas extends Neo4JAbstractRepo implements IRepoReservas {

	new() {
	}

	def convertToReserva(Relationship relReserva, boolean deep) {
		var repoVuelos = new RepoNeo4JVuelos
		var repoUsuario = new RepoNeo4JUsuarios
		var reserva = new Reserva => [
			id = relReserva.id
			fecha = SSDate.p(relReserva.getProperty("fecha") as String)
			try {
				var lFechaBaja = relReserva.getProperty("fechaBaja") as String
				if (lFechaBaja != ""){
					fechaBaja = SSDate.p(lFechaBaja)
				}
			} finally {}

		]
		reserva.usuario = repoUsuario.convertToUsuario(relReserva.startNode)
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
			var Relationship relReserva = null
			if (reserva.id == null) {
				relReserva = nodeUsuario.createRelationshipTo(nodeAsiento, Relationships.RESERVA)
			} else {
				relReserva = getRelationById(Relationships.RESERVA, reserva.id)
			}
			relReserva.setProperty("fecha", SSDate.toPersist(reserva.fecha))
			var lFechaBaja = ""
			if (reserva.fechaBaja != null){
				lFechaBaja = SSDate.toPersist(reserva.fechaBaja)
			}
			relReserva.setProperty("fechaBaja", lFechaBaja)
			nodeAsiento.setProperty("disponible", reserva.asiento.disponible)
			transaction.success
			reserva.id = relReserva.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	override void agregarReserva(Reserva unaReserva) {
		saveOrUpdateReserva(unaReserva)
	}

	override void quitarReserva(Reserva unaReserva) {
		unaReserva.cancelar()
		saveOrUpdateReserva(unaReserva)
	}

	override List<Reserva> buscarReservaDelUsuario(Usuario unUsuario) {
		var nodeUsuario = getNodoById(EntityLabels.USUARIO, unUsuario.id)
		nodeUsuario.getRelationships(Relationships.RESERVA)
			.map[rel|convertToReserva(rel, true)]
			.filter[reserva| reserva.fechaBaja == null]
			.toList
	}

}
