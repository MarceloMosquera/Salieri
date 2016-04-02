package edu.unsam.Salieri.Util

import java.text.SimpleDateFormat
import java.util.Date

class SSDate extends Date {
	def static Date p(String fecha){
		new SimpleDateFormat( "yyyyMMdd HH:mm" ).parse( fecha )
	} 
}