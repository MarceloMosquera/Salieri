package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Repository.IDBContext
import org.uqbar.commons.utils.ApplicationContext

class BaseAppModel {
	def IDBContext DBContext() {
    	ApplicationContext.instance.getSingleton(typeof(IDBContext))
	}
	
}