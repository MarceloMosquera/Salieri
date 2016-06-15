package edu.unsam.Salieri.Neo4J;

import org.neo4j.graphdb.RelationshipType;

public enum Relationships implements RelationshipType {

	VUELO_AEROPUERTO_ORIGEN, VUELO_AEROPUERTO_DESTINO, RESERVA
	
}
