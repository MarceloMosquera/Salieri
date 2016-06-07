package edu.unsam.Salieri.Neo4J

import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda

class RepoNeo4JVuelos  extends Neo4JAbstractRepo implements IRepoVuelos {
	
	override agregarVuelo(Vuelo unVuelo) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override quitarVuelo(Vuelo unVuelo) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override todos() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override buscar(VueloBusqueda unBusqueda) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}