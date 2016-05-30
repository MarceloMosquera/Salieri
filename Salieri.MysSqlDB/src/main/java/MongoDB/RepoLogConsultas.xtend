package MongoDB

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import java.util.ArrayList
import java.util.Date
import java.util.List

class RepoLogConsultas extends RepoAbstracto<Consulta> implements IRepoLogConsultas {

	override getEntityType() {
		typeof(Consulta)
	}

	override void delete(Consulta consulta) {
		ds.delete(consulta)

	}

	override quitarConsulta(Consulta unaConsulta) {
		delete(unaConsulta)
	}

	override buscarConsultas(Consulta unEjemplo) {
		searchByExample(unEjemplo)
	}

	override agregarConsulta(Consulta unaConsulta) {
		create(unaConsulta)
	}
	



	override searchByExample(Consulta consultaEjemplo) {
		val query = ds.createQuery(Consulta)
		query.field("usuarioConsulta._id").equal(consultaEjemplo.usuarioConsulta.id)
		if (consultaEjemplo.consultaFechaMin != null) {
			query.field("fechaConsulta").greaterThanOrEq(consultaEjemplo.consultaFechaMin)
		}
		if (consultaEjemplo.consultaFechaMin != null) {
			query.field("fechaConsulta").lessThanOrEq(consultaEjemplo.consultaFechaMax)
		}
		query.asList
	}
	
	override defineUpdateOperations(Consulta t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	
	override listarTodas() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	

//	List<Consulta> consultas
//	List<Consulta> resultado
//	new(){
//		consultas = new ArrayList()
//		resultado = new ArrayList()
//	}
//	
//	override agregarConsulta(Consulta unaConsulta) {
//		consultas.add(unaConsulta)	
//	}
//	
//	override quitarConsulta(Consulta unaConsulta) {
//	}
//	
//	override buscarConsultas(Date fechaDesde,Date fechaHasta,Usuario usuarioLog) {
//		resultado = consultas.filter[c|c.usuarioConsulta.equals(usuarioLog)].toList
//		if(fechaDesde != null){
//			resultado = consultas.filter[c|c.fechaConsulta >= fechaDesde].toList
//		}
//		if(fechaHasta != null){
//			resultado = consultas.filter[c|c.fechaConsulta <= fechaHasta].toList
//		}
//		resultado
//		
//	}
//	
//	override listarTodas() {
//		consultas
//	}
}
