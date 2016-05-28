package edu.unsam.Salieri.Domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ConsultaEjemplo {
	Date fechaDesde
	Date fechaHasta
	Usuario usuario
	
	new(Date fechaMin, Date fechaMax, Usuario usuarioNew){
		usuario = usuarioNew
		fechaDesde = fechaMin
		fechaHasta = fechaMax
	}

}