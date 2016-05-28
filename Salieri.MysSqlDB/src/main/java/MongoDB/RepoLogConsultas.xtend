package MongoDB

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Repository.IRepoLogConsultas
import java.util.ArrayList
import java.util.Date
import java.util.List

class RepoLogConsultas implements IRepoLogConsultas {
//
//	extends RepoAbstractoConsulta<Consulta> 
//	override getEntityType() {
//		typeof(Consulta)
//	}
//
//	def void delete(Consulta consulta) {
//		ds.delete(consulta)
//
//	}
//
//	override quitarConsulta(Consulta unaConsulta) {
//		delete(unaConsulta)
//	}
//
//	override buscarConsultas(Date fechaMin, Date fechaMax, Usuario usuario) {
//		var consultaEjemplo = new ConsultaEjemplo(fechaMin, fechaMax, usuario)
//		searchByExample(consultaEjemplo)
//
//	}
//
//	override agregarConsulta(Consulta unaConsulta) {
//		create(unaConsulta)
//	}
//	
//	def create(Consulta consulta) {
//		val obj = despejarCampos(consulta)
//		ds.save(consulta)
//		consulta
//	}
//
//	override listarTodas() {
//	}
//
//	def searchByExample(ConsultaEjemplo consultaEjemplo) {
//		val query = ds.createQuery(Consulta)
//		query.field("usuario").equal(consultaEjemplo.usuario)
//		if (consultaEjemplo.fechaDesde != null) {
//			query.field("fechaConsulta").greaterThanOrEq(consultaEjemplo.fechaDesde)
//		}
//		if (consultaEjemplo.fechaHasta != null) {
//			query.field("fechaConsulta").lessThanOrEq(consultaEjemplo.fechaHasta)
//		}
//		query.asList
//	}
//	

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
			resultado = consultas.filter[c|c.fechaConsulta >= fechaDesde].toList
		}
		if(fechaHasta != null){
			resultado = consultas.filter[c|c.fechaConsulta <= fechaHasta].toList
		}
		resultado
		
	}
	
	override listarTodas() {
		consultas
	}
}
