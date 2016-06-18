package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Util.SSDate
import java.util.Iterator
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import org.neo4j.kernel.api.proc.Neo4jTypes.RelationshipType
import edu.unsam.Salieri.Domain.Asiento
import java.util.ArrayList
import org.neo4j.graphdb.Relationship
import java.util.HashSet
import edu.unsam.Salieri.Domain.Escala
import edu.unsam.Salieri.Domain.TarifaEspecial
import edu.unsam.Salieri.Domain.TarifaBandaNegativa
import edu.unsam.Salieri.Domain.TarifaComun

class RepoNeo4JVuelos  extends Neo4JAbstractRepo implements IRepoVuelos {
	
	override void agregarVuelo(Vuelo unVuelo) {
		val transaction = graphDb.beginTx
		try {
			
			var Node nodoVuelo = null
			if (unVuelo.id == null) {
				nodoVuelo = graphDb.createNode(EntityLabels.VUELO)
			} else {
				nodoVuelo = getNodoById(EntityLabels.VUELO, unVuelo.id)
			}
			convertToNode(unVuelo, nodoVuelo)
			transaction.success
			unVuelo.id = nodoVuelo.id
		} finally {
			cerrarTransaccion(transaction)
		}
		
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
//		
//		
//			addRestrictionIfNotNull(c, "origen", unBusqueda.origen)
//			addRestrictionIfNotNull(c, "destino", unBusqueda.destino)
//			addRestrictionIfNotNullDate(c, "fechaSalida", unBusqueda.fechaMin, unBusqueda.fechaMax)
//			addRestrictionIfNot0(c, "tarifaDefault", unBusqueda.montoMax)
//			c.createAlias("asientos", "asientos").add(Restrictions.eq("asientos.disponible", true))
		basicSearch("").map[node|convertToVuelo(node)].toList
	}

	
	def convertToVuelo(Node nodeVuelo) {
		val repoAero = new RepoNeo4JAeropuertos
				
		new Vuelo => [
			id = nodeVuelo.id
			nroVuelo = nodeVuelo.getProperty("nroVuelo") as String
			aerolinea = nodeVuelo.getProperty("aerolinea") as String
			fechaSalida =  SSDate.p(nodeVuelo.getProperty("fechaSalida") as String)
			fechaArribo = SSDate.p(nodeVuelo.getProperty("fechaArribo") as String)
			tarifaDefault = nodeVuelo.getProperty("tarifaDefault") as Float
			
			val relOrigen = nodeVuelo.getRelationships(Relationships.VUELO_AEROPUERTO_ORIGEN)
			origen = repoAero.convertToAeropuerto( relOrigen.last.endNode)

			val relDestino = nodeVuelo.getRelationships(Relationships.VUELO_AEROPUERTO_DESTINO)
			destino = repoAero.convertToAeropuerto( relDestino.last.endNode)

			val relAsientos = nodeVuelo.getRelationships(Relationships.VUELO_ASIENTO)
			asientos = new ArrayList
			relAsientos.forEach[rel | 
				asientos.add(convertToAsiento(rel.endNode, it))
			]
			
			val relEscalas = nodeVuelo.getRelationships(Relationships.VUELO_AEROPUERTO_ESCALA)
			escalas = new HashSet
			relEscalas.forEach[rel | 
				escalas.add(convertToEscala(rel))
			]

		]
	}
	
	def convertToNode(Vuelo unVuelo, Node nodeVuelo) {

		nodeVuelo => [
			setProperty("nroVuelo", unVuelo.nroVuelo)
			setProperty("aerolinea", unVuelo.aerolinea)
			setProperty("fechaSalida", SSDate.toPersist(unVuelo.fechaSalida))
			setProperty("fechaArribo", SSDate.toPersist(unVuelo.fechaArribo))
			setProperty("tarifaDefault", unVuelo.tarifaDefault)

			val nodeAeroOrig = getNodoById(EntityLabels.AEROPUERTO, unVuelo.origen.id)
			createRelationshipTo(nodeAeroOrig, Relationships.VUELO_AEROPUERTO_ORIGEN)

			val nodeAeroDest = getNodoById(EntityLabels.AEROPUERTO, unVuelo.destino.id)
			createRelationshipTo(nodeAeroDest, Relationships.VUELO_AEROPUERTO_DESTINO)

			unVuelo.asientos.forEach[ asiento |
				var Node nodoAsiento = graphDb.createNode(EntityLabels.ASIENTO)
				nodoAsiento => [
					setProperty("fila", asiento.fila)
					setProperty("ubicacion", asiento.ubicacion)
					//setProperty("tarifa", asiento.tarifa)
					setProperty("disponible", asiento.disponible)
				]
				createRelationshipTo(nodoAsiento, Relationships.VUELO_ASIENTO)
				asiento.id = nodoAsiento.id
				var Node nodoTarifa = graphDb.createNode(EntityLabels.TARIFA)
				nodoTarifa.setProperty("tipo", asiento.tarifa.tipo)
				nodoAsiento.createRelationshipTo(nodoTarifa, Relationships.ASIENTO_TARIFA)
			]
			
			unVuelo.escalas.forEach[ escala |
				var Node nodoAerop = getNodoById(EntityLabels.AEROPUERTO, escala.aeropuerto.id)
				var rel = createRelationshipTo(nodoAerop, Relationships.VUELO_AEROPUERTO_ESCALA)
				rel.setProperty("orden", escala.orden)
				rel.setProperty("fechaSalida", SSDate.toPersist(escala.fechaSalida))
				rel.setProperty("fechaLlegada", SSDate.toPersist(escala.fechaLlegada))
				escala.id = rel.id
			]
		]
	}

	def convertToAsiento(Node nodo, Vuelo unVuelo)	{
		new Asiento => [
			id = nodo.id
			fila = nodo.getProperty("fila") as Integer
			ubicacion = nodo.getProperty("ubicacion") as Integer
			//tarifa = nodo.getProperty("tarifa") as Float
			disponible = nodo.getProperty("disponible") as Boolean
			vuelo = unVuelo
			val relTarifa = nodo.getRelationships(Relationships.ASIENTO_TARIFA).head
			var Node nodoTarifa = relTarifa.endNode
			var tipo = nodoTarifa.getProperty("tipo") as Integer 
			if (tipo == 1) tarifa = new TarifaEspecial(100)
			if (tipo == 2) tarifa = new TarifaBandaNegativa()
			if (tipo == 3) tarifa = new TarifaComun()
		]
	}	
	def convertToEscala(Relationship rel)	{
		val repoAero = new RepoNeo4JAeropuertos
		
		new Escala => [
			id = rel.id
			orden = rel.getProperty("orden") as Integer 
			aeropuerto = repoAero.convertToAeropuerto(rel.endNode)
			fechaSalida = SSDate.p(rel.getProperty("fechaSalida") as String)
			fechaLlegada = SSDate.p(rel.getProperty("fechaLlegada") as String)
		]
	}	
	
}