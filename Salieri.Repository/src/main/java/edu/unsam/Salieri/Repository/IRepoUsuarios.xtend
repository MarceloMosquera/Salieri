package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Usuario

interface IRepoUsuarios {
	def void agregarUsuarioConContraseña(Usuario usuario, String contrasenia)
	def void quitarUsuario(Usuario usuario)
	def Usuario obtenerUsuario(String nombre)
}