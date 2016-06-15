package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Util.SSDate
import java.util.Iterator
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

class RepoNeo4JVuelos  extends Neo4JAbstractRepo implements IRepoVuelos {
	
	override agregarVuelo(Vuelo unVuelo) {
		val transaction = graphDb.beginTx
		try {
			
			var Node nodoVuelo = null
			if (unVuelo.id == null) {
				nodoVuelo = graphDb.createNode(EntityLabels.VUELO)
			} else {
				nodoVuelo = getNodoVuelo(unVuelo.id)
			}
			convertToNode(unVuelo, nodoVuelo)
			transaction.success
			unVuelo.id = nodoVuelo.id
		} finally {
			cerrarTransaccion(transaction)
		}
		
	}
	
	private def Node getNodoVuelo(Long id) {
		basicSearch(" where ID(vuelo) = " + id).head
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (vuelo:" + EntityLabels.VUELO.toString() + ") " + where + " return vuelo")
		val Iterator<Node> vuelo_column = result.columnAs("vuelo")
		return vuelo_column
	}
	
	override quitarVuelo(Vuelo unVuelo) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override todos() {
		basicSearch("").map[node|convertToVuelo(node)].toList
	}
	
	override buscar(VueloBusqueda unBusqueda) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def convertToVuelo(Node nodeVuelo) {
		new Vuelo => [
			id = nodeVuelo.id
			nroVuelo = nodeVuelo.getProperty("nombre") as String
			aerolinea = nodeVuelo.getProperty("nombre") as String
			//origen = nodeVuelo.getProperty("nombre") as String
			//destino = nodeVuelo.getProperty("nombre") as String
			fechaSalida =  SSDate.p(nodeVuelo.getProperty("fechaSalida") as String)
			fechaArribo = SSDate.p(nodeVuelo.getProperty("fechaArribo") as String)
			//List<Asiento> asientos
			//Set<Escala> escalas
			tarifaDefault = nodeVuelo.getProperty("tarifaDefault") as Float
		]
	}
	
	def convertToNode(Vuelo unVuelo, Node nodeVuelo) {
		val repoAero = new RepoNeo4JAeropuertos

		nodeVuelo => [
			setProperty("nroVuelo", unVuelo.nroVuelo)
			setProperty("aerolinea", unVuelo.aerolinea)
			setProperty("fechaSalida", SSDate.toShow(unVuelo.fechaSalida))
			setProperty("fechaArribo", SSDate.toShow(unVuelo.fechaArribo))
			setProperty("tarifaDefault", unVuelo.tarifaDefault)

			val nodeAeroOrig = repoAero.getNodoAeropuerto(unVuelo.origen.id)
			createRelationshipTo(nodeAeroOrig, Relationships.VUELO_AEROPUERTO_ORIGEN)

			val nodeAeroDest = repoAero.getNodoAeropuerto(unVuelo.destino.id)
			createRelationshipTo(nodeAeroDest, Relationships.VUELO_AEROPUERTO_DESTINO)

			unVuelo.asientos.forEach[ asiento |
				var Node nodoAsiento = graphDb.createNode(EntityLabels.ASIENTO)
				nodoAsiento => [
					setProperty("fila", asiento.fila)
					setProperty("ubicacion", asiento.ubicacion)
				]
				createRelationshipTo(nodoAsiento, Relationships.VUELO_ASIENTO)
			]
			
//			setProperty("escalas", unVuelo.escalas)
		]
	}
	
	
}