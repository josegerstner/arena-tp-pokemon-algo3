package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Criador
import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Pokemon
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class PokemonTest extends TestHelper{
	
	Pokemon pokemon
	
	Especie especie
	
	Especie especieEvolucionada
	
	@Before
	def init(){
		
		pokemon = new Pokemon
		
		especie =  new Especie
		
		especieEvolucionada = new Especie
		
		especie.especieEvolucion = especieEvolucionada
		
		especie.nivelEnElQueSeEvoluciona = 1
		
		especie.puntosAtaque = 10
		
		especie.puntosSalud = 10
		
		pokemon.especie = especie
		
		var Entrenador entrenador = crearEntrenador
		
		entrenador.perfil = new Criador
		
		pokemon.entrenador = entrenador
		
	}
	
	@Test
	def void testNivel1Pokemon() {

		pokemon.experiencia = 50

		Assert.assertEquals(1, pokemon.nivel, 0.01)

	}

	@Test
	def void testPuntosAtaquePokemonNivel1() {

		pokemon.experiencia = 10

		Assert.assertEquals(10, pokemon.puntosAtaque, 0.01)

	}

	/*
	 * Testea que devuelva correctamente los punto de vida de un pokemon de nivel 1 
	 */
	@Test
	def void testPuntosVidaPokemonNivel1() {

		pokemon.experiencia = 10

		Assert.assertEquals(10, pokemon.puntosSaludMaximo, 0.01)

	}

	/*
	 * Testea que calcule bien la distancia de un pokemon a un punto que esta en la misma ubicacion 
	 */
	@Test
	def void testDistancia0PuntoPokemon() {
		
		var Point pokemonPoint = new Point(0,0)
		
		pokemon.ubicacion = pokemonPoint
	
		var Point pointToTest = new Point(0,0)
		
		Assert.assertEquals(0.0, pokemon.getDistancia(pointToTest), 0.01)
				
	}
	
	
	/*
	 * Testea que calcule bien la distancia de un pokemon a un punto
	 */
	@Test
	def void testDistanciaPuntoPokemon() {
		
		var Point pokemonPoint = new Point(-34.547668, -58.490659)
		
		pokemon.ubicacion = pokemonPoint
	
		var Point pointToTest = new Point(-34.552130, -58.487054)
		
		Assert.assertEquals(0.595, pokemon.getDistancia(pointToTest), 0.001)
				
	}
	
	@Test
	def void testEvolucionPokemon() {
		
		pokemon.sumarExperiencia(1000)
				
		Assert.assertEquals( especieEvolucionada , pokemon.especie )
				
	}
	
	/*
	 * Testea que no evolucione si no suma la cantidad de puntos necesarios
	 */
	@Test
	def void testNoEvolucionPokemon() {
		
		pokemon.sumarExperiencia(1)
				
		Assert.assertEquals( especie , pokemon.especie )
				
	}
	
	@Test
	def void testChancesCombate() {
		
		Assert.assertEquals( 10.0 , pokemon.calcularChancesCombate(pokemon) , 0.0 )
				
	}
	
	@Test
	def void testChancesEscape() {
		
		Assert.assertEquals( 1.0 , pokemon.chancesEscapar , 0.0 )
				
	}
	
}
