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
@DiscriminatorValue("0")
abstract class ITarifa {

	@Id
	@GeneratedValue
	private Long id

	@Column
	public float precioBase

	@Column
	public float descuentoTarifa

	def float obtenerPrecio(Vuelo vuelo)

}

@Observable
@Accessors
@Entity
@DiscriminatorValue("1")
class TarifaEspecial extends ITarifa {

	new(float precio, float descuento) {
		precioBase = precio
		descuentoTarifa = descuento
	}

	override obtenerPrecio(Vuelo vuelo) {
		precioBase - descuentoTarifa
	}

}

@Observable
@Accessors
@Entity
@DiscriminatorValue("2")
class TarifaBandaNegativa extends ITarifa {

	new() {
	}

	new(float precio) {
		precioBase = precio
	}

	override obtenerPrecio(Vuelo vuelo) {
		if (seDebeAplicar(vuelo)) {
			(precioBase * 0.8).floatValue
		} else {
			(precioBase * 0.9).floatValue
		}
	}

	def boolean seDebeAplicar(Vuelo vuelo) {
		val cal = Calendar.getInstance();
		cal.time = vuelo.fechaSalida
		cal.add(Calendar.DATE, -3);
		val fecha = cal.getTime();
		fecha.before(new Date())
	}

}

@Observable
@Accessors
@Entity
@DiscriminatorValue("3")
class TarifaComun extends ITarifa {

	new() {
	}

	new(float precio) {
		precioBase = precio
	}

	override obtenerPrecio(Vuelo vuelo) {
		precioBase
	}

}
