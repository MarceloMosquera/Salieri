package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Usuario

interface IRepoUsuarios {
	def void agregarUsuarioConContraseña(Usuario usuario, String contrasenia)
	def void quitarUsuario(Usuario usuario, String contrasenia)
	def boolean compararContraseña(String usr, String contraseniaIngresada)
	def Usuario obtenerUsuario(String nombre)
}