package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator
import org.neo4j.graphdb.Label
import java.util.Date

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
			nodoVuelo = convertToNode(unVuelo, nodoVuelo)
			
			transaction.success
			unVuelo.id = nodoVuelo.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	private def Node getNodoVuelo(Long id) {
		basicSearch("ID(vuelo) = " + id).head
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (vuelo:Vuelo)" + where + " return vuelo")
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
			fechaSalida = nodeVuelo.getProperty("fechaSalida") as Date
			fechaArribo = nodeVuelo.getProperty("fechaArribo") as Date
			//List<Asiento> asientos
			//Set<Escala> escalas
			tarifaDefault = nodeVuelo.getProperty("tarifaDefault") as Float
		]
	}
	
	def convertToNode(Vuelo unVuelo, Node nodeVuelo) {
		nodeVuelo => [
			setProperty("nroVuelo", unVuelo.nroVuelo)
			setProperty("aerolinea", unVuelo.aerolinea)
			val repoAero = new RepoNeo4JAeropuertos
			val nodeAeroOrig = repoAero.getNodoAeropuerto(unVuelo.id)
			val relAeropuertoOrigen = nodeVuelo.createRelationshipTo(nodeAeroOrig, Relationships.VUELO_AEROPUERTO_ORIGEN)
				
//			setProperty("origen", unVuelo.origen)
//			setProperty("destino", unVuelo.destino)
			setProperty("fechaSalida", unVuelo.fechaSalida)
			setProperty("fechaArribo", unVuelo.fechaArribo)
//			setProperty("asientos", unVuelo.asientos)
//			setProperty("escalas", unVuelo.escalas)
			setProperty("tarifaDefault", unVuelo.tarifaDefault)
		]
	}
	
}