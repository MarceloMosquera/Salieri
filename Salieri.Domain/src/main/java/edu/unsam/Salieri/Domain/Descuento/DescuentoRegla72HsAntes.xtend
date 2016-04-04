package edu.unsam.Salieri.Domain.Descuento

import edu.unsam.Salieri.Domain.Vuelo
import java.util.Calendar
import java.util.Date

class DescuentoRegla72HsAntes implements IDescuentoRegla {

	override boolean seDebeAplicar(Vuelo vuelo){
		val cal = Calendar.getInstance();
		cal.time = vuelo.fechaSalida
		cal.add(Calendar.DATE, -3);
		val fecha = cal.getTime();
		fecha.before(new Date())
	}
		
}