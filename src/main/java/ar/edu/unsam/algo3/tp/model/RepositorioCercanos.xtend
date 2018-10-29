package ar.edu.unsam.algo3.tp.model
import java.util.ArrayList
import java.util.HashMap
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import ar.edu.unsam.algo3.tp.model.json.JsonParserPokeparada

class RepositorioCercanos  {

	@Accessors JsonParserPokeparada jsonParserPokeparada

	
	var List<Pokeparada> pokeparadas = newArrayList
	var List<Pokemon> pokemonSalvaje = newArrayList
	 new() {
		pokeparadas.add(new Pokeparada() => [
			id = 1
			nombre = "UNSAM"
			ubicacion = new Point(-34.486219, -58.534893)
			agregarItem(new Pocion(10,10,"Pocion"))
			agregarItem(new Pokebola(10,10,"Pokebola"))
		])
		pokeparadas.add(new Pokeparada() => [
			id = 2
			nombre = "PUPO"
			ubicacion = new Point(-34.572219, -57.534893)
			agregarItem(new Pokebola(10,10,"Pokebola"))
			agregarItem(new Pocion(10,10,"Pocion"))
		])
		
		
		pokemonSalvaje.add( new Pokemon() => [
			nombre = "Charmi"
			especie = RepositorioEspecie.instance.search("Fuego").get(0)
			puntosDeSalud = 50
			experiencia = 2000
			genero = Genero.FEMENINO
			ubicacion = new Point(-34.572219, -58.534893)
			nombreFamilia="charmander"
			])

		pokemonSalvaje.add(new Pokemon() => [
			nombre = "Piki"
			especie = RepositorioEspecie.instance.search("Electrico").get(0)
			puntosDeSalud = 150
			experiencia = 200
			genero = Genero.MASCULINO
			ubicacion = new Point(-34.572219, -58.534893)
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

	
	/*
	 * El valor de búsqueda debe coincidir parcialmente con su nombre 
	 * o exactamente con el nombre de alguno de sus ítems disponibles.
	 */
	@Accessors List<Item> items = new ArrayList()

	

	def agregarItem(Item item) {
		items.add(item)
	}

	def Item getItemByNombre(String nombre) {
		items.findFirst[item|item.nombre.equals(nombre)]
	}

	
	def pisarObjetos(Pokeparada objetoEncontrado, Pokeparada objetoNuevo) {
		objetoEncontrado.id = objetoNuevo.id
		objetoEncontrado.nombre = objetoNuevo.nombre
		objetoEncontrado.ubicacion = objetoNuevo.ubicacion
		objetoEncontrado.items = objetoNuevo.items
	}

	def parsearObjetos(String json) {
		jsonParserPokeparada.parsearPokeparadas(json)
	}


	def obtenerPokeparadas() {
		pokeparadas
	}
	
	def obtenerPokeparadasCercanas(Entrenador entrenador){
		this.pokeparadas.filter[p|p.distancia(entrenador.ubicacion) < 10].toList
	}
	
	def obtenerSalvajesCercanos(Entrenador entrenador){
		pokemonSalvaje.filter[p|p.ubicacion.distance(entrenador.ubicacion)< 10].toList
	}
	
	def eliminarSalvaje(String nombre){
		pokemonSalvaje.remove(RepositorioPokemon.instance.pokemonSalvaje.filter [ p |
				p.nombre.equals(nombre)
			].get(0))
	}
	

}

