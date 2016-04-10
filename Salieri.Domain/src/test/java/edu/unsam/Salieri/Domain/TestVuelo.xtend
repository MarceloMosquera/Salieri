package edu.unsam.Salieri.Domain

import edu.unsam.Salieri.Domain.Descuento.Descuento
import edu.unsam.Salieri.Domain.Descuento.DescuentoPorcentaje
import edu.unsam.Salieri.Domain.Descuento.DescuentoRegla72HsAntes
import edu.unsam.Salieri.Util.SSDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestVuelo {

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
		
		f666.tarifa.agregarDescuento(
			new Descuento(
				new DescuentoRegla72HsAntes(), 
				new DescuentoPorcentaje(0.20f)
			)
		)
	}

	@Test
	def void testPropiedades() {

		Assert.assertEquals("F666", f666.nroVuelo)
		Assert.assertEquals("Maiden Ar", f666.aerolinea)
		Assert.assertEquals(ezeiza, f666.origen)
		Assert.assertEquals(mendoza, f666.destino)
		Assert.assertEquals("20/03/2016 08:15", SSDate.toShow(f666.fechaSalida))
		Assert.assertEquals("21/03/2016 20:00", SSDate.toShow(f666.fechaArribo))
		Assert.assertEquals(30, f666.asientos.size)
		Assert.assertEquals(1, f666.escalas.size)
	}
	
	@Test
	def void testConLugar() {
		Assert.assertTrue(f666.vueloConLugar())
	}	
	
	@Test
	def void testCantidadAsientosLibres() {
		val asiento1 = f666.asientos.get(1)
		val ivan = new Usuario("ivan") 
		val reserva = new Reserva(asiento1, ivan, f666)
		Assert.assertEquals(29, f666.cantidadAsientosLibres())
	}	
	
		
	@Test
	def void testCantidadAsientosReservados() {
		val asiento1 = f666.asientos.get(1)
		val ivan = new Usuario("ivan") 
		val reserva = new Reserva(asiento1, ivan, f666)
		Assert.assertEquals(1, f666.cantidadAsientosReservados())
	}	
	
	@Test
	def void testSaleEntre() {
		Assert.assertTrue(f666.saleEntre(SSDate.p("20160319 8:15" ), SSDate.p("20160321 8:15" )))
		Assert.assertFalse(f666.saleEntre(SSDate.p("20160321 8:15" ), SSDate.p("20160322 8:15" )))
	}	
	
	@Test
	def void testSaleDe() {
		Assert.assertTrue(f666.saleDe(ezeiza))
		Assert.assertFalse(f666.saleDe(marDelPlata))
	}	

	@Test
	def void testPasaPor() {
		Assert.assertTrue(f666.pasaPor(marDelPlata))
		Assert.assertFalse(f666.pasaPor(ezeiza))
	}
	
	
	
}