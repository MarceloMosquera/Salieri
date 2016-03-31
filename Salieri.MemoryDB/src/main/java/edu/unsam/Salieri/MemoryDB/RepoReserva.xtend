package edu.unsam.Salieri.MemoryDB

import edu.unsam.Salieri.Repository.IRepoReservas
import edu.unsam.Salieri.Domain.Reserva
import edu.unsam.Salieri.Domain.Usuario
import java.util.ArrayList
import java.util.List

class RepoReserva implements IRepoReservas{
	
	List<Reserva> reservas
	List<Reserva> resultadoReserva
	
	new(){
		reservas = new ArrayList
		resultadoReserva = new ArrayList
	}
	
	override agregarReserva(Reserva unaReserva){
		reservas.add(unaReserva)
	}
	
	override  quitarReserva(Reserva unaReserva){
		reservas.remove(unaReserva)
	}
	
	override buscarReservaDelUsuario(Usuario unUsuario){
		reservas.filter[reserva|reserva.reservaDelUsuario(unUsuario)].toList
	}
	
}