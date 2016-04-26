package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Reserva
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException
import org.hibernate.FetchMode

class RepoHybernateReservas extends RepoHybernateBase<Reserva> {

	override getEntityType() {
		typeof(Reserva)
	}

	// Marce, este comentario es porque no se que hace este metodo en la reserva
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
