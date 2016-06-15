package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Repository.IRepoReservas
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Transaction

class Neo4JAbstractRepo {
	
	protected	GraphDatabaseService graphDb

	DBContextN4J dbcontext
	
	protected new() {
		dbcontext = new DBContextN4J
		graphDb = GraphDatabaseProvider.instance.graphDb
	}

	protected def void cerrarTransaccion(Transaction transaction) {
		if (transaction != null) {
			transaction.close
		}
	}
	
	
	
}