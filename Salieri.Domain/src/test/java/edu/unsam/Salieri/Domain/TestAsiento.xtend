package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Util.SSDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestAsiento {
	
	Vuelo f666
	Aeropuerto 	ezeiza
	Aeropuerto 	marDelPlata
	Aeropuerto 	mendoza
	
	@Before
	def void init() {
		ezeiza = new Aeropuerto("Ezeiza (EZE)", "Buenos Aires", "Argentina")
		marDelPlata = new Aeropuerto("Mar del Plata (MDQ)", "Buenos Aires", "Argentina")
		mendoza = new Aeropuerto("Mendoza (MDZ)", "Mendoza", "Argentina")
		
		f666 = new Vuelo("F666", "Maiden Ar", ezeiza, mendoza, 
			SSDate.p("20160320 8:15" ), SSDate.p("20160321 20:00" ) , 3000)
			
		f666 => [
			agregarEscala(
				new Escala(marDelPlata, 
				SSDate.p("20160320 13:00" ),SSDate.p("20160320 13:30" )  
			))
		]
		
//		f666.tarifa.agregarDescuento(
//			new Descuento(
//				new DescuentoRegla72HsAntes(), 
//				new DescuentoPorcentaje(0.20f)
//			)
//		)
	}
	
	@Test
	def void testToString() {
		val asiento = f666.obtenerAsiento(2, 0)
		Assert.assertEquals("2P", asiento.toString)
	}
	
	@Test
	def void testEstaDisponible() {
		val asiento = f666.obtenerAsiento(2, 0)
		Assert.assertTrue( asiento.estaDisponible())
	}
	
	@Test
	def void testReservar() {
		val asiento = f666.obtenerAsiento(2, 0)
		Assert.assertTrue( asiento.estaDisponible())
		asiento.reservar()
		Assert.assertFalse( asiento.estaDisponible())
	}
	
	
}