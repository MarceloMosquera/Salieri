package edu.unsam.Salieri.Tests

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.MemoryDB.RepoUsuarios

class TestsUsuarios {
	RepoUsuarios repoUsuarios
	Usuario usuario1
	Usuario usuario2

//(expected=typeof(Exception))
//Assert.assertEquals(imc,unUsuarioConIMCExacto.getIMC(), 1 )
//System.out.println(repoUsuarios.todosLosUsuarios.size)

	@Before
	def void init() {
		repoUsuarios = new RepoUsuarios()
		usuario1 = new Usuario("pepe")
		usuario2 = new Usuario("fatmagul")
		// usuario.nick = "Pepito"
		// usuario.nombre
		// usuario.password = "1234"
		repoUsuarios.agregarUsuarioConContraseña(usuario1, "1234")
	}

	@Test
	def void crearUnUsuario() {
		val usuarioTemp = new Usuario("pepe2")
		Assert.assertEquals(usuarioTemp.nombre, "pepe2")
	}

	@Test
	def void agregarUnUsuarioConContraseña() {
		repoUsuarios.agregarUsuarioConContraseña(usuario2, "1234")
		Assert.assertEquals(repoUsuarios.todosLosUsuarios.size, 2)
	}

	@Test
	def void quitarUsuario() {
		repoUsuarios.agregarUsuarioConContraseña(usuario2, "1234")
		repoUsuarios.quitarUsuario(usuario1)
		Assert.assertEquals(repoUsuarios.todosLosUsuarios.size, 1)
	}

	@Test
	def void obtenerUsuarioInexistente() {
		Assert.assertNull(repoUsuarios.obtenerUsuario("Carlos"))
	}

	@Test
	def void obtenerUsuarioExistente() {
		repoUsuarios.agregarUsuarioConContraseña(usuario2, "1234")
		val Usuario usuarioTemp = repoUsuarios.obtenerUsuario("pepe")
		Assert.assertEquals(usuarioTemp.nombre, "pepe")
	}

	@Test
	def void loginPassIncorrecta() {
		Assert.assertEquals(usuario1.esPasswordValida("4321"), false)
	}

	@Test
	def void loginPassCorrecta() {
		Assert.assertEquals(usuario1.esPasswordValida("1234"), true)
	}
}
