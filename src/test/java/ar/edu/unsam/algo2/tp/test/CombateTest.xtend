package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Coleccionista
import ar.edu.unsam.algo3.tp.model.Combate
import ar.edu.unsam.algo3.tp.model.Criador
import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Luchador
import ar.edu.unsam.algo3.tp.model.Pokemon
import ar.edu.unsam.algo3.tp.model.exception.CombateExcepcion
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

import static org.mockito.Mockito.*

class CombateTest extends TestHelper {

	Pokemon pokemon

	Entrenador entrenador 

	@Before
	def void init()	{

		var Especie especie = new Especie
		
		especie.velocidad = 10
		
		especie.puntosAtaque = 10
		
		pokemon = crearPokemon(especie)

		entrenador = crearEntrenador()
		
	}
	
	
	@Test
	def void testCombateDinero() {
	
		entrenador.perfil = new Coleccionista()
		
		var Combate combate = stubearCombate(0.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(1100, entrenador.dinero, 0.01)

	}
	
	def stubearCombate(double valorRandom) {
		var combate = spy(typeof(Combate)) 
		when(combate.random).thenReturn(valorRandom)
		combate
	}
	
	@Test
	def void testCombateExperienciaPokemon() {
	
		entrenador.perfil = new Coleccionista()
		
		var Combate combate = stubearCombate(0.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(55, pokemon.experiencia, 0.01)

	}
	
	@Test
	def void testCombateColeccionistaOK() {
	
		entrenador.perfil = new Coleccionista()
		
		var Combate combate = stubearCombate(0.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(301, entrenador.experiencia, 0.01)

	}
	
	@Test
	def void testCombateCriadorOK() {
	
		entrenador.perfil = new Criador()
		
		var Combate combate = stubearCombate(0.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(301, entrenador.experiencia, 0.01)

	}
	
	@Test
	def void testCombateLuchadorOK() {
	
		entrenador.perfil = new Luchador()
		
		var Combate combate = stubearCombate(0.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		entrenadorRival.experiencia = 1001
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(501, entrenador.experiencia, 0.01)

	}
	
	@Test
	def void testCombateNOK() {
	
		entrenador.perfil = new Coleccionista()
		
		var Combate combate = stubearCombate(1.0)
		
		combate.apuesta = 100
		
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		
		entrenadorRival.perfil = new Coleccionista()
		
		combate.entrenadorRival = entrenadorRival
		
		combate.pokemon = pokemon
		
		combate.pokemonRival = pokemon
		
		combate.combatir()
		
		Assert.assertEquals(1, entrenador.experiencia, 0.01)

	}
	
	@Test(expected=CombateExcepcion)
	def void testCombateDemaciadoLejos() {
	
		var Combate combate = new Combate
		entrenador.ubicacion = new Point ( 0 , 0 )
		combate.entrenador = entrenador
		
		var entrenadorRival = crearEntrenador()
		entrenadorRival.ubicacion = new Point ( 1 , 1 )
		combate.entrenadorRival = entrenadorRival
		
		combate.combatir()
		
	}
	
}
