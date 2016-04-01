package edu.unsam.Salieri.Front.AppModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Reserva
import java.util.List
import edu.unsam.Salieri.Domain.Asiento
import java.util.Date
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.Aeropuerto

@Accessors
@Observable
class PrincipalAppModel extends BaseAppModel{

	Reserva reservaSeleccionada = null
	
	new() {
	}
	
}
