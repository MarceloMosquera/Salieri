package edu.unsam.Salieri.HybernateDB

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoUsuarios
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException

class RepoHybernateUsuarios extends RepoHybernateBase<Usuario> implements IRepoUsuarios{
	
	override getEntityType() {
		typeof(Usuario)
	}
	
	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.nombre != null) {
			criteria.add(Restrictions.eq("nombre", usuario.nombre))
		}
	}
	
	
	override agregarUsuarioConContraseña(Usuario usuario, String contrasenia) {
		usuario.password = contrasenia
		this.create(usuario)
	}
	
	override quitarUsuario(Usuario usuario) {
	//TODO: cuando se saca el usuario hay que borrar sus reservas??
	}
	
	override obtenerUsuario(String nombre) {
		val usuarioEjemplo =new Usuario(nombre)
		val session = openSession
		try {
			session.createCriteria(getEntityType)
			.add(Restrictions.eq("nombre", usuarioEjemplo.nombre)).
				uniqueResult as Usuario
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
}