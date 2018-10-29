package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Item
import ar.edu.unsam.algo3.tp.model.Pokeparada
import ar.edu.unsam.algo3.tp.model.RepositorioPokeparada
import ar.edu.unsam.algo3.tp.model.exception.DuplicadoExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ObjetoNoEncontradoExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ValidacionExcepcion
import ar.edu.unsam.algo3.tp.model.json.JsonParserPokeparada
import ar.edu.unsam.algo3.tp.model.serviciosExternos.JsonService
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.ParseException
import java.util.List
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

import static org.mockito.Mockito.*

class RepositorioPokeparadaTest extends TestHelper{
	
	
	JsonObject pokeparadaUNSAMJson = crearPokeparadaUNSAMJson
	
	RepositorioPokeparada repositorioPokeparada
	
	Pokeparada pokeparadaUNSAM
	Pokeparada pokeparadaObelisco
	
	Pokeparada pokeparadaQueNoEstaEnElRepositorio
	
	int idInexistenteEnElRepo = 99
	
	Pokeparada pokeparadaUNSAMActualizada
	Pokeparada pokeparadaUNSAMActualizadaItem
	Pokeparada pokeparadaObeliscoActualizada 
	Pokeparada pokeparadaDOT 
	Pokeparada pokeparadaJardinBotanico
	Pokeparada pokeparadaInvalida 
			
	@Before
	def void init(){
		repositorioPokeparada = getNewRepositorio
		initItems()
		
		pokeparadaUNSAM = crearPokeparadaUNSAM
		pokeparadaUNSAMActualizada = crearPokeparadaUNSAM
		pokeparadaUNSAMActualizada.nombre = "Pokeparada UNSAM Actualizada"
		pokeparadaUNSAMActualizadaItem = crearPokeparadaUNSAM
		pokeparadaUNSAMActualizadaItem.nombre = "Pokeparada UNSAM Actualizada"
		pokeparadaUNSAMActualizadaItem.items = newArrayList( repositorioPokeparada.getItemByNombre("pokebola") )
		pokeparadaObelisco = crearPokeparadaObelisco
		pokeparadaObeliscoActualizada = crearPokeparadaObelisco
		pokeparadaObeliscoActualizada.nombre = "Pokeparada obelisco Actualizada"
		pokeparadaDOT = crearPokeparadaDOT
		pokeparadaJardinBotanico = crearPokeparadaJardinBotanico
		pokeparadaInvalida = new Pokeparada
		pokeparadaInvalida.ubicacion = new Point(0.0,0.0)
		pokeparadaQueNoEstaEnElRepositorio = crearPokeparadaQueNoEstaEnElRepo
		repositorioPokeparada.create(pokeparadaUNSAM)
		repositorioPokeparada.create(pokeparadaObelisco)
		
		repositorioPokeparada.jsonParserPokeparada = new JsonParserPokeparada
	}
	
	def crearPokeparadaDOT() {
		new Pokeparada() => [
			ubicacion = new Point( -34.5542418 , -58.491549 )
			nombre = "Pokeparada DOT"
			items = obtenerItemsPorNombre( newArrayList( "pokebola","superball" , "poción") )
		] 
	}
	
	def obtenerItemsPorNombre(List<String> nombresDeItems ){
		nombresDeItems.map[ nombreDeItem |  repositorioPokeparada.getItemByNombre(nombreDeItem) ].toList
	}
	
	def crearPokeparadaJardinBotanico() {
		new Pokeparada() => [ 
			ubicacion = new Point( -34.5595298 , -58.491549 ) 
			nombre = "Pokeparada JardinBotanico" 
			items = obtenerItemsPorNombre( newArrayList( "pokebola" ,"superball" ,"poción") )
		]
	}
	
	def crearPokeparadaQueNoEstaEnElRepo() {
		new Pokeparada() => [
			ubicacion = new Point( -34.603321 , -58.381123 )
			nombre = "Pokeparada que no esta en el repositorio"
			items = obtenerItemsPorNombre( newArrayList("pokebola" , "superball" , "poción") )
		] 
	}
	
	def initItems() {
		repositorioPokeparada.agregarItem(new Item(1,"pokebola"))
		repositorioPokeparada.agregarItem(new Item(1,"superball"))
		repositorioPokeparada.agregarItem(new Item(1,"poción"))
		repositorioPokeparada.agregarItem(new Item(1,"ultraball"))
		repositorioPokeparada.agregarItem(new Item(1,"superpoción"))
		
	}
	
