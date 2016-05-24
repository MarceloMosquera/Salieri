package MongoDB

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import java.util.ArrayList
import java.util.List

class RepoLogConsultas implements IRepoLogConsultas {
	
	List<Consulta> consultas
	
	new(){
		consultas = new ArrayList()
	}
	
	override agregarConsulta(Consulta unaConsulta) {
		consultas.add(unaConsulta)	
	}
	
	override quitarConsulta(Consulta unaConsulta) {
	}
	
	override buscarConsultas() {
	}
	
}