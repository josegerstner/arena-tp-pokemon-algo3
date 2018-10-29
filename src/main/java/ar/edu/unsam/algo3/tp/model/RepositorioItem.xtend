package ar.edu.unsam.algo3.tp.model

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class RepositorioItem extends Repositorio<Item> {

	static var RepositorioItem instance

	@Accessors List<Pokemon> pokemones = new ArrayList()

	private new() {

		create( new Pokebola(10,10,"Pokebola") )
		create(new Pocion(10,10,"Pocion") )

	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioItem
		}
		return instance
	}

	def agregarPokemon(Pokemon pokemon) {
		pokemones.add(pokemon)
	}

	def clear() {
		pokemones.clear
	}

	override parsearObjetos(String json) {
	}

	override getJson() {
	}

	override searchPorCriterioUnico(Item objeto) {
	}

	override criterioDeBusquedaPorValor(Item item, String nombre) {
		nombre.equals( item.nombre )
	}

	override pisarObjetos(Item objetoEncontrado, Item objetoNuevo) {
	}
	
}
