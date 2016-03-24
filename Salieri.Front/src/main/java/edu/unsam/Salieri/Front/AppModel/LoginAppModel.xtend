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
	
	def autorizarLogin() {
		DBContext.repoUsuarios.compararContraseña(nombreUsuarioABuscar,contrasenia)
		usuarioLogin= DBContext.repoUsuarios.obtenerUsuario(nombreUsuarioABuscar)
	}
	
	def clear(){
		nombreUsuarioABuscar = null
		contrasenia = null
		usuarioLogin = null
	}
		
}
