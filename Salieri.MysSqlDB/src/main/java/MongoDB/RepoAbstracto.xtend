package MongoDB

import com.mongodb.MongoClient
import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import edu.unsam.Salieri.Domain.VueloConsulta
import java.lang.reflect.Array
import java.lang.reflect.Modifier
import java.util.ArrayList
import java.util.List
import org.hibernate.collection.PersistentSet
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations
import org.mongodb.morphia.annotations.Transient
import java.lang.reflect.Field

abstract class RepoAbstracto<T> {

	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				map(typeof(Consulta)).map(typeof(Usuario)).map(typeof(VueloConsulta))
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
			morphia.getMapper().getOptions().setStoreEmpties(true)
		}
	}

	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<T> searchByExample(T t)

	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		create(t)
	}

	def void update(T t) {
		val result = ds.update(t, this.defineUpdateOperations(t))
		println("Actualizamos " + t + "? " + result.updatedExisting)
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def T create(T t) {
		val obj = despejarCampos(t)
		ds.save(obj)
		obj
	}

	def boolean esTransient(Field f) {
		val tieneAnnotation = f.getAnnotation(Transient)
		return  (tieneAnnotation != null)
	}

	def T despejarCampos(Object t) {
		if (t == null) {
			return null
		}
		val fields = new ArrayList(t.class.getDeclaredFields)
		val camposAModificar = fields.filter [
			!Modifier.isFinal(it.modifiers) && !it.name.contains("changeSupport") && !esTransient(it)
		]
		if (t.class != PersistentSet) {
			println("Crearemos un " + t.class)
			println("   Campos a persistir: " + camposAModificar)
			val T result = t.class.newInstance as T
			try {
				val fieldChangeSupport = result.class.getDeclaredField("changeSupport")
				fieldChangeSupport.accessible = true
				fieldChangeSupport.set(result, null)

			} catch (NoSuchFieldException e) {
			}
			camposAModificar.forEach [
				it.accessible = true
				var valor = it.get(t)
				println("Campo: " + it.name + " valor:" + valor)
				if (it.getType().isArray) {
					val length = Array.getLength(valor)
					for (var i = 0; i < length; i++) {
						Array.set(valor, i, despejarCampos(Array.get(valor, i)))
					}
				} else {
					if (valor != null) {
						try {
							valor.class.getDeclaredField("changeSupport")
							valor = despejarCampos(valor)
						} catch (NoSuchFieldException e) {
							try {
								valor.class.getDeclaredMethod("size")
								valor = despejarCampos(valor)
							} catch (NoSuchMethodException nsfe) {
							}
						}
					}
				}

				it.set(result, valor)
			]
			result
		}
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
