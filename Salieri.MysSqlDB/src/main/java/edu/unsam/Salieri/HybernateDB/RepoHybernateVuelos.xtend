package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Vuelo
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoHybernateVuelos extends RepoHybernateBase<Vuelo> {

	override getEntityType() {
		typeof(Vuelo)
	}

	override addQueryByExample(Criteria criteria, Vuelo vuelo) {
		if (vuelo.nroVuelo != null) {
			criteria.add(Restrictions.eq("nombre", vuelo.nroVuelo))
		}
	}

}
