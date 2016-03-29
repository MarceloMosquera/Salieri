package edu.unsam.Salieri.Domain

import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class VueloBusqueda {
 	String origen
 	String destino
 	Date fechaMin
 	Date fechaMax
 	float montoMax 	
}