package ar.edu.unsam.algo2.tp.test.json

import ar.edu.unsam.algo2.tp.test.TestHelper
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Item
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.RepositorioPokeparada
import ar.edu.unsam.algo3.tp.model.Tipo
import ar.edu.unsam.algo3.tp.model.json.JsonParserEspecie
import ar.edu.unsam.algo3.tp.model.json.JsonParserPokeparada
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.ParseException
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JsonParserTest extends TestHelper{
	
	JsonParserPokeparada jsonParserPokeparada = new JsonParserPokeparada
	JsonParserEspecie jsonParserEspecie = new JsonParserEspecie
	
	JsonObject pokeparadaUNSAMJson
	JsonObject pokeparadaObeliscoJson 
	JsonObject pokeparadaConCoordenadasMal 
	JsonObject pokeparadaConItemQueNoExiste 
	JsonObject pokeparadaSinUnAtributo 
	
	JsonObject bulbasaurJson
	JsonObject ivysaurJson 
	JsonObject especieConElNumeroMal 
	JsonObject especieConTipoQueNoExiste
	JsonObject especieSinUnAtributo
	
	@Before
	def void  init(){
		pokeparadaUNSAMJson = crearPokeparadaUNSAMJson
		pokeparadaObeliscoJson = crearPokeparadaObeliscoJson
		pokeparadaConCoordenadasMal = crearPokeparadaConCoordenadasMalJson
		pokeparadaConItemQueNoExiste = crearPokeparadaConItemQueNoExisteJson
		pokeparadaSinUnAtributo = crearPokeparadaUNSAMJson.remove("nombre")
		 
		initItems()
		
		bulbasaurJson = crearBulbasaurJson
		ivysaurJson = crearIvysaurJson
		especieConElNumeroMal = crearEspecieConElNumeroMal
		especieConTipoQueNoExiste = crearEspecieConTipoQueNoExisteJson
		especieSinUnAtributo = crearEspecieSinUnAtributoJson
		
		initTipos()
	}	
	
	def initTipos() {
		RepositorioEspecie.instance.agregarTipo(new Tipo("hierba"))
		RepositorioEspecie.instance.agregarTipo(new Tipo("veneno"))
		RepositorioEspecie.instance.agregarTipo(new Tipo("electricidad"))
		RepositorioEspecie.instance.agregarTipo(new Tipo("fuego"))
	}
	
	def initItems() {
		RepositorioPokeparada.instance.agregarItem(new Item(1,"pokebola"))
		RepositorioPokeparada.instance.agregarItem(new Item(1,"superball"))
		RepositorioPokeparada.instance.agregarItem(new Item(1,"poción"))
		RepositorioPokeparada.instance.agregarItem(new Item(1,"ultraball"))
		RepositorioPokeparada.instance.agregarItem(new Item(1,"superpoción"))
	}
	
	
	def String getStringJson(JsonObject... jsonObjects){
		val JsonArray pokeparadasArray = Json.array().asArray
		jsonObjects.forEach[ jsonObject | pokeparadasArray.add(jsonObject) ]
		pokeparadasArray.toString
	}
		
	@Test
	def void  testParserPokeparadaOk(){
		Assert.assertEquals( 1 , jsonParserPokeparada.parsearPokeparadas( getStringJson(pokeparadaUNSAMJson) ).size , 0.0 )
	}
	
	@Test
	def void  testParser2PokeparadasOk(){
		Assert.assertEquals( 2 , jsonParserPokeparada.parsearPokeparadas( getStringJson(pokeparadaUNSAMJson,pokeparadaObeliscoJson) ).size , 0.0 )
	}
	
	@Test(expected=ParseException)
	def void  testParserPokeparadaVacio(){
		jsonParserPokeparada.parsearPokeparadas("")
	}
	
	
	@Test
	def void  testParserPokeparadaLatitud(){
		val pokeparada = jsonParserPokeparada.parsearPokeparadas( getStringJson(pokeparadaUNSAMJson) )
		.findFirst[ pokeparada | pokeparada.nombre.equals(pokeparadaUNSAMJson.get("nombre").asString) ]
		Assert.assertEquals( pokeparadaUNSAMJson.get("x").asDouble , pokeparada.ubicacion.latitude , 0.0)
	}
	
	@Test
	def void  testParserPokeparadaLongitud(){
		val pokeparada = jsonParserPokeparada.parsearPokeparadas(getStringJson(pokeparadaUNSAMJson))
		.findFirst[ pokeparada | pokeparada.nombre.equals(pokeparadaUNSAMJson.get("nombre").asString) ]
		Assert.assertEquals( pokeparadaUNSAMJson.get("y").asDouble , pokeparada.ubicacion.longitude , 0.0 )
	}
	
	@Test
	def void  testParserPokeparadaNombre(){
		val pokeparada = jsonParserPokeparada.parsearPokeparadas(getStringJson(pokeparadaUNSAMJson))
		.findFirst[ pokeparada | pokeparada.nombre.equals(pokeparadaUNSAMJson.get("nombre").asString) ]
		Assert.assertEquals( pokeparadaUNSAMJson.get("nombre").asString , pokeparada.nombre )
	}
	
	@Test
	def void  testParserPokeparadaCantidadItems(){
		val pokeparada = jsonParserPokeparada.parsearPokeparadas(getStringJson(pokeparadaUNSAMJson)).
		findFirst[ pokeparada | pokeparada.nombre.equals(pokeparadaUNSAMJson.get("nombre").asString) ]
		Assert.assertEquals( pokeparadaUNSAMJson.get("itemsDisponibles").asArray.size , pokeparada.items.size )
	}
	
	@Test(expected=UnsupportedOperationException)
	def void  testParserPokeparadaConCoordenadasIncorrectas(){
		jsonParserPokeparada.parsearPokeparadas(getStringJson(pokeparadaConCoordenadasMal))
	}
	
	@Test
	def void  testParserPokeparadaConItemQueNoExisten(){
		val pokeparada = jsonParserPokeparada.parsearPokeparadas( getStringJson(pokeparadaConItemQueNoExiste) ).
		findFirst[ pokeparada | pokeparada.nombre.equals(pokeparadaConItemQueNoExiste.get("nombre").asString) ]
		Assert.assertEquals( 0 , pokeparada.items.size )
	}
	
	@Test(expected=NullPointerException)
	def void  testParserPokeparadaSinUnAtributo(){
		jsonParserPokeparada.parsearPokeparadas( getStringJson(pokeparadaSinUnAtributo) )
	}
	
	/* Test parser especie */
	
	@Test
	def void  testParser2EspeciesOk(){
		Assert.assertEquals( 2 , jsonParserEspecie.parsearEspecies( getStringJson(bulbasaurJson,ivysaurJson) ).size , 0.0 )
	}
	
	@Test(expected=ParseException)
	def void  testParserEspecieVacio(){
		jsonParserEspecie.parsearEspecies("")
	}
	
	@Test
	def void  testParserEspecieConTipoQueNoExiste(){
		val especie = jsonParserEspecie.parsearEspecies( getStringJson(especieConTipoQueNoExiste) ).
		findFirst[ especie | especie.numero == especieConTipoQueNoExiste.get("numero").asInt ]
		Assert.assertEquals( 1 , especie.tipos.size )
	}
	
	@Test
	def void  testParserEspecieNumero(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("numero").asInt , bulbasaur.numero )
	}
	
	def parsearBulbasaur() {
		jsonParserEspecie.parsearEspecies(getStringJson(bulbasaurJson)).findFirst[ especie | especie.numero == bulbasaurJson.get("numero").asInt ]
	}
	
	@Test
	def void  testParserEspecieNombre(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("nombre").asString , bulbasaur.nombre )
	}
	
	@Test
	def void  testParserEspeciePuntosAtaque(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("puntosAtaqueBase").asInt , bulbasaur.puntosAtaque )
	}
	
	@Test
	def void  testParserEspeciePuntosSalud(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("puntosSaludBase").asInt , bulbasaur.puntosSalud )
	}
	
	@Test
	def void  testParserEspecieDescrpicion(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("descripcion").asString , bulbasaur.descripcion )
	}
	
	@Test
	def void  testParserEspecieTipos(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("tipos").asArray.size , bulbasaur.tipos.size )
	}
	
	@Test
	def void  testParserEspecieVelocidad(){
		val bulbasaur = parsearBulbasaur
		Assert.assertEquals( bulbasaurJson.get("velocidad").asInt , bulbasaur.velocidad )
	}
	
	@Test
	def void  testParserEspecieEvolucion(){
		val List<Especie> especies = jsonParserEspecie.parsearEspecies( getStringJson(bulbasaurJson,ivysaurJson) )
		val bulbasaurParseado = especies.findFirst[ especie | especie.numero == bulbasaurJson.get("numero").asInt ]
		Assert.assertEquals( bulbasaurJson.get("evolucion").asInt , bulbasaurParseado.especieEvolucion.numero )
	}
	
	@Test(expected=UnsupportedOperationException)
	def void  testParserIntComoString(){
		jsonParserEspecie.parsearEspecies( getStringJson(especieConElNumeroMal) )
	}
	
	@Test(expected=NullPointerException)
	def void  testParserEspecieSinUnAtributo(){
		jsonParserEspecie.parsearEspecies( getStringJson(especieSinUnAtributo) )
	}
	
}