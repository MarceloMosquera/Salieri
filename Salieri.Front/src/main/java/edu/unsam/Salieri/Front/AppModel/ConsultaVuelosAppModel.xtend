package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import java.util.ArrayList
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
	List<Vuelo> vuelosEncontrados = new ArrayList<Vuelo>
	Vuelo vueloSeleccionado = null

	def List<Aeropuerto> aeropuertosOrigen() {
		this.DBContext().repoAeropuertos.todos()
	}

	def List<Aeropuerto> aeropuertosDestino() {
		this.DBContext().repoAeropuertos.todos()
	}

	// TODO: no funciona origen y destino
	def buscar() {
		vuelosEncontrados = null
		vuelosEncontrados = vueloBusqueda.buscarVuelos(this.DBContext().repoVuelos.todos())
	}

	@Dependencies("vuelosEncontrados")
	def void actualizarLista() {
		ObservableUtils.firePropertyChanged(this, "vuelosEncontrados", buscar())
		ObservableUtils.firePropertyChanged(this, "vueloSeleccionado", getVueloSeleccionado())
	}


}
