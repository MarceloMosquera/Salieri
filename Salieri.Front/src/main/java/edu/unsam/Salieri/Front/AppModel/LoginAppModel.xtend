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
	String mensaje
	
	def boolean login() {
		mensaje = ""
		if(	(nombreUsuarioABuscar == null) || (contrasenia ==null)
			||(nombreUsuarioABuscar == "") || (contrasenia =="")
		) {
			mensaje = "Debe ingresar un usuario y una contraseña"
		} else {
			usuarioLogin= DBContext.repoUsuarios.obtenerUsuario(nombreUsuarioABuscar)
			if (usuarioLogin == null) {
				mensaje = "Usuario no encontrado"
			} else if (!usuarioLogin.esPasswordValida(contrasenia)){
				mensaje = "contraseña incorrecta"
			}
		}
		return (mensaje.equals(""))
	}
	
	def limpiar(){
		nombreUsuarioABuscar = null
		contrasenia = null
		usuarioLogin = null
		mensaje = null
	}
		
}
