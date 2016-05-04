package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoVuelos
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoHybernateVuelos extends RepoHybernateBase<Vuelo> implements IRepoVuelos {

	override getEntityType() {
		typeof(Vuelo)
	}

	override addQueryByExample(Criteria criteria, Vuelo vuelo) {
		if (vuelo.nroVuelo != null) {
			criteria.add(Restrictions.eq("nombre", vuelo.nroVuelo))
		}
	}
	
	override agregarVuelo(Vuelo unVuelo) {
		create(unVuelo)
	}
	
	override quitarVuelo(Vuelo unVuelo) {
	//TODO:Implementar quitar vuelo
	}
	
	override todos() {
	allInstances.toList
	}

}
