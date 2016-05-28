package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Util.SSDate
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
@Entity
class Consulta {
	
	@Id ObjectId id
		
	Date fechaConsulta
	Aeropuerto consultaOrigen
	Aeropuerto consultaDestino
	Date consultaFechaMin
	Date consultaFechaMax
	float consultaMontoMax
	List<VueloConsulta> vuelosConsultados
	Usuario usuarioConsulta
		
	new(VueloBusqueda vueloBusqueda, Usuario usuario){
	fechaConsulta = new Date()
	consultaOrigen = vueloBusqueda.origen
	consultaDestino = vueloBusqueda.destino
	consultaFechaMax = vueloBusqueda.fechaMax
	consultaFechaMin = vueloBusqueda.fechaMin
	consultaMontoMax = vueloBusqueda.montoMax
	vuelosConsultados = new ArrayList()
	convertirVuelos(vueloBusqueda.vuelosConsultados)
	usuarioConsulta = usuario
	}
	
	new(){}
	
	override toString(){
		"fecha consula:" + fechaConsulta.toString 
	}
	
	//TODO: Dejar mas linda esta mierdaaa (si no la necesitamos al final borrarla)
	def void convertirVuelos(List<Vuelo> vuelos){
	val j = vuelos.size
	var int i
	for (i=0; i < j ; i++){
		vuelosConsultados.add(new VueloConsulta(vuelos.get(i)))		
	}
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