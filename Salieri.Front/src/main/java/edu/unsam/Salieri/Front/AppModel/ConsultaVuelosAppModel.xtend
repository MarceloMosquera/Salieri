package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class ConsultaVuelosAppModel extends BaseAppModel {

	String mensaje
	VueloBusqueda vueloBusqueda = new VueloBusqueda
	Vuelo vueloSeleccionado = null
	List<Vuelo> vuelosEncontrados = null

	def List<Aeropuerto> aeropuertosOrigen() {
		this.DBContext().repoAeropuertos.todos()
	}

	def List<Aeropuerto> aeropuertosDestino() {
		this.DBContext().repoAeropuertos.todos()
	}

	def buscar() {
		vueloBusqueda.vuelosConsultados =  DBContext.repoVuelos.buscar(vueloBusqueda)
		guardarConsulta(vueloBusqueda,usuarioLogueado)
		vuelosEncontrados = vueloBusqueda.vuelosConsultados
	}
	
	def buscarSinConsulta() {
		vueloBusqueda.vuelosConsultados = DBContext.repoVuelos.buscar(vueloBusqueda)
		vuelosEncontrados = vueloBusqueda.vuelosConsultados
	}

	@Dependencies("vuelosEncontrados")
	def actualizarLista() {
		ObservableUtils.firePropertyChanged(this, "vuelosEncontrados", buscarSinConsulta())
		ObservableUtils.firePropertyChanged(this, "vueloSeleccionado", getVueloSeleccionado())
	}

	def guardarConsulta(VueloBusqueda vueloBusqueda,Usuario usuario){
		this.DBContext().repoLogConsultas.agregarConsulta(new Consulta(vueloBusqueda,usuario))
	}

}
