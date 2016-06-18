package edu.unsam.Salieri.Util

import java.text.SimpleDateFormat
import java.util.Date

class SSDate extends Date {
	def static Date p(String fecha){
		new SimpleDateFormat( "yyyyMMdd HH:mm" ).parse( fecha )
	} 
		
	def static String toPersist(Date fecha){
		new SimpleDateFormat( "yyyyMMdd HH:mm" ).format( fecha )
	}
	
	def static String toShow(Date fecha){
		new SimpleDateFormat( "dd/MM/yyyy HH:mm" ).format( fecha )
	}
}