package MongoDB

import com.mongodb.MongoClient
import edu.unsam.Salieri.Domain.Consulta
import edu.unsam.Salieri.Domain.Usuario
import java.lang.reflect.Array
import java.lang.reflect.Modifier
import java.util.ArrayList
import org.hibernate.collection.PersistentSet
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import edu.unsam.Salieri.Domain.VueloConsulta

abstract class RepoAbstractoConsulta<T> {

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
		}
	}

        def T despejarCampos(Object t) {
                if (t == null) {
                        return null
                }
                val fields = new ArrayList(t.class.getDeclaredFields)
                val camposAModificar = fields.filter [
                        !Modifier.isFinal(it.modifiers) && !it.name.contains("changeSupport")
                ]
                if (t.class != PersistentSet) {
                        println("   Campos a persistir: " + camposAModificar)
                        println("Crearemos un " + t.class)
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
	abstract def Class<T> getEntityType()

}