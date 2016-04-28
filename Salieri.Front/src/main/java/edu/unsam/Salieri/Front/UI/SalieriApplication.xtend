package edu.unsam.Salieri.Front.UI

import edu.unsam.Salieri.HybernateDB.DBContextSql
import edu.unsam.Salieri.Repository.IDBContext
import org.uqbar.arena.Application
import org.uqbar.commons.utils.ApplicationContext

class SalieriApplication extends Application {
	
	static def void main(String[] args) {
		new SalieriApplication(new SalieriBootstrap).start()
	}
	
	override protected createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(IDBContext), new DBContextSql)
		return new LoginWindow(this)
	}
	
	new(SalieriBootstrap bootstrap) {
		super(bootstrap)
	}
	
	
}