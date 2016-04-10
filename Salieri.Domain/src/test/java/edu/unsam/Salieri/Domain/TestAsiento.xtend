package edu.unsam.Salieri.Domain

import org.junit.Assert
import org.junit.Test

class TestAsiento {
	
	@Test
	def void testToString() {
		val asiento = new Asiento (1, 0)
		Assert.assertEquals("2P", asiento.toString)
	}
	
	@Test
	def void testEstaDisponible() {
		val asiento = new Asiento (1, 0)
		Assert.assertTrue( asiento.estaDisponible())
	}
	
	@Test
	def void testReservar() {
		val asiento = new Asiento (1, 0)
		Assert.assertTrue( asiento.estaDisponible())
		asiento.reservar()
		Assert.assertFalse( asiento.estaDisponible())
	}
	
	
}