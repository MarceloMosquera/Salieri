package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Reserva
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class PrincipalAppModel extends BaseAppModel{

	Reserva reservaSeleccionada = null
	
	new() {
	}
	
	def List<Reserva> reservasEfectuadas(){
		this.DBContext().repoReservas.buscarReservaDelUsuario(usuarioLogueado())
	}

@Dependencies("reservasEfectuadas,reservaSeleccionada")
	def void cancelarReserva(){
		this.DBContext().repoReservas.quitarReserva(reservaSeleccionada)
		reservaSeleccionada = null
		ObservableUtils.firePropertyChanged(this, "reservasEfectuadas", reservasEfectuadas())
	}
	
    

@Dependencies("reservasEfectuadas,reservaSeleccionada")
	def void actualizarLista(){
		ObservableUtils.firePropertyChanged(this, "reservasEfectuadas", reservasEfectuadas())
	}
	
	
}
