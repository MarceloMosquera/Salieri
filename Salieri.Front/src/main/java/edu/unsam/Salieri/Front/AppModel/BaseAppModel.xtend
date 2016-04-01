package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Repository.IDBContext
import org.uqbar.commons.utils.ApplicationContext
import edu.unsam.Salieri.Domain.Usuario

class BaseAppModel {
	def IDBContext DBContext() {
    	ApplicationContext.instance.getSingleton(typeof(IDBContext))
	}
	
	def Usuario usuarioLogeado() {
    	ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	
}