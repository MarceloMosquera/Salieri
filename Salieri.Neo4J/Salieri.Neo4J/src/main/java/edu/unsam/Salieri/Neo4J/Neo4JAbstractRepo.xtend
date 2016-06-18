package edu.unsam.Salieri.Neo4J

import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Transaction
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result
import java.util.Iterator

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
	
	
	protected def Node getNodoById(EntityLabels label, Long id) {
		val Result result = graphDb.execute("match (entity:" + label.toString() + ") where ID(entity) = " + id + " return entity")
		val Iterator<Node> entity_column = result.columnAs("entity")
		return entity_column.head
	}

	
	
}