package edu.unsam.Salieri.Front.AppModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import edu.unsam.Salieri.Domain.Usuario

@Accessors
@Observable
class LoginAppModel extends BaseAppModel{

	String nombreUsuarioABuscar
	String contrasenia
	Usuario usuarioLogin
	String mensajeError
	
	def boolean login() {
		mensajeError = null
		usuarioLogin= DBContext.repoUsuarios.obtenerUsuario(nombreUsuarioABuscar)
		if (usuarioLogin == null || !usuarioLogin.validarPassword(contrasenia))
			mensajeError = "Usuario no encontrado o Clave incorrecta"
		(mensajeError != null)
	}
	
	def limpiar(){
		nombreUsuarioABuscar = null
		contrasenia = null
		usuarioLogin = null
		mensajeError = null
	}
		
}
