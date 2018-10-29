package ar.edu.unsam.algo3.tp.ui

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Item
import ar.edu.unsam.algo3.tp.model.Pokeparada
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.RepositorioPokeparada
import ar.edu.unsam.algo3.tp.model.Tipo
import ar.edu.unsam.algo3.tp.model.command.Rectangulo
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioArea
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.geodds.Point
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioAcciones
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMasAltoObserver
import ar.edu.unsam.algo3.tp.model.observer.RecompensaNivelDeterminadoObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarSuperaNivelObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMultiploDe5Observer
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioRepositorio
import com.eclipsesource.json.JsonObject
import ar.edu.unsam.algo3.tp.model.json.JsonParserPokeparada
import ar.edu.unsam.algo3.tp.model.json.JsonParserEspecie
import com.eclipsesource.json.Json
import ar.edu.unsam.algo3.tp.model.serviciosExternos.JsonService
import com.eclipsesource.json.JsonArray

class ActualizacionBootstrap extends CollectionBasedBootstrap {
	
	/**
	 * Inicialización del juego de datos del repositorio
	 */
	override run() {
		
//		Repositorio Especie
		var RepositorioEspecie repositorioEspecie = RepositorioEspecie.instance
		repositorioEspecie.agregarTipo(new Tipo("hierba"))
		repositorioEspecie.agregarTipo(new Tipo("veneno"))
		repositorioEspecie.agregarTipo(new Tipo("electricidad"))
		repositorioEspecie.agregarTipo(new Tipo("fuego"))
		var bulbasaur = new Especie() => [
			numero = 10
			nombre = "Bulbasaur"
			puntosAtaque = 10
			puntosSalud = 15
			descripcion = "Este pokemon es un Bulbasaur es fácil verle echándose una siesta al sol."
			tipos = newArrayList(new Tipo("veneno") ,new Tipo("hierba"))
			velocidad = 7
		]
		var ivysaur = new Especie() => [
			numero = 20
			nombre = "Ivysaur"
			puntosAtaque = 15
			puntosSalud = 20
			descripcion = "Este pokemon lleva un bulbo en el lomo."
			tipos = newArrayList(new Tipo("veneno") ,new Tipo("hierba"))
			velocidad = 8
		]
		
		var pikachu = new Especie() => [
			numero = 30
			nombre = "Pikachu"
			puntosAtaque = 25
			puntosSalud = 30
			it.descripcion = "El viejo y querido Pikachu."
			tipos = newArrayList(new Tipo("veneno") ,new Tipo("hierba"))
			velocidad = 8
		]
		
//		Repositorio Pokeparada
		var repositorioPokeparada = RepositorioPokeparada.instance
		repositorioPokeparada.description = "Repo Especie"
		repositorioPokeparada.agregarItem(new Item(1,"pokebola"))
		repositorioPokeparada.agregarItem(new Item(1,"superball"))
		repositorioPokeparada.agregarItem(new Item(1,"poción"))
		repositorioPokeparada.agregarItem(new Item(1,"ultraball"))
		repositorioPokeparada.agregarItem(new Item(1,"superpoción"))
		var pokeparadaUNSAM = new Pokeparada() => [
			ubicacion = new Point( -34.572224 , -58.535651 )
			nombre = "Pokeparada UNSAM"
			items => [new Item(1,"pokebola") new Item(1,"ultraball") new Item(1,"superpoción")]
		]
		var pokeparadaObelisco = new Pokeparada() => [
			ubicacion = new Point( -34.603759 , -58.381586 )
			nombre = "Pokeparada obelisco"
			items => [new Item(1,"pokebola") new Item(1,"superaball") new Item(1,"poción")]
		]
		var pokeparadaDOT = new Pokeparada() => [
			ubicacion = new Point( -34.5542418 , -58.491549 )
			nombre = "Pokeparada DOT"
			items => [new Item(1,"pokebola") new Item(1,"superaball") new Item(1,"poción")]
		]
		var Pokeparada jardinBotanico = new Pokeparada() => [ 
			ubicacion = new Point( -34.5595298 , -58.491549 ) 
			nombre = "Pokeparada JardinBotanico" 
			items => [new Item(1,"pokebola") new Item(1,"superaball") new Item(1,"poción")]
		]
		
		var JsonParserPokeparada jsonParserPokeparada = new JsonParserPokeparada
		var JsonParserEspecie jsonParserEspecie = new JsonParserEspecie
		
		var JsonObject pokeparadaUNSAMJson {
			Json.object()
			.add("x", -34.572224)
			.add("y", -58.535651)
			.add("nombre","Pokeparada UNSAM")
			.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add("ultraball").add("superpoción"))
		}
		var JsonObject pokeparadaObeliscoJson { 
			Json.object()
			.add("x", -34.603759)
			.add("y", -58.381586)
			.add("nombre", "Pokeparada obelisco")
			.add("itemsDisponibles" , Json.array().asArray.add("pokebola").add( "superball").add("poción"))	
		} 
		var JsonObject bulbasaurJson {
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
		var JsonObject ivysaurJson {
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
		
		repositorioEspecie.create(bulbasaur)
		repositorioEspecie.create(ivysaur)
		repositorioEspecie.create(pikachu)
		repositorioPokeparada.create(pokeparadaUNSAM)
		repositorioPokeparada.create(pokeparadaObelisco)
		repositorioPokeparada.create(pokeparadaDOT)
		repositorioPokeparada.create(jardinBotanico)
		
		repositorioEspecie.description = "Repo Especie"
		repositorioPokeparada.description = "Repo Pokeparada"
		
		repositorioEspecie.jsonParserEspecie = jsonParserEspecie
		repositorioPokeparada.jsonParserPokeparada = jsonParserPokeparada
				
		var RepositorioRepositorio = RepositorioRepositorio.instance
		RepositorioRepositorio.agregarRepos(repositorioPokeparada)
		RepositorioRepositorio.agregarRepos(repositorioEspecie)
		
		/*************************************************** POBLAR AREA *******************************************************************/
		
		/*************************************************** AREAS *******************************************************************/
		RepositorioArea.instance.agregarArea(
			new Rectangulo() => [
				nombre = "Unsam"
				punto1 = new Point(0.0,0.0)
				punto2 = new Point(0.1,0.2)
			]
		)
		
		RepositorioArea.instance.agregarArea(
			new Rectangulo() => [
				nombre = "Carrefour"
				punto1 = new Point(0.0,0.0)
				punto2 = new Point(0.2,0.2)
			]
		)
		
		RepositorioArea.instance.agregarArea(
			new Rectangulo() => [
				nombre = "Tecnopolis"
				punto1 = new Point(0.0,0.0)
				punto2 = new Point(0.2,0.2)
			]
		)
		
		
		
		//************************************************* ACCIONES ***************************************
		
		var RepositorioAcciones = RepositorioAcciones.instance
			RepositorioAcciones.agregarAcciones(new NotificarNivelMasAltoObserver())
			RepositorioAcciones.agregarAcciones(new NotificarNivelMultiploDe5Observer())
			RepositorioAcciones.agregarAcciones(new NotificarSuperaNivelObserver())
			RepositorioAcciones.agregarAcciones(new RecompensaNivelDeterminadoObserver())
		
//		#[notificarNivelmasAlto, notificarNivelMultiplo, notificarSuperaNivel, recompensaNivelDeterminado]



	}
	
	private def String getStringJson(JsonObject... jsonObjects){
		val JsonArray pokeparadasArray = Json.array().asArray
		jsonObjects.forEach[ jsonObject | pokeparadasArray.add(jsonObject) ]
		pokeparadasArray.toString
	}
	
}