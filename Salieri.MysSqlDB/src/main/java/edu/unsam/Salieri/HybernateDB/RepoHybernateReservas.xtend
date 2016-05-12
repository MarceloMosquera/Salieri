package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoReservas
import java.util.List
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import edu.unsam.Salieri.Util.SSDate
import java.util.Date

class RepoHybernateReservas extends RepoHybernateBase<Reserva> implements IRepoReservas {

	override getEntityType() {
		typeof(Reserva)
	}

	override addQueryByExample(Criteria criteria, Reserva reserva) {
	}

	def Reserva searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(Reserva).setFetchMode("usuario", FetchMode.SELECT).add(Restrictions.eq("id", id)).
				uniqueResult as Reserva
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	override void agregarReserva(Reserva unaReserva) {
		create(unaReserva)
	}

	override void quitarReserva(Reserva unaReserva) {
		unaReserva.cancelar()
		update(unaReserva)
	}

	override List<Reserva> buscarReservaDelUsuario(Usuario unUsuario) {
		val session = openSession
		try {
			session.createCriteria(Reserva)
				.setFetchMode("vuelo", FetchMode.JOIN)
				.add(Restrictions.eq("usuario.id", unUsuario.id))
				.add(Restrictions.isNull("fechaBaja"))
				.list

		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

}
