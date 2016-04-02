package edu.unsam.Salieri.Domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class VueloBusqueda {
 	Aeropuerto origen
 	Aeropuerto destino
 	Date fechaMin
 	Date fechaMax
 	float montoMax 	
 	new ()
 	{
//		fechaMin = new SimpleDateFormat( "yyyyMMdd" ).parse( "20160101" )
//		fechaMax = new SimpleDateFormat( "yyyyMMdd" ).parse( "20161231" )
//		montoMax = 1000000
 	}
}