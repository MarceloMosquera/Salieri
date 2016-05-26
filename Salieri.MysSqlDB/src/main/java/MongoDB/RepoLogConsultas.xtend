package MongoDB

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import java.util.ArrayList
import java.util.Date
import java.util.List

class RepoLogConsultas implements IRepoLogConsultas {
	
	List<Consulta> consultas
	List<Consulta> resultado
	new(){
		consultas = new ArrayList()
		resultado = new ArrayList()
	}
	
	override agregarConsulta(Consulta unaConsulta) {
		consultas.add(unaConsulta)	
	}
	
	override quitarConsulta(Consulta unaConsulta) {
	}
	
	override buscarConsultas(Date fechaDesde,Date fechaHasta,Usuario usuarioLog) {
		resultado = consultas.filter[c|c.usuarioConsulta.equals(usuarioLog)].toList
		if(fechaDesde != null){
			resultado = consultas.filter[c|c.fechaConsulta > fechaDesde].toList
		}
		if(fechaHasta != null){
			resultado = consultas.filter[c|c.fechaConsulta < fechaHasta].toList
		}
		resultado
		
	}
	
	override listarTodas() {
		consultas
	}
	
}