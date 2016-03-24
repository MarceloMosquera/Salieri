package edu.unsam.Salieri.Front.UI

import org.uqbar.arena.Application
import org.uqbar.commons.utils.ApplicationContext
import edu.unsam.Salieri.Repository.IDBContext

class SalieriApplication extends Application {
	
	static def void main(String[] args) {
		new SalieriApplication().start()
	}
	
	override protected createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(IDBContext), new edu.unsam.Salieri.MemoryDB.DBContext)
		return new LoginWindow(this)
	}
	
}