	def getNewRepositorio() {
		repositorioPokeparada = RepositorioPokeparada.instance
		repositorioPokeparada.clean
		repositorioPokeparada
	}
	
	def crearPokeparadaObelisco() {
		new Pokeparada() => [
			ubicacion = new Point( -34.603759 , -58.381586 )
			nombre = "Pokeparada obelisco"
			items =  obtenerItemsPorNombre( newArrayList( "pokebola" , "superball" ,"poción") )
		]
	}
	
	def crearPokeparadaUNSAM() {
		new Pokeparada() => [
			ubicacion = new Point( -34.572224 , -58.535651 )
			nombre = "Pokeparada UNSAM"
			items = obtenerItemsPorNombre( newArrayList( "pokebola" , "ultraball" ,"superpoción") )
		]
	}
	
	@Test
	def void testAgregarPokeparadaOk(){
		val cantidadObjetosAntesDelCreate = repositorioPokeparada.cantidadObjetos
		repositorioPokeparada.create(pokeparadaQueNoEstaEnElRepositorio)
		Assert.assertEquals( repositorioPokeparada.cantidadObjetos , cantidadObjetosAntesDelCreate + 1 )
	}
	
	@Test(expected=DuplicadoExcepcion)
	def void testAgregarPokeparadaQueYaExiste(){
		repositorioPokeparada.create(pokeparadaUNSAM)
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testAgregarPokeparadaFallaPorValidacion(){
		pokeparadaQueNoEstaEnElRepositorio.nombre = null
		repositorioPokeparada.create(pokeparadaQueNoEstaEnElRepositorio)
	}
	
	@Test
	def void testAgregarPokeparadaIncrementaId(){
		repositorioPokeparada.create(pokeparadaQueNoEstaEnElRepositorio)
		Assert.assertTrue( pokeparadaQueNoEstaEnElRepositorio.id > pokeparadaUNSAM.id )
	}
	
	@Test
	def void testEliminarPokeparadaOk(){
		val cantidadObjetosAntesDelDelete = repositorioPokeparada.cantidadObjetos
		repositorioPokeparada.delete(pokeparadaUNSAM)
		Assert.assertEquals( repositorioPokeparada.cantidadObjetos , cantidadObjetosAntesDelDelete -1 )
	}
	
	@Test(expected=ObjetoNoEncontradoExcepcion)
	def void testEliminarPokeparadaQueNoExiste(){
		pokeparadaQueNoEstaEnElRepositorio.id=idInexistenteEnElRepo
		repositorioPokeparada.delete(pokeparadaQueNoEstaEnElRepositorio)
	}
	
	@Test
	def void testEditarPokeparadaOk(){
		pokeparadaDOT.nombre = "Pokeparada DOT Baires Shopping"
		repositorioPokeparada.create(pokeparadaDOT)
		repositorioPokeparada.update(pokeparadaDOT)
		
		Assert.assertEquals( pokeparadaDOT , repositorioPokeparada.searchPorCriterioUnico( pokeparadaDOT ) )
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testEditarPokeparadaInconsistenteFalla(){
		pokeparadaQueNoEstaEnElRepositorio.nombre = null
		repositorioPokeparada.update(pokeparadaQueNoEstaEnElRepositorio)
	}
	
	@Test
	def void testBuscarPokeparadaPorIdOk(){
		Assert.assertEquals( pokeparadaUNSAM , repositorioPokeparada.searchById( pokeparadaUNSAM.id ) )
	}
	
	@Test
	def void testBuscarPokeparadaPorIdObjetoQueNoExiste(){
		Assert.assertNull( repositorioPokeparada.searchById( idInexistenteEnElRepo ) )
	}
	
	@Test
	def void testBuscarPokeparadaPorValor1ResultadoOk(){
		Assert.assertEquals( 1 , repositorioPokeparada.search("UNSAM").size , 0.0 )
	}
	
	@Test
	def void testBuscarPokeparadaPorValorVariosResultadosOk(){
		Assert.assertEquals( 2 , repositorioPokeparada.search("Pokeparada").size , 0.0 )
	}
	
	@Test
	def void testBuscarPokeparadaPorValorQueNoExiste(){
		Assert.assertTrue( repositorioPokeparada.search("ValorQueNoExiste").isEmpty )
	}
	
	/*
	 * Test de actualizacion
	 */
	
	@Test
	def void testActualizacionActualiza1Pokeparada(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizada))
		Assert.assertEquals( 
			pokeparadaUNSAMActualizada.nombre , 
			repositorioPokeparada.findByCoordenadas( pokeparadaUNSAMActualizada.ubicacion ).nombre
		)
	}
	
	@Test
	def void testActualizacionActualizaItems1Pokeparada(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizadaItem))
		Assert.assertEquals( 
			pokeparadaUNSAMActualizadaItem.items.get(0) , 
			repositorioPokeparada.findByCoordenadas( pokeparadaUNSAMActualizadaItem.ubicacion ).items.get(0)
		)
	}
	
	@Test
	def void testActualizacionActualiza2Pokeparadas(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizada , pokeparadaObeliscoActualizada))
		Assert.assertEquals( 
			pokeparadaUNSAMActualizada.nombre , 
			repositorioPokeparada.findByCoordenadas( pokeparadaUNSAMActualizada.ubicacion ).nombre
		)
	}
	
	@Test
	def void testActualizacionCrea1Pokeparada(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaDOT))
		Assert.assertEquals( 
			pokeparadaDOT.nombre , 
			repositorioPokeparada.findByCoordenadas( pokeparadaDOT.ubicacion ).nombre
		)
	}
	
	@Test
	def void testActualizacionCreaPokeparadas(){
		val cantidadObjectosAntesDelInsert = repositorioPokeparada.cantidadObjetos
		repositorioPokeparada.actualizar(newArrayList(pokeparadaDOT,pokeparadaJardinBotanico))
		Assert.assertEquals( cantidadObjectosAntesDelInsert + 2 , repositorioPokeparada.cantidadObjetos , 0.0 )
	}
	
	@Test
	def void testActualizacionCreaYActualizaPokeparadasCrea1PokeparadaMas(){
		val cantidadObjectosAntesDelInsert = repositorioPokeparada.cantidadObjetos
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizada,pokeparadaDOT))
		Assert.assertEquals( cantidadObjectosAntesDelInsert + 1 , repositorioPokeparada.cantidadObjetos , 0.0 )
	}
	
	@Test
	def void testActualizacionCreaYActualizaPokeparadasCreaBien(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizada,pokeparadaDOT))
		Assert.assertEquals( 
			pokeparadaDOT.nombre , 
			repositorioPokeparada.findByCoordenadas( pokeparadaDOT.ubicacion ).nombre
		)
	}
	
	@Test
	def void testActualizacionCreaYActualizaPokeparadasActualizaBien(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaUNSAMActualizada,pokeparadaDOT))
		Assert.assertEquals( 
			pokeparadaUNSAMActualizada.nombre , 
			repositorioPokeparada.findByCoordenadas( pokeparadaUNSAMActualizada.ubicacion ).nombre
		)
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testActualizacionPokeparadaInvalida(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaInvalida))
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testActualizacionPokeparadaInvalidaYActualizaPokeparadaValida(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaInvalida,pokeparadaUNSAMActualizada))
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testActualizacionPokeparadaInvalidaYCreaPokeparadaValida(){
		repositorioPokeparada.actualizar(newArrayList(pokeparadaInvalida,pokeparadaDOT))
	}

	@Test
	def void actualizarPokeparada(){
		repositorioPokeparada.actualizar( newArrayList( pokeparadaUNSAM ) )
		Assert.assertEquals(pokeparadaUNSAM,repositorioPokeparada.searchPorCriterioUnico(pokeparadaUNSAM)) 
	}
	
	@Test 
	def void actualizarPokeparadaCrear(){
		repositorioPokeparada.actualizar( newArrayList(pokeparadaQueNoEstaEnElRepositorio) )
		Assert.assertEquals(
			pokeparadaQueNoEstaEnElRepositorio,
			repositorioPokeparada.searchPorCriterioUnico(pokeparadaQueNoEstaEnElRepositorio)
		) 
	}
	
	/*
	 * Test de UpdateAll
	 */

	def mockearServidor(String json) {
		val servidorMockeado = mock(typeof(JsonService)) 
		when(servidorMockeado.getJsonPokeparada).thenReturn(json)
		repositorioPokeparada.jsonService = servidorMockeado
	}
	
	@Test
	def void testUpdateAllActualiza1Pokeparada(){
		var JsonArray pokeparadaUNSAMJSONObject = Json.array.asArray.add( crearPokeparadaUNSAMJson )
		val String pokeparadaUnsamJsonString = pokeparadaUNSAMJSONObject.toString
		mockearServidor(pokeparadaUnsamJsonString)
		repositorioPokeparada.updateAll
		Assert.assertEquals( 
			pokeparadaUNSAMJSONObject.get(0).asObject.get("nombre").asString , 
			repositorioPokeparada.findByCoordenadas( 
				new Point( 	pokeparadaUNSAMJSONObject.get(0).asObject.get("x").asDouble , 
							pokeparadaUNSAMJSONObject.get(0).asObject.get("y").asDouble
				)
			).nombre
		)
	}
	
	
	def mockearServidorException(String json) {
		val servidorMockeado = mock(typeof(JsonService)) 
		when(servidorMockeado.getJsonPokeparada).thenReturn("Error en la validacion")
		repositorioPokeparada.jsonService = servidorMockeado
	}
	
	@Test
	def void testUpdateAllActualizaItems1Pokeparada(){
		var JsonArray pokeparadaUNSAMJSONObject = Json.array.asArray.add(crearPokeparadaUNSAMJson)
		pokeparadaUNSAMJSONObject.get(0).asObject.get("itemsDisponibles").asArray.remove(0)
		val String pokeparadaUNSAMJsonString = pokeparadaUNSAMJSONObject.toString
		
		mockearServidor(pokeparadaUNSAMJsonString) 
		repositorioPokeparada.updateAll
		
		Assert.assertEquals(pokeparadaUNSAMJSONObject.get(0).asObject.get("itemsDisponibles").asArray.size,
			repositorioPokeparada.findByCoordenadas(
				new Point(
					pokeparadaUNSAMJSONObject.get(0).asObject.get("x").asDouble, 
					pokeparadaUNSAMJSONObject.get(0).asObject.get("y").asDouble
				) 
			).items.size
		)
	}
	
	@Test
	def void testUpdateAllActualiza2Pokeparadas(){
		var JsonArray pokeparadasActualizarJSONObject = Json.array.asArray.add(crearPokeparadaUNSAMactualizadaJson).add(crearPokeparadaObeliscoJson)
		val String pokeparadasJsonString = pokeparadasActualizarJSONObject.toString
		mockearServidor(pokeparadasJsonString)
		repositorioPokeparada.updateAll
		Assert.assertEquals( 
			pokeparadasActualizarJSONObject.get(0).asObject.get("nombre").asString,  
			repositorioPokeparada.findByCoordenadas(
				new Point (
					pokeparadasActualizarJSONObject.get(0).asObject.get("x").asDouble,
					pokeparadasActualizarJSONObject.get(0).asObject.get("y").asDouble
				)
				).nombre
		)
	}
	
	@Test
	def void testUpdateAllCrea1Pokeparada(){
		var JsonArray pokeparadaQueNoEstaEnElRepoObject = Json.array.asArray.add(crearPokeparadaDOTJson)
		val String pokeparadaQueNoEstaEnElRepoString = pokeparadaQueNoEstaEnElRepoObject.toString
		mockearServidor(pokeparadaQueNoEstaEnElRepoString)
		repositorioPokeparada.updateAll
		Assert.assertEquals(pokeparadaQueNoEstaEnElRepoObject.get(0).asObject.get("nombre").asString, repositorioPokeparada.findByCoordenadas(
			new Point (
				pokeparadaQueNoEstaEnElRepoObject.get(0).asObject.get("x").asDouble,
				pokeparadaQueNoEstaEnElRepoObject.get(0).asObject.get("y").asDouble
				)
			).nombre
		)
	}
	
	@Test
	def void testUpdateAllCreaPokeparadas(){
//		repositorioPokeparada.actualizar(newArrayList(pokeparadaDOT,pokeparadaJardinBotanico))
		var JsonArray pokeparadasActualizarJSONObject = Json.array.asArray().add(crearPokeparadaDOTJson).add(crearPokeparadaJardinBotanicoJson)
		var String pokeparadasActualizarString = pokeparadasActualizarJSONObject.toString
		mockearServidor(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
		Assert.assertEquals( pokeparadasActualizarJSONObject.size +2, repositorioPokeparada.cantidadObjetos)
	}
	
	@Test
	def void testUpdateAllCreaYActualizaPokeparadasCrea1PokeparadaMas(){
		val cantidadObjectosAntesDelInsert = repositorioPokeparada.cantidadObjetos
		var JsonArray pokeparadasActualizarYCreaJSONObject = Json.array.asArray().add(crearPokeparadaUNSAMactualizadaJson).add(crearPokeparadaDOTJson)
		val String pokeparadasActualizarString = pokeparadasActualizarYCreaJSONObject.toString
		mockearServidor(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
		Assert.assertEquals( cantidadObjectosAntesDelInsert +1, repositorioPokeparada.cantidadObjetos)
	}//ver xq no acumula la cantidad de objetos, inicia en 2 y tendria que ser 3 
	
	@Test
	def void testUpdateAllCreaYActualizaPokeparadasCreaBien(){
		var JsonArray pokeparadasCreaYActualizaJSONObject = Json.array.asArray().add(crearPokeparadaQueNoEstaEnElRepoJson).add(crearPokeparadaDOTJson)
		val String pokeparadasActualizarString = pokeparadasCreaYActualizaJSONObject.toString
		mockearServidor(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
		Assert.assertEquals(pokeparadasCreaYActualizaJSONObject.get(0).asObject.get("nombre").asString, repositorioPokeparada.findByCoordenadas(
			new Point (
				pokeparadasCreaYActualizaJSONObject.get(0).asObject.get("x").asDouble,
				pokeparadasCreaYActualizaJSONObject.get(0).asObject.get("y").asDouble
				)
			).nombre
		)
	}
	
	@Test
	def void testUpdateAllCreaYActualizaPokeparadasActualizaBien(){
		var JsonArray pokeparadasCreaYActualizaJSONObject = Json.array.asArray().add(crearPokeparadaQueNoEstaEnElRepoJson).add(crearPokeparadaDOTJson)
		val String pokeparadasActualizarString = pokeparadasCreaYActualizaJSONObject.toString
		mockearServidor(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
		Assert.assertEquals(pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("nombre").asString, repositorioPokeparada.findByCoordenadas(
			new Point (
				pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("x").asDouble,
				pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("y").asDouble
				)
			).nombre
		)
	}
	
	  @Test(expected=ParseException)
	def void testUpdateAllPokeparadaInvalida(){
		var JsonArray pokeparadasCreaYActualizaJSONObject = Json.array.asArray().add(crearPokeparadaQueNoEstaEnElRepoJson)
		val String pokeparadasActualizarString = pokeparadasCreaYActualizaJSONObject.toString
		mockearServidorException(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
	}
	
	@Test(expected=ParseException)
	def void testUpdateAllPokeparadaInvalidaYActualizaPokeparadaValida(){
		var JsonArray pokeparadasCreaYActualizaJSONObject = Json.array.asArray().add(crearPokeparadaConCoordenadasMalJson).add(crearPokeparadaDOTJson)
		pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("itemsDisponibles").asArray.remove(0)
		val String pokeparadasActualizarString = pokeparadasCreaYActualizaJSONObject.toString
		mockearServidorException(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
		Assert.assertEquals(pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("itemsDisponibles").asArray.size,
			repositorioPokeparada.findByCoordenadas(
				new Point(
					pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("x").asDouble, 
					pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("y").asDouble
				) 
			).items.size
		)
	}
	
	@Test(expected=ParseException)
	def void testUpdateAllPokeparadaInvalidaYCreaPokeparadaValida(){
		var JsonArray pokeparadasCreaYActualizaJSONObject = Json.array.asArray().add(crearPokeparadaConCoordenadasMalJson).add(crearPokeparadaDOTJson)
		val String pokeparadasActualizarString = pokeparadasCreaYActualizaJSONObject.toString
		pokeparadasCreaYActualizaJSONObject.get(1).asObject.get("itemsDisponibles").asArray.remove(0)
		mockearServidorException(pokeparadasActualizarString)
		repositorioPokeparada.updateAll
	}

}
