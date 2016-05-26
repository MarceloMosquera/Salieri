package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Util.SSDate
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Consulta {
	
	Date fechaConsulta
	Aeropuerto consultaOrigen
	Aeropuerto consultaDestino
	Date consultaFechaMin
	Date consultaFechaMax
	float consultaMontoMax
	List<Vuelo> vuelosConsultados
	Usuario usuarioConsulta
		
	new(VueloBusqueda vueloBusqueda, Usuario usuario){
	fechaConsulta = new Date()
	consultaOrigen = vueloBusqueda.origen
	consultaDestino = vueloBusqueda.destino
	consultaFechaMax = vueloBusqueda.fechaMax
	consultaFechaMin = vueloBusqueda.fechaMin
	consultaMontoMax = vueloBusqueda.montoMax
	vuelosConsultados = vueloBusqueda.vuelosConsultados
	usuarioConsulta = usuario
	
	println(this.toString)
	}
	
	override toString(){
		"fecha consula:" + fechaConsulta.toString// + ", usuario:" usuarioConsulta.nombre + ", destino: " + consultaDestino.nombre 
	}
	
	//asi me olvido del ", "
	def String agregarEnListaString(String nuevoValor, String todosLosValores){
		var todo = todosLosValores//uso una auxiliar porque no me deja modificar el valor de la variable todosLosValores
		if(nuevoValor!=""){
			if(todo!=""){
				todo += ", "
			}
			todo += nuevoValor
		}
		todo 
	}
	
	def criterio(){
		var String total = ""
		
		if(consultaOrigen != null && consultaOrigen.nombre!="")
			total = agregarEnListaString("origen: " + consultaOrigen.nombre,total)
			
		if(consultaDestino != null && consultaDestino.nombre!="")
			total = agregarEnListaString("destino: " + consultaDestino.nombre,total)
			
		if(consultaFechaMin != null)
			total = agregarEnListaString("desde: " + SSDate.toShow(consultaFechaMin),total)
		
		if(consultaFechaMax != null)
			total = agregarEnListaString("hasta: " + SSDate.toShow(consultaFechaMax),total)
		
		if(consultaMontoMax >0)
			total = agregarEnListaString("monto maximo: $ " + consultaMontoMax,total)

		total
	}
	
	def fechaConsultaMejorada(){
		SSDate.toShow(fechaConsulta)
	}
}