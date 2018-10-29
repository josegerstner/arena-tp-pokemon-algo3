package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.Tipo
import ar.edu.unsam.algo3.tp.model.exception.DuplicadoExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ObjetoNoEncontradoExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ValidacionExcepcion
import ar.edu.unsam.algo3.tp.model.json.JsonParserEspecie
import ar.edu.unsam.algo3.tp.model.serviciosExternos.JsonService
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static org.mockito.Mockito.*

class RepositorioEspecieTest extends TestHelper {

	Especie bulbasaur
	Especie ivysaur
	Especie pikachu
	Especie bulbasaurActualizado
	Especie bulbasaurActualizadoTipos
	Especie ivysaurActualizado
	Especie charmander
	Especie especieInvalida

	int idInexistenteEnElRepo = 99

	@Before
	def void init() {
		repositorioEspecie = newRepositorio
		initTipos()

		bulbasaur = crearBulbasaur
		ivysaur = crearIzysaur
		pikachu = crearPikachu
		bulbasaurActualizado = crearBulbasaur
		bulbasaurActualizado.nombre = "Bulbasaur actualizado"
		bulbasaurActualizadoTipos = crearBulbasaur
		bulbasaurActualizadoTipos.nombre = "Bulbasaur actualizado"
		bulbasaurActualizadoTipos.tipos = newArrayList(repositorioEspecie.getTipoByNombre("veneno"))
		ivysaurActualizado = crearIzysaur
		ivysaurActualizado.nombre = "Ivysaur Actualizado"
		charmander = crearCharmander
		especieInvalida = new Especie

		repositorioEspecie.create(bulbasaur)
		repositorioEspecie.create(ivysaur)
		
		repositorioEspecie.jsonParserEspecie = new JsonParserEspecie

	}
	
	def crearPikachu() {
		new Especie() => [
			numero = 25
			nombre = "Pikachu"
			puntosAtaque = 20
			puntosSalud = 25
			descripcion = "Es un pikachu que no esta en el repo"
			tipos = newArrayList(repositorioEspecie.getTipoByNombre("electricidad"))
			velocidad = 5
		]
	}
	
	def crearCharmander() {
		new Especie() => [
			numero = 32
			nombre = "Charmander"
			puntosAtaque = 40
			puntosSalud = 45
			descripcion = "Es un charmander que no esta en el repo"
			tipos = newArrayList(repositorioEspecie.getTipoByNombre("fuego"))
			velocidad = 9
		]
	}

	def initTipos() {
		repositorioEspecie.agregarTipo(new Tipo("hierba"))
		repositorioEspecie.agregarTipo(new Tipo("veneno"))
		repositorioEspecie.agregarTipo(new Tipo("electricidad"))
		repositorioEspecie.agregarTipo(new Tipo("fuego"))
	}

	def getNewRepositorio() {
		repositorioEspecie = RepositorioEspecie.instance
		repositorioEspecie.clean
		repositorioEspecie
	}

	@Test
	def void testAgregarEspecieOk() {
		val cantidadObjetosAntesDeCrear = repositorioEspecie.cantidadObjetos
		repositorioEspecie.create(pikachu)
		Assert.assertEquals(cantidadObjetosAntesDeCrear + 1, repositorioEspecie.cantidadObjetos)
	}
	
	@Test(expected=DuplicadoExcepcion)
	def void testAgregarEspecieQueYaExiste() {
		repositorioEspecie.create(bulbasaur)
	}

	@Test(expected=ValidacionExcepcion)
	def void testAgregarEspecieFallaPorValidacion() {
		pikachu.puntosAtaque = 0
		repositorioEspecie.create(pikachu)
	}

	@Test
	def void testAgregarEspecieIncrementaId() {
		repositorioEspecie.create(pikachu)
		Assert.assertTrue(pikachu.id > bulbasaur.id)
	}

	@Test
	def void testEliminarEspecieOk() {
		val cantidadObjetosAntesDeEliminar = repositorioEspecie.cantidadObjetos
		repositorioEspecie.delete(bulbasaur)
		Assert.assertEquals(cantidadObjetosAntesDeEliminar - 1, repositorioEspecie.cantidadObjetos)
	}

	@Test(expected=ObjetoNoEncontradoExcepcion)
	def void testEliminarEspecieQueNoExiste() {
		pikachu.id = idInexistenteEnElRepo
		repositorioEspecie.delete(pikachu)
	}

	@Test
	def void testEditarEspecieOk() {
		bulbasaur.numero = 5
		repositorioEspecie.update(bulbasaur)

		Assert.assertEquals(bulbasaur, repositorioEspecie.searchByNumero(bulbasaur.numero))
	}

	@Test(expected=ValidacionExcepcion)
	def void testEditarEspecieInconsistenteFalla() {
		pikachu.puntosAtaque = 0
		repositorioEspecie.update(pikachu)
	}

	@Test
	def void testBuscarEspeciePorIdOk() {
		Assert.assertEquals(bulbasaur, repositorioEspecie.searchById(bulbasaur.id))
	}

	@Test
	def void testBuscarEspeciePorIdObjetoQueNoExiste() {
		Assert.assertNull(repositorioEspecie.searchById(idInexistenteEnElRepo))
	}

	@Test
	def void testBuscarEspeciePorValor1ResultadoOk() {
		Assert.assertEquals(1, repositorioEspecie.search("Bulbasaur").size, 0.0)
	}

	@Test
	def void testBuscarEspeciePorValorVariosResultadosOk() {
		Assert.assertEquals(2, repositorioEspecie.search("pokemon").size, 0.0)
	}

	@Test
	def void testBuscarEspeciePorValorQueNoExiste() {
		Assert.assertTrue(repositorioEspecie.search("ValorQueNoExiste").isEmpty)
	}

	/*
	 * Test de actualizacion
	 */
	@Test
	def void testActualizacionActualiza1Especie() {
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizado))
		Assert.assertEquals(bulbasaurActualizado.nombre,
			repositorioEspecie.searchByNumero(bulbasaurActualizado.numero).nombre)
	}

	@Test
	def void testActualizacionActualizaTipos1Especie() {
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizadoTipos))
		Assert.assertEquals(bulbasaurActualizadoTipos.tipos.get(0),
			repositorioEspecie.searchPorCriterioUnico(bulbasaurActualizadoTipos).tipos.get(0))
	}

	@Test
	def void testActualizacionActualiza2Especies() {
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizado, ivysaurActualizado))
		Assert.assertEquals(bulbasaurActualizado.nombre,
			repositorioEspecie.searchByNumero(bulbasaurActualizado.numero).nombre)
	}

	@Test
	def void testActualizacionCrea1Especie() {
		repositorioEspecie.actualizar(newArrayList(pikachu))
		Assert.assertEquals(pikachu.nombre, repositorioEspecie.searchPorCriterioUnico(pikachu).nombre)
	}

	@Test
	def void testActualizacionCreaEspecies() {
		val cantidadObjectosAntesDelInsert = repositorioEspecie.cantidadObjetos
		repositorioEspecie.actualizar(newArrayList(pikachu, charmander))
		Assert.assertEquals(cantidadObjectosAntesDelInsert + 2, repositorioEspecie.cantidadObjetos, 0.0)
	}

	@Test
	def void testActualizacionCreaYActualizaEspeciesCrea1EspecieMas() {
		val cantidadObjectosAntesDelInsert = repositorioEspecie.cantidadObjetos
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizado, pikachu))
		Assert.assertEquals(cantidadObjectosAntesDelInsert + 1, repositorioEspecie.cantidadObjetos, 0.0)
	}

	@Test
	def void testActualizacionCreaYActualizaEspeciesCreaBien() {
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizado, pikachu))
		Assert.assertEquals(pikachu.nombre, repositorioEspecie.searchPorCriterioUnico(pikachu).nombre)
	}

	@Test
	def void testActualizacionCreaYActualizaEspeciesActualizaBien() {
		repositorioEspecie.actualizar(newArrayList(bulbasaurActualizado, pikachu))
		Assert.assertEquals(bulbasaurActualizado.nombre,
			repositorioEspecie.searchPorCriterioUnico(bulbasaurActualizado).nombre)
	}

	@Test(expected=ValidacionExcepcion)
	def void testActualizacionEspecieInvalida() {
		repositorioEspecie.actualizar(newArrayList(especieInvalida))
	}

	@Test(expected=ValidacionExcepcion)
	def void testActualizacionEspecieInvalidaYActualizaEspecieValida() {
		repositorioEspecie.actualizar(newArrayList(especieInvalida, bulbasaurActualizado))
	}

	@Test(expected=ValidacionExcepcion)
	def void testActualizacionEspecieInvalidaYCreaEspecieValida() {
		repositorioEspecie.actualizar(newArrayList(especieInvalida, pikachu))
		Assert.assertEquals(pikachu.nombre, repositorioEspecie.searchPorCriterioUnico(pikachu).nombre)
	}
	
	/*
	 * Test de UpdateAll
	 */
	 
	 def mockearServidor(String json) {
		
		val servidorMockeado = mock(typeof(JsonService)) 
		when(servidorMockeado.getJsonEspecie).thenReturn(json)
		repositorioEspecie.jsonService = servidorMockeado
	}
	 
	@Test
	def void testUpdateAllActualiza1Especie() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(0).asObject.get("nombre").asString,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(0).asObject.get("numero").asInt).nombre)
	}

	@Test
	def void testUpdateAllActualizaTipos1Especie() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson)
		especieActulizarJsonObject.get(0).asObject.get("tipos").asArray.remove(0)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(0).asObject.get("tipos").asArray.size,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(0).asObject.get("numero").asInt).tipos.size)
	}

	@Test
	def void testUpdateAllActualiza2Especies() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson).add(crearIvysaurJson)
		especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.remove(0)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.size,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(1).asObject.get("numero").asInt).tipos.size)
	}

	@Test
	def void testUpdateAllCrea1Especie() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(0).asObject.get("nombre").asString,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(0).asObject.get("numero").asInt).nombre)
	}
	

	@Test
	def void testUpdateAllCreaEspecies() {
		val cantidadObjectosAntesDelInsert = repositorioEspecie.cantidadObjetos
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearPikachuJson).add(crearCharmanderJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(cantidadObjectosAntesDelInsert + 2, repositorioEspecie.cantidadObjetos, 0.0)
	}

	@Test
	def void testUpdateAllCreaYActualizaEspeciesCrea1EspecieMas() {
		val cantidadObjectosAntesDelInsert = repositorioEspecie.cantidadObjetos
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearPikachuJson).add(crearIvysaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(cantidadObjectosAntesDelInsert + 1, repositorioEspecie.cantidadObjetos, 0.0)
	}

	@Test
	def void testUpdateAllCreaYActualizaEspeciesCreaBien() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearPikachuJson).add(crearIvysaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(0).asObject.get("nombre").asString,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(0).asObject.get("numero").asInt).nombre)
	}

	@Test
	def void testUpdateAllCreaYActualizaEspeciesActualizaBien() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearPikachuJson).add(crearIvysaurJson)
		especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.remove(0)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.size,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(1).asObject.get("numero").asInt).tipos.size)
	}

	@Test(expected=UnsupportedOperationException)
	def void testUpdateAllEspecieInvalida() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearEspecieConElNumeroMal)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
	}

	@Test(expected=UnsupportedOperationException)
	def void testUpdateAllEspecieInvalidaYActualizaEspecieValida() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearEspecieConElNumeroMal).add(crearIvysaurJson)
		especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.remove(0)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.size,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(1).asObject.get("numero").asInt).tipos.size)
	}

	@Test(expected=UnsupportedOperationException)
	def void testUpdateAllEspecieInvalidaYCreaEspecieValida() {
var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearEspecieConElNumeroMal).add(crearCharmanderJson)
		especieActulizarJsonObject.get(1).asObject.get("tipos").asArray.remove(0)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		repositorioEspecie.updateAll
		Assert.assertEquals(especieActulizarJsonObject.get(1).asObject.get("nombre").asString,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(1).asObject.get("numero").asInt).nombre)
	}
	
	
}
