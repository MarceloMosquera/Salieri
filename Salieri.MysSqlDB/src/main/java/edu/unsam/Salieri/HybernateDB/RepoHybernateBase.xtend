package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Aerolinea
import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Asiento
import edu.unsam.Salieri.Domain.Escala
import edu.unsam.Salieri.Domain.ITarifa
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.TarifaBandaNegativa
import edu.unsam.Salieri.Domain.TarifaComun
import edu.unsam.Salieri.Domain.TarifaEspecial
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.AnnotationConfiguration

abstract class RepoHybernateBase<T> {
	
	protected static final SessionFactory sessionFactory = new AnnotationConfiguration().configure()
		.addAnnotatedClass(Aerolinea)
		.addAnnotatedClass(Aeropuerto)
		.addAnnotatedClass(Vuelo)
		.addAnnotatedClass(Asiento)
		.addAnnotatedClass(Escala)
		.addAnnotatedClass(Reserva)
		.addAnnotatedClass(ITarifa)
		.addAnnotatedClass(TarifaEspecial)
		.addAnnotatedClass(TarifaBandaNegativa)
		.addAnnotatedClass(TarifaComun)
		
		.addAnnotatedClass(Usuario)
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
//	def createIfNotExist(T t){
//		val todos= allInstances
//		if(!todos.contains(t)){
//			create(t)	
//		}
//	}
	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}


	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def openSession() {
		sessionFactory.openSession
	}
}