package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Reserva
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class PrincipalAppModel extends BaseAppModel{

	Reserva reservaSeleccionada = null
	
	new() {
	}
	
	def List<Reserva> reservasEfectuadas(){
		this.DBContext().repoReservas.buscarReservaDelUsuario(usuarioLogeado())
	}
	
}
