package edu.unsam.Salieri.Domain

import java.util.Calendar
import java.util.Date
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoTarifa", discriminatorType=DiscriminatorType.INTEGER)
interface ITarifa {

	def float obtenerPrecio(Vuelo vuelo)
	def int tipo()
}

@Observable
@Accessors
@Entity
@DiscriminatorValue("1")
class TarifaEspecial implements ITarifa {

	@Id
	@GeneratedValue
	private Long id
	@Column
	float descuentoTarifa

	static int tipo = 1

	new() {
	}

	new(float descuento) {
		descuentoTarifa = descuento
	}

	override obtenerPrecio(Vuelo vuelo) {
		vuelo.tarifaDefault - descuentoTarifa
	}
	override  int tipo(){
		tipo
	}
}

@Observable
@Accessors
@Entity
@DiscriminatorValue("2")
class TarifaBandaNegativa implements ITarifa {

	@Id
	@GeneratedValue
	private Long id
	static int tipo = 2

	new() {
	}

	override obtenerPrecio(Vuelo vuelo) {
		if (seDebeAplicar(vuelo)) {
			(vuelo.tarifaDefault * 0.8).floatValue
		} else {
			(vuelo.tarifaDefault * 0.9).floatValue
		}
	}

	def boolean seDebeAplicar(Vuelo vuelo) {
		val cal = Calendar.getInstance();
		cal.time = vuelo.fechaSalida
		cal.add(Calendar.DATE, -3);
		val fecha = cal.getTime();
		fecha.before(new Date())
	}
	override  int tipo(){
		tipo
	}
}

@Observable
@Accessors
@Entity
@DiscriminatorValue("3")
class TarifaComun implements ITarifa {

	@Id
	@GeneratedValue
	private Long id
	static int tipo = 3

	new() {
	}


	override obtenerPrecio(Vuelo vuelo) {
		vuelo.tarifaDefault
	}
	override  int tipo(){
		tipo
	}
}
