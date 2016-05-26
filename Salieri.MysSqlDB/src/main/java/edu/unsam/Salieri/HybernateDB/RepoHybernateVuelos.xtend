package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IRepoVuelos
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import java.util.List
import edu.unsam.Salieri.Domain.VueloBusqueda
import org.hibernate.HibernateException
import org.hibernate.FetchMode

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
	}
	
	override todos() {
	allInstances.toList
	}

	override List<Vuelo> buscar(VueloBusqueda unBusqueda)
	{
		val session = openSession
		try {
			var c = session.createCriteria(getEntityType)
			addRestrictionIfNotNull(c, "origen", unBusqueda.origen )
			addRestrictionIfNotNull(c,"destino", unBusqueda.destino )
			addRestrictionIfNotNull(c,"fechaSalida", unBusqueda.fechaMin )
			addRestrictionIfNotNull(c,"fechaSalida", unBusqueda.fechaMax )
			
//			c.createAlias("asientos", "asientoss") //.setFetchMode("asientos", FetchMode.JOIN)
//                .add(Restrictions.eq("asientoss.disponible", true));        
//			
			c.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def addRestrictionIfNotNull(Criteria criteria, String propertyName, Object value) {
	    if (value != null) {
	        criteria.add(Restrictions.eq(propertyName, value));
	    }
	}
}
