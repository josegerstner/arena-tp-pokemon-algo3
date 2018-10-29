package ar.edu.unsam.algo3.tp.model

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

class RepositorioPokemon extends Repositorio<Pokemon> {

	static var RepositorioPokemon instance

	@Accessors List<Pokemon> pokemones = new ArrayList()
	@Accessors List<Pokemon> pokemonSalvaje = new ArrayList()

	private new() {

		create( new Pokemon() => [
			nombre = "Charmander"
			especie = RepositorioEspecie.instance.search("Fuego").get(0)
			puntosDeSalud = 50
			experiencia = 2000
			genero = Genero.FEMENINO
			nombreFamilia= "charmander"
			ubicacion = new Point(-34.486219, -58.534896)

			])

		create(new Pokemon() => [
			nombre = "Pikachu"
			especie = RepositorioEspecie.instance.search("Electrico").get(0)
			puntosDeSalud = 150
			experiencia = 200
			genero = Genero.MASCULINO
			nombreFamilia = "pikachu"
			ubicacion = new Point(-34.486219, -58.534895)
		])
		
		create(new Pokemon() => [
			nombre = "Charizard"
			especie = RepositorioEspecie.instance.search("Fuego").get(0)
			puntosDeSalud = 1500
			experiencia = 200000
			genero = Genero.MASCULINO
			nombreFamilia="charizard"
			ubicacion = new Point(-34.570219, -58.534893)
		])
		
		create(new Pokemon() => [
			nombre = "Pipo"
			especie = RepositorioEspecie.instance.search("Electrico").get(0)
			puntosDeSalud = 250
			experiencia = 11000
			genero = Genero.FEMENINO
			nombreFamilia="pikachu"
			ubicacion = new Point(-34.570219, -58.534893)
			
		])
		create(new Pokemon() => [
			nombre = "Snorlax"
			especie = RepositorioEspecie.instance.search("Normal").get(0)
			puntosDeSalud = 500
			experiencia = 11000
			genero = Genero.FEMENINO
			nombreFamilia="snorlax"
			ubicacion = new Point(-34.570219, -58.534893)
		])
		create(new Pokemon() => [
			nombre = "Meowth"
			especie = RepositorioEspecie.instance.search("Normal").get(0)
			puntosDeSalud = 500
			experiencia = 210000
			genero = Genero.MASCULINO
			nombreFamilia="meowth"
			ubicacion = new Point(-34.570219, -58.534893)
		])
		agregarSalvajes()
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioPokemon
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

	override searchPorCriterioUnico(Pokemon objeto) {
	}

	override criterioDeBusquedaPorValor(Pokemon pokemon, String nombre) {
		nombre.equals( pokemon.nombre )
	}

	override pisarObjetos(Pokemon objetoEncontrado, Pokemon objetoNuevo) {
	}
	def agregarSalvajes(){
		pokemonSalvaje.add( new Pokemon() => [
			nombre = "Charmi"
			especie = RepositorioEspecie.instance.search("Fuego").get(0)
			puntosDeSalud = 50
			experiencia = 2000
			genero = Genero.FEMENINO
			ubicacion = new Point(-34.486219, -58.534893)
			nombreFamilia="charmander"
			])

		pokemonSalvaje.add(new Pokemon() => [
			nombre = "Piki"
			especie = RepositorioEspecie.instance.search("Electrico").get(0)
			puntosDeSalud = 150
			experiencia = 200
			genero = Genero.MASCULINO
			ubicacion = new Point(-34.486219, -58.534893)
			nombreFamilia="pikachu"
		])
		
		pokemonSalvaje.add(new Pokemon() => [
			nombre = "Chari"
			especie = RepositorioEspecie.instance.search("Fuego").get(0)
			puntosDeSalud = 1500
			experiencia = 200000
			genero = Genero.MASCULINO
			ubicacion =  new Point(-34.572219, -58.534893)
			nombreFamilia="charizard"
		])
	}
	def obtenerSalvajes(Entrenador entrenador){
		pokemonSalvaje.filter[p|p.ubicacion.distance(entrenador.ubicacion)<10].toList
	}
	
	def eliminarSalvaje(String nombre){
		pokemonSalvaje.remove(RepositorioPokemon.instance.pokemonSalvaje.filter [ p |
				p.nombre.equals(nombre)
			].get(0))
	}

}
