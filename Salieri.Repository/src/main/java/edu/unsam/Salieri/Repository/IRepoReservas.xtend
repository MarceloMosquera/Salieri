package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Reserva

interface IRepoReservas {
	
	def void agregarReserva(Reserva unaReserva){}
	
	def void quitarReserva(Reserva unaReserva){}
	
	def void buscarReservaDelUsuario(Usuario unUsuario){}
	
}