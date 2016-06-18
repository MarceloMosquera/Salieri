package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import java.util.Iterator
import java.util.List
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoNeo4JAeropuertos extends Neo4JAbstractRepo implements IRepoAeropuertos {

	override void agregarAeropuerto(Aeropuerto unAeropuerto) {
		val transaction = graphDb.beginTx
		try {
			var Node nodoAeropuerto = null
			if (unAeropuerto.id == null) {
				nodoAeropuerto = graphDb.createNode(EntityLabels.AEROPUERTO)
			} else {
				nodoAeropuerto = getNodoById(EntityLabels.AEROPUERTO, unAeropuerto.id)
			}
			convertToNode(unAeropuerto, nodoAeropuerto)
			transaction.success
			unAeropuerto.id = nodoAeropuerto.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	override void quitarAeropuerto(Aeropuerto unAeropuerto) {
		// no implementado
	}

	override List<Aeropuerto> todos() {
		basicSearch("").map[node|convertToAeropuerto(node)].toList
	}

	override List<Aeropuerto> todosSinVacio() {
		
	}

	override Aeropuerto buscarAeropuertoPorNombre(String aeropuertoNombre) {
		convertToAeropuerto(basicSearch(" where aero.nombre = '" + aeropuertoNombre+"' ").head)
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (aero:" + EntityLabels.AEROPUERTO.toString() + ") " + where + " return aero")
		val Iterator<Node> aeropuerto_column = result.columnAs("aero")
		return aeropuerto_column
	}


	def convertToAeropuerto(Node nodeAeropuerto) {
		new Aeropuerto => [
			id = nodeAeropuerto.id
			nombre = nodeAeropuerto.getProperty("nombre") as String
			ciudad = nodeAeropuerto.getProperty("ciudad") as String
			pais = nodeAeropuerto.getProperty("pais") as String
		]
	}
	def convertToNode(Aeropuerto unAeropuerto, Node nodoAeropuerto) {
		nodoAeropuerto => [
			setProperty("nombre", unAeropuerto.nombre+"")
			setProperty("ciudad", unAeropuerto.ciudad+"")
			setProperty("pais", unAeropuerto.pais+"")
		]
	}
}
