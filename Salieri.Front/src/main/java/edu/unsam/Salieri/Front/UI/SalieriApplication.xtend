package edu.unsam.Salieri.Front.UI

//import edu.unsam.Salieri.HybernateDB.DBContextSql
import edu.unsam.Salieri.Repository.IDBContext
import org.uqbar.arena.Application
import org.uqbar.commons.utils.ApplicationContext
import edu.unsam.Salieri.Neo4J.DBContextN4J

class SalieriApplication extends Application {
	
	static def void main(String[] args) {
		new SalieriApplication(new SalieriBootstrap).start()
	}
	
	override protected createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(IDBContext), DBContextN4J.instance)
		return new LoginWindow(this)
	}
	
	new(SalieriBootstrap bootstrap) {
		super(bootstrap)
	}
	
	
}