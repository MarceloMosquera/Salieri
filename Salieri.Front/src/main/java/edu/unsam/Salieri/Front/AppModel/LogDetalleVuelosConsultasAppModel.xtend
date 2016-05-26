package edu.unsam.Salieri.Front.AppModel

import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Util.SSDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LogDetalleVuelosConsultasAppModel extends BaseAppModel {
	Consulta consultaSeleccionada
	
	new (Consulta laConsultaSeleccionada){
		consultaSeleccionada = laConsultaSeleccionada
	}
	
	
}