package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.Reserva
import java.util.List

interface IRepoReservas {
	
	def void agregarReserva(Reserva unaReserva){}
	
	def void quitarReserva(Reserva unaReserva){}
	
	def List<Reserva> buscarReservaDelUsuario(Usuario unUsuario){}
	
}