package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Domain.Aeropuerto
import edu.unsam.Salieri.Domain.Descuento.Descuento
import edu.unsam.Salieri.Domain.Descuento.DescuentoPorcentaje
import edu.unsam.Salieri.Domain.Descuento.DescuentoRegla72HsAntes
import edu.unsam.Salieri.Domain.Escala
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Repository.IDBContext
import edu.unsam.Salieri.Repository.IRepoAeropuertos
import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Repository.IRepoUsuarios
import edu.unsam.Salieri.Repository.IRepoVuelos
import edu.unsam.Salieri.Util.SSDate
import edu.unsam.Salieri.Domain.Descuento.DescuentoReglaSiempre
import edu.unsam.Salieri.Domain.Descuento.DescuentoMonto
import edu.unsam.Salieri.Domain.Reserva

class DBContext implements IDBContext {

	static IRepoUsuarios _repoUsuarios = null
	static IRepoVuelos _repoVuelos = null
	static IRepoReservas _repoReservas = null
	static IRepoAeropuertos _repoAeropuertos = null

	override IRepoUsuarios repoUsuarios() {
		if (_repoUsuarios == null) {
			_repoUsuarios = new RepoUsuarios()
		}
		_repoUsuarios;
	}

	override IRepoVuelos repoVuelos() {
		if (_repoVuelos == null) {
			_repoVuelos = new RepoVuelos()
		}
		_repoVuelos;
	}
	
	override IRepoReservas repoReservas() {
		if (_repoReservas == null) {
			_repoReservas = new RepoReserva()
		}
		_repoReservas;
	}
	
	override IRepoAeropuertos repoAeropuertos() {
		if (_repoAeropuertos == null) {
			_repoAeropuertos = new RepoAeropuertos()
		}
		_repoAeropuertos;
	}

	new() {
		init()
	}

	def void init() {
		val diego = new Usuario("diego")
		val ivan = new Usuario("ivan")
		val nicolas = new Usuario("nicolas")
		val marcelo = new Usuario("marcelo")
		repoUsuarios => [
			agregarUsuarioConContraseña(diego, "diego")
			agregarUsuarioConContraseña(ivan, "ivan")
			agregarUsuarioConContraseña(nicolas, "nicolas")
			agregarUsuarioConContraseña(marcelo, "marcelo")
		]

		val ezeiza = new Aeropuerto("Ezeiza (EZE)", "Buenos Aires", "Argentina")
		val marDelPlata = new Aeropuerto("Mar del Plata (MDQ)", "Buenos Aires", "Argentina")
		val mendoza = new Aeropuerto("Mendoza (MDZ)", "Mendoza", "Argentina")
		val guarulhos = new Aeropuerto("Aeropuerto Internacional de Guarulhos (GRU)", "São Paulo", "Brasil")
		repoAeropuertos => [
			agregarAeropuerto(ezeiza)
			agregarAeropuerto(marDelPlata)
			agregarAeropuerto(mendoza)
			agregarAeropuerto(guarulhos)
			agregarAeropuerto(new Aeropuerto("Caleta Olivia (CVI)", "Santa Cruz", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Catriel (CCT)", "Río Negro", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Caviahue (CVH)", "Neuquén", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Ceres (CRR)", "Santa Fe", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Chos Malal (HOS)", "Neuquén", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Clorinda (CLX)", "Formosa", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Comodoro Rivadavia (CRD)", "Chubut", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Córdoba (COR)", "Córdoba", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Concordia (COC)", "Entre Ríos", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Coronel Suárez (CSZ)", "Buenos Aires", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Corrientes (CNQ)", "Corrientes", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Curuzú Cuatiá (UZU)", "Corrientes", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Cutral-Co (CUT)", "Neuquén", "Argentina"))
			agregarAeropuerto(new Aeropuerto("Dolores (VDR)", "Buenos Aires", "Argentina"))
			agregarAeropuerto(new Aeropuerto("El Bolsón (EHL)", "Río Negro", "Argentina"))
			agregarAeropuerto(new Aeropuerto("El Calafate (FTE)", "Santa Cruz", "Argentina"))
		]
		
		val n2346 = new Vuelo("N2346", "LAN AR", ezeiza, mendoza, 
			SSDate.p("20160315 8:15" ), SSDate.p("20160315 10:00" ) , 500) 
		val i9573 = new Vuelo("I9573", "Aerolinas Argentinas", marDelPlata, guarulhos,
			SSDate.p("20160316 8:15" ), SSDate.p("20160316 18:00" ) , 1000)

		var f956 = new Vuelo("F956", "Indio Ar", ezeiza, guarulhos,
			SSDate.p("20160315 8:15" ), SSDate.p("20160316 20:00" ) , 2000)
			
		f956 => [
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("El Calafate (FTE)"), 
				SSDate.p("20160315 17:00" ),SSDate.p("20160315 17:30" )  
			))
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("El Bolsón (EHL)"), 
				SSDate.p("20160316 01:00" ),SSDate.p("20160316 01:30" )  
			))
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("Dolores (VDR)"), 
				SSDate.p("20160316 13:00" ),SSDate.p("20160316 13:30" )  
			))
		]
		
		f956.tarifa.agregarDescuento(
			new Descuento(
				new DescuentoReglaSiempre(), 
				new DescuentoMonto(100)
			)
		)

		var f666 = new Vuelo("F66", "Maiden Ar", guarulhos, ezeiza, 
			SSDate.p("20160320 8:15" ), SSDate.p("20160321 20:00" ) , 3000)
			
		f666 => [
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("Dolores (VDR)"), 
				SSDate.p("20160320 13:00" ),SSDate.p("20160320 13:30" )  
			))
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("El Bolsón (EHL)"), 
				SSDate.p("20160321 01:00" ),SSDate.p("20160321 01:30" )  
			))
			agregarEscala(
				new Escala(repoAeropuertos.buscarAeropuertoPorNombre("El Calafate (FTE)"), 
				SSDate.p("20160321 17:00" ),SSDate.p("20160321 17:30" )  
			))
		]
		
		f666.tarifa.agregarDescuento(
			new Descuento(
				new DescuentoRegla72HsAntes(), 
				new DescuentoPorcentaje(0.20f)
			)
		)
		

		repoVuelos.agregarVuelo(n2346)
		repoVuelos.agregarVuelo(i9573)
		repoVuelos.agregarVuelo(f956)
		repoVuelos.agregarVuelo(f666)

		val asiento1 = n2346.asientos.get(1)
		val asiento2 = n2346.asientos.get(2)
		val asiento3 = i9573.asientos.get(3)
		val asiento4 = i9573.asientos.get(4)

		repoReservas.agregarReserva(n2346.reservarAsiento(asiento1, ivan))
		repoReservas.agregarReserva(n2346.reservarAsiento(asiento2, diego))
		repoReservas.agregarReserva(i9573.reservarAsiento(asiento3, nicolas))
		repoReservas.agregarReserva(i9573.reservarAsiento(asiento4, marcelo))
		
		
	}

}
