package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.exception.DuplicadoExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ObjetoNoEncontradoExcepcion
import ar.edu.unsam.algo3.tp.model.serviciosExternos.JsonService
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
abstract class Repositorio<T extends Entidad> {
	
	@Accessors JsonService jsonService
	
	@Accessors String description
	
	protected List<T> objetos = newArrayList();
	int id = 0;

	def clean() {
		objetos = newArrayList
	}
	
	def T searchPorCriterioUnico(T objeto)
	def Boolean criterioDeBusquedaPorValor(T objeto, String string)
	
	/*
	 * Agrega un nuevo objeto a la colección, y le asigna un identificador unívoco (id).
	 * El identificador puede ser random o autoincremental. En caso de que tenga errores de validación no debe agregarlo.
	 */
	def void create(T objeto) {

		if (existeObjeto(objeto)) {
			throw new DuplicadoExcepcion("Se intento crear un objeto que ya existe.")
		}

		objeto.validar
		objeto.id = id

		objetos.add(objeto)

		incremetarId()

	}

	/*
	 * Elimina el objeto de la colección.
	 */
	def void delete(T objeto) {

		val objetoEncontrado = searchPorCriterioUnico(objeto)

		if (objetoEncontrado == null) {
			throw new ObjetoNoEncontradoExcepcion("El objeto esta duplicado")
		}

		objetos.remove(objetoEncontrado)

	}

	
	def void update(T objetoNuevo) {

		objetoNuevo.validar

		var objetoBuscado = searchPorCriterioUnico(objetoNuevo)

		if (objetoBuscado == null) {
			throw new ObjetoNoEncontradoExcepcion("Intentando updatear un objeto que no existe")
		}
		pisarObjetos(objetoBuscado, objetoNuevo)
	}

	abstract def void pisarObjetos(T objetoEncontrado, T objetoNuevo)

	/*
	 * Retorna el objeto cuyo id sea el recibido como parámetro.
	 */
	def T searchById(int idABuscar) {

		return objetos.findFirst[objeto|objeto.id == idABuscar]

	}

	
//	 Devuelve los objetos que coincidan con la búsqueda de acuerdo a los siguientes criterios:
//	 Especie: El valor de búsqueda debe coincidir exactamente con su número o parcialmente con el nombre o descripción.
//	 Pokeparada: El valor de búsqueda debe coincidir parcialmente con su nombre o exactamente con el nombre de alguno de sus ítems disponibles.
	 
	def List<T> search(String valor) {

		objetos.filter[objeto|criterioDeBusquedaPorValor(objeto, valor)].toList

	}

	def void incremetarId() {
		id++
	}

	def int cantidadObjetos() {
		this.objetos.size
	}

	def Boolean existeObjeto(T objeto) {
		searchPorCriterioUnico(objeto) != null
	}


	def void actualizar(List<T> objetosNuevos) {
		objetosNuevos.forEach [ objetoNuevo |
			if (existeObjeto(objetoNuevo)) {
				update(objetoNuevo)
			} else {
				create(objetoNuevo)
			}
		]
	}
	def abstract List<T> parsearObjetos(String json)
	
	/*
	 * Consulta el servicio correspondiente y actualiza los objetos del repositorio en base al JSON recibido como respuesta. 
	 */
	def updateAll(){
		//Parseo del string a una lista de objetos de mi modelo
		val List<T> objetosParseados = parsearObjetos(getJson)
		//Hago el update
		actualizar(objetosParseados)
			
	}
	
	def String getJson()
	
//	override toString(){
//		description
//	}
}
