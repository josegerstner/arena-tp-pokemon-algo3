package ar.edu.unsam.algo3.tp.model;

import ar.edu.unsam.algo3.tp.model.json.JsonParserPokeparada
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.geodds.Point

@Accessors
@Observable
class RepoPokeparadas extends Repositorio<Pokeparada> {

	@Accessors JsonParserPokeparada jsonParserPokeparada

	
	var List<Pokeparada> pokeparadas = newArrayList

	 new() {
		pokeparadas.add(new Pokeparada() => [
			id = 1
			nombre = "UNSAM"
			ubicacion = new Point(-34.486219, -58.534894)
			agregarItem(RepositorioItem.instance.search("Pocion").get(0))
			agregarItem(RepositorioItem.instance.search("Pokebola").get(0))
		])
		pokeparadas.add(new Pokeparada() => [
			id = 2
			nombre = "PUPO"
			ubicacion = new Point(-34.572219, -57.534893)
			agregarItem(RepositorioItem.instance.search("Pokebola").get(0))
			agregarItem(RepositorioItem.instance.search("Pocion").get(0))
		])
	}
	
		/*
	 * El valor de búsqueda debe coincidir parcialmente con su nombre 
	 * o exactamente con el nombre de alguno de sus ítems disponibles.
	 */
	@Accessors List<Item> items = new ArrayList()

	override criterioDeBusquedaPorValor(Pokeparada pokeparada, String valor) {
		pokeparada.nombre.toLowerCase.contains(valor.toLowerCase) || pokeparada.items.exists [ item |
			item.nombre.equals(valor)
		]
	}

	override searchPorCriterioUnico(Pokeparada pokeparada) {
		findByCoordenadas(pokeparada.ubicacion)
	}

	def Boolean existePokeparada(Pokeparada pokeparada) {
		searchPorCriterioUnico(pokeparada) != null
	}

	def agregarItem(Item item) {
		items.add(item)
	}

	def Item getItemByNombre(String nombre) {
		items.findFirst[item|item.nombre.equals(nombre)]
	}

	def findByCoordenadas(Point point) {
		return objetos.findFirst [ objeto |
			objeto.distancia(point).equals(0d)
		]
	}

	override pisarObjetos(Pokeparada objetoEncontrado, Pokeparada objetoNuevo) {
		objetoEncontrado.id = objetoNuevo.id
		objetoEncontrado.nombre = objetoNuevo.nombre
		objetoEncontrado.ubicacion = objetoNuevo.ubicacion
		objetoEncontrado.items = objetoNuevo.items
	}

	override parsearObjetos(String json) {
		jsonParserPokeparada.parsearPokeparadas(json)
	}

	override getJson() {
		return jsonService.getJsonPokeparada
	}

	def obtenerPokeparadas() {
		pokeparadas
	}
	}