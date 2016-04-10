package edu.unsam.Salieri.Domain

import org.junit.Assert
import org.junit.Test

class TestAeropuerto {
	
	@Test
	def void testPropiedades() {
		val aero = new Aeropuerto("EZE", "BSAS", "ARG")
		Assert.assertEquals("EZE", aero.nombre)
		Assert.assertEquals("BSAS", aero.ciudad)
		Assert.assertEquals("ARG", aero.pais)
	}
	
	@Test
	def void testToString() {
		val aero = new Aeropuerto("EZE", "BSAS", "ARG")
		Assert.assertEquals("EZE", aero.toString)
	}
	
	@Test
	def void testMismoNombre() {
		val aero = new Aeropuerto("EZE", "BSAS", "ARG")
		Assert.assertTrue(aero.mismoNombre("EZE"))
		Assert.assertFalse(aero.mismoNombre("OTRO"))
	}	
}