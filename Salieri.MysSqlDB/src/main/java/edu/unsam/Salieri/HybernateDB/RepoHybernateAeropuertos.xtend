package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

class RepoHybernateAeropuertos extends RepoHybernateBase<Aeropuerto> implements IRepoAeropuertos {

	override getEntityType() {
		typeof(Aeropuerto)
	}

	override addQueryByExample(Criteria criteria, Aeropuerto aeropuerto) {
		if (aeropuerto.nombre != null) {
			criteria.add(Restrictions.eq("nombre", aeropuerto.nombre))
		}
	}

	override agregarAeropuerto(Aeropuerto unAeropuerto) {
		create(unAeropuerto)
	}
//TODO: implementar
	override quitarAeropuerto(Aeropuerto unAeropuerto) {
	
	}

	override List<Aeropuerto> todos() {
		allInstances
	}

	override List<Aeropuerto> todosSinVacio() {
		//TODO: Implemetntar todosSinVacio
	}

	override Aeropuerto buscarAeropuertoPorNombre(String aeropuertoNombre) {
				val aeropuertoEjemplo =new Aeropuerto(aeropuertoNombre,"","")
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, aeropuertoEjemplo)
			return criteria.list().head
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

}
