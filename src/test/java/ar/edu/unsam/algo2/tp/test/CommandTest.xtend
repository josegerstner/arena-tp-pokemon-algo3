package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.RepositorioEntrenador
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.RepositorioPokemon
import ar.edu.unsam.algo3.tp.model.Tipo
import ar.edu.unsam.algo3.tp.model.command.Actualizacion
import ar.edu.unsam.algo3.tp.model.command.AgregarAcciones
import ar.edu.unsam.algo3.tp.model.command.ComandoMultiple
import ar.edu.unsam.algo3.tp.model.command.PoblarArea
import ar.edu.unsam.algo3.tp.model.command.Rectangulo
import ar.edu.unsam.algo3.tp.model.json.JsonParserEspecie
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMasAltoObserver
import ar.edu.unsam.algo3.tp.model.serviciosExternos.JsonService
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import java.util.HashSet
import java.util.Set
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

import static org.mockito.Mockito.*

class CommandTest extends TestHelper{

	RepositorioEspecie repositorioEspecie = RepositorioEspecie.instance
	Actualizacion actualizacion
	AgregarAcciones agregarAcciones
	Set<Especie> especiesTest = new HashSet()
	Rectangulo rectanguloTest
	PoblarArea poblarArea
	ComandoMultiple comandoMultiple
		
	@Before
	def void init() {
		repositorioEspecie.jsonParserEspecie = new JsonParserEspecie
		initTipos()
		
		especiesTest.add( crearBulbasaur )
		especiesTest.add( crearIzysaur )
		
		actualizacion = new Actualizacion( newArrayList(repositorioEspecie) )
		
		rectanguloTest = new Rectangulo() =>[
				
				punto1 = new Point( 0.0 , 0.0 )
				punto2 = new Point( 1.0 , 1.0 )
				
			]
		
		poblarArea = new PoblarArea () => [
			
			rectangulo = rectanguloTest			
			
			especies = especiesTest
			
			nivelMinimo = 1
			nivelMaximo = 5
			densidad = 1
			
		]
		
		comandoMultiple = new ComandoMultiple( newArrayList( actualizacion , poblarArea ) )
		
		RepositorioPokemon.instance.clear
		
		agregarAcciones = new AgregarAcciones( newArrayList( new NotificarNivelMasAltoObserver() ) )
		
	}
	
	def initTipos() {
		repositorioEspecie.agregarTipo(new Tipo("hierba"))
		repositorioEspecie.agregarTipo(new Tipo("veneno"))
		repositorioEspecie.agregarTipo(new Tipo("electricidad"))
		repositorioEspecie.agregarTipo(new Tipo("fuego"))
	}
	
	def mockearServidor(String json) {
		
		val servidorMockeado = mock(typeof(JsonService)) 
		when(servidorMockeado.getJsonEspecie).thenReturn(json)
		repositorioEspecie.jsonService = servidorMockeado
	}

	@Test
	def void tesActualizarActualiza() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)

		actualizacion.execute
		
		Assert.assertEquals(especieActulizarJsonObject.get(0).asObject.get("nombre").asString,
			repositorioEspecie.searchByNumero(especieActulizarJsonObject.get(0).asObject.get("numero").asInt).nombre)
	}
	
	@Test
	def void tesAgregar1Accion() {
		
		RepositorioEntrenador.instance.agregarEntrenador( new Entrenador )
		
		agregarAcciones.execute
		
		val Entrenador entrenador = RepositorioEntrenador.instance.obtenerEntrenador(0)
		
//		println( entrenador.cantidadObservers )
		
		Assert.assertTrue( entrenador.cantidadObservers == 1 )
	}
	
	@Test
	def void tesPoblarAreaCantidadPokemones() {
		
		poblarArea.execute
		
		Assert.assertEquals( RepositorioPokemon.instance.pokemones.size , 1 )
	}
	
	@Test
	def void tesPoblarAreaNivelPokemon() {
		
		poblarArea.execute
		
		val pokemon = RepositorioPokemon.instance.pokemones.get(0)
		
		Assert.assertTrue( pokemon.nivel >= 1 && pokemon.nivel <= 5  )
	}
	
	@Test
	def void tesPoblarAreaUbicacionPokemon() {
		
		poblarArea.execute
		
		val pokemon = RepositorioPokemon.instance.pokemones.get(0)
		
		Assert.assertTrue( rectanguloTest.estaDentroDelRectangulo( pokemon.ubicacion )  )
	}
	
	
	@Test
	def void tes2Commandos() {
		var JsonArray especieActulizarJsonObject = Json.array.asArray().add(crearBulbasaurJson)
		val String especieActualizarString = especieActulizarJsonObject.toString
		mockearServidor(especieActualizarString)
		
		comandoMultiple.execute

		Assert.assertEquals( RepositorioPokemon.instance.pokemones.size , 1 )

	}
	
}
