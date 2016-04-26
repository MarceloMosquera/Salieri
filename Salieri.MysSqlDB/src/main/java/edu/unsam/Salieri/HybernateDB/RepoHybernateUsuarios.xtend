package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Usuario
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoHybernateUsuarios extends RepoHybernateBase<Usuario> {
	
	override getEntityType() {
		typeof(Usuario)
	}
	
	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.nombre != null) {
			criteria.add(Restrictions.eq("nombre", usuario.nombre))
		}
	}
	
}