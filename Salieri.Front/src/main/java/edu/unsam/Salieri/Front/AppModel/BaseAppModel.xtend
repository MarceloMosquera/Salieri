package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IDBContext
import org.uqbar.commons.utils.ApplicationContext

class BaseAppModel {
	def IDBContext DBContext() {
    	ApplicationContext.instance.getSingleton(typeof(IDBContext))
	}
	
	def Usuario usuarioLogueado() {
    	ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
}