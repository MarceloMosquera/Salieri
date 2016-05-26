package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Consulta
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class LogConsultasAppModel extends BaseAppModel {

	Date fechaDesde
	Date fechaHasta
	List<Consulta> consultas
	
	Consulta consultaSeleccionada = null
	
	new() {
		fechaDesde = null
		fechaHasta = null
	}

//	def List<Consulta> consultas (){
//		this.DBContext().repoLogConsultas.listarTodas
//	}
		
	def void buscar(){
		consultas = this.DBContext().repoLogConsultas.buscarConsultas(fechaDesde, fechaHasta, usuarioLogueado)
	}	
}