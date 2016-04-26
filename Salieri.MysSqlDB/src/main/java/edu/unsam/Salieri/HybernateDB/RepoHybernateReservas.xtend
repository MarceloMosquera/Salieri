package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Reserva
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

class RepoHybernateReservas extends RepoHybernateBase<Reserva> {

	override getEntityType() {
		typeof(Reserva)
	}

	//TODO : ver como implementar esta query
	override addQueryByExample(Criteria criteria, Reserva reserva) {
	}
	
		def Reserva searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(Reserva)
				.setFetchMode("usuario", FetchMode.JOIN)
				.add(Restrictions.eq("id", id))
				.uniqueResult as Reserva
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

}
