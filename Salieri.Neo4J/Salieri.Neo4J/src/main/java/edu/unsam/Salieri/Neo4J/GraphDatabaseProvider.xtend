package edu.unsam.Salieri.Neo4J

import java.io.File
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.factory.GraphDatabaseFactory

@Accessors
class GraphDatabaseProvider {

	static GraphDatabaseProvider instance
	
	GraphDatabaseService graphDb
	
	private new() {
		val GraphDatabaseFactory dbFactory = new GraphDatabaseFactory
		//graphDb = dbFactory.newEmbeddedDatabase(new File("C:\\Users\\Atos\\Documents\\Neo4j\\default.graphdb"))
		graphDb = dbFactory.newEmbeddedDatabase(new File("C:\\1Tools\\Neo4j CE 3.0.3\\DB"))
	}
	
	def static instance() {
		if (instance == null) {
			instance = new GraphDatabaseProvider		
		}
		instance
	}
	 	
}