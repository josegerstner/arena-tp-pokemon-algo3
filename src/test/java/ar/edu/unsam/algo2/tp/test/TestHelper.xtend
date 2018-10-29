package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Pokemon
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.Tipo
import com.eclipsesource.json.Json
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors class TestHelper {

	def crearEntrenador() {

		var entrenador = new Entrenador

		entrenador.ubicacion = new Point(0.00001, 0.00001)

		return entrenador

	}
	
	def crearEntrenador2() {

		var entrenador2 = new Entrenador

		entrenador2.ubicacion = new Point(0.00005, 0.00005)

		return entrenador2

	}

	def crearPokemon() {

		var pokemon = new Pokemon

		pokemon.experiencia = 50

		pokemon.ubicacion = new Point(0, 0)

		return pokemon

	}

	def crearPokemon(Especie especie) {

		var pokemon = crearPokemon

		pokemon.especie = especie

		return pokemon
	
	}
	
	
	/*
	 * JSON 
	 */
	 
	  def crearPokeparadaUNSAMJson() {
		Json.object()
		.add("x", -34.572224)
		.add("y", -58.535651)
		.add("nombre","Pokeparada UNSAM")
		.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add("ultraball").add("superpoción"))
	}
	
	def crearPokeparadaUNSAMactualizadaJson() {
		Json.object()
		.add("x", -34.572224)
		.add("y", -58.535651)
		.add("nombre","Pokeparada UNSAM actualizada")
		.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add("ultraball"))
	}
	
	def crearPokeparadaObeliscoJson() {
		Json.object()
			.add("x", -34.603759)
			.add("y", -58.381586)
			.add("nombre", "Pokeparada obelisco")
			.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add( "superball").add("poción"))
	}
	
	def crearPokeparadaQueNoEstaEnElRepoJson() {
		Json.object()
			.add("x", -34.603321) 
			.add("y", -58.381123)
			.add("nombre", "Pokeparada que no esta en el repositorio")
			.add("itemsDisponibles", Json.array().asArray.add("pokebola").add("superball").add("poción"))
	}
	
	def crearPokeparadaJardinBotanicoJson() {
		Json.object() 
			.add("x", -34.5595298) 
			.add("y", -58.491549)
			.add("nombre", "Pokeparada JardinBotanico") 
			.add("itemsDisponibles", Json.array().asArray.add("pokebola").add("superball").add("poción"))
	}
	
	def crearPokeparadaDOTJson() {
		Json.object()
			.add("x", -34.5542418) 
			.add("y", -58.491549)
			.add("nombre", "Pokeparada DOT")
			.add("itemsDisponibles", Json.array().asArray.add("pokebola").add("superball").add("poción"))
	}
	
	def crearPokeparadaConCoordenadasMalJson() {
		Json.object()
		.add("x",  "asd")
		.add("y", "dsa")
		.add("nombre","Pokeparada Con Coordenadas mal")
		.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add("superball").add("poción"))
	}
	
	def crearPokeparadaConItemQueNoExisteJson() {
		Json.object()
		.add("x",  -34.603123)
		.add("y", -58.381321)
		.add("nombre","Pokeparada con item que no existe")
		.add("itemsDisponibles" , Json.array().asArray.add("item que no existe"))
	}
	/*Json object especie */
	
	def crearPikachuJson() {
		Json.object() 
			.add("numero", 25)
			.add("nombre", "Pikachu")
			.add("puntosAtaqueBase", 20)
			.add("puntosSaludBase", 25)
			.add("descripcion", "Es un pikachu que no esta en el repo")
			.add("tipos", Json.array().asArray.add("electricidad"))
			.add("velocidad", 5)
	}
	
	def crearIvysaurJson() {
		Json.object()
		.add("numero",  2)
		.add("nombre", "Ivysaur")
		.add("puntosAtaqueBase",15)
		.add("puntosSaludBase",20)
		.add("descripcion", "Este Pokémon lleva un bulbo en el lomo.")
		.add("tipos" , Json.array().asArray.add("hierba").add("veneno"))
		.add("velocidad",8)
		.add("evolucion",3)
	}
	
	def crearBulbasaurJson() {
		Json.object()
		.add("numero",  1)
		.add("nombre", "Bulbasaur")
		.add("puntosAtaqueBase",10)
		.add("puntosSaludBase",15)
		.add("descripcion", "A Bulbasaur es fácil verle echándose una siesta al sol.")
		.add("tipos" , Json.array().asArray.add("hierba").add("veneno"))
		.add("velocidad",7)
		.add("evolucion",2)
	}
	
	def crearCharmanderJson() {
		Json.object()
			.add("numero", 32)
			.add("nombre", "Charmander")
			.add("puntosAtaqueBase", 40)
			.add("puntosSaludBase", 45)
			.add("descripcion", "Es un charmander que no esta en el repo")
			.add("tipos", Json.array.asArray.add("fuego"))
			.add("velocidad", 9)
	}
	
	def crearEspecieConElNumeroMal() {
		Json.object()
		.add("numero",  "asd")
		.add("nombre", "Especie con numero mal")
		.add("puntosAtaqueBase",15)
		.add("puntosSaludBase",20)
		.add("descripcion", "Es mal cargado el numero.")
		.add("tipos" , Json.array().asArray.add("hierba").add("veneno"))
		.add("velocidad",8)
		.add("evolucion",3)
	}
	
	def crearEspecieSinUnAtributoJson() {
		Json.object()
		.add("nombre", "Bulbasaur")
		.add("puntosAtaqueBase",10)
		.add("puntosSaludBase",15)
		.add("descripcion", "A Bulbasaur es fácil verle echándose una siesta al sol.")
		.add("tipos" , Json.array().asArray.add("hierba").add("veneno"))
		.add("velocidad",7)
		.add("evolucion",2)
	}
	
	def crearEspecieConTipoQueNoExisteJson() {
		Json.object()
		.add("numero",  4)
		.add("nombre", "Especie con un tipo que no existe")
		.add("puntosAtaqueBase",25)
		.add("puntosSaludBase",30)
		.add("descripcion", "Esta es una especie con un tipo que no existe.")
		.add("tipos" , Json.array().asArray.add("hierba").add("Tipo que no existe."))
		.add("velocidad",5)
		.add("evolucion",3)
	}
	
	def Tipo getTipoAgua() {
		new Tipo("Agua")
	}

	def Tipo getTipoFuego() {
		new Tipo("Fuego")
	}

	def Tipo getTipoTierra() {
		new Tipo("Tierra")
	}

	def Tipo getTipoRoca() {
		new Tipo("Roca")
	}

	def Tipo getTipoHielo() {
		new Tipo("Hielo")
	}

	def Tipo getTipoAcero() {
		new Tipo("Acero")
	}

	def Tipo getTipoViento() {
		new Tipo("Viento")
	}

	def Tipo getTipoHierba() {
		new Tipo("Hierba")
	}

	def Tipo getTipoVeneno() {
		new Tipo("Veneno")
	}

	def Tipo getTipoElectrico() {
		new Tipo("Electrico")
	}
	
	def crearBulbasaur() {
		new Especie() => [
			numero = 1
			nombre = "Bulbasaur"
			puntosAtaque = 10
			puntosSalud = 15
			descripcion = "Este pokemon es un Bulbasaur es fácil verle echándose una siesta al sol."
			tipos = tiposDelTest
			velocidad = 7
		]
	}
	
	def crearIzysaur() {
		new Especie() => [
			numero = 2
			nombre = "Ivysaur"
			puntosAtaque = 15
			puntosSalud = 20
			descripcion = "Este pokemon lleva un bulbo en el lomo."
			tipos = tiposDelTest
			velocidad = 8
		]
	}
	
	def getTiposDelTest() {
		obtenerTiposPorNombres( newArrayList( "hierba" , "veneno") )
	}
	
	def obtenerTiposPorNombres(List<String> nombresDeTipos){
		nombresDeTipos.map[ nombreDeTipo | repositorioEspecie.getTipoByNombre( nombreDeTipo ) ].toList
	}
	
	RepositorioEspecie repositorioEspecie = RepositorioEspecie.instance
}
