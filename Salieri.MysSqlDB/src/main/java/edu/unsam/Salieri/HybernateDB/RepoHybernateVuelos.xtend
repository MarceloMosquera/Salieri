package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import edu.unsam.Salieri.Repository.IRepoVuelos
import java.util.Date
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.criterion.CriteriaSpecification
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
	}

	override todos() {
		allInstances.toList
	}

	override List<Vuelo> buscar(VueloBusqueda unBusqueda) {
		val session = openSession
		try {
			var c = session.createCriteria(getEntityType)

			addRestrictionIfNotNull(c, "origen", unBusqueda.origen)
			addRestrictionIfNotNull(c, "destino", unBusqueda.destino)
			addRestrictionIfNotNullDate(c, "fechaSalida", unBusqueda.fechaMin, unBusqueda.fechaMax)
			addRestrictionIfNot0(c, "tarifaDefault", unBusqueda.montoMax)
			c.createAlias("asientos", "asientos").add(Restrictions.eq("asientos.disponible", true))
			c.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)

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

	def addRestrictionIfNotNullDate(Criteria criteria, String propertyName, Date fechaMin, Date fechaMax) {
		if (fechaMin != null) {
			criteria.add(Restrictions.ge(propertyName, fechaMin));
		}
		if (fechaMax != null) {
			criteria.add(Restrictions.le(propertyName, fechaMax));
		}
	}

	def addRestrictionIfNot0(Criteria criteria, String propertyName, Float value) {
		if (value > 0) {
			criteria.add(Restrictions.ge(propertyName, value));
		}
	}
}
