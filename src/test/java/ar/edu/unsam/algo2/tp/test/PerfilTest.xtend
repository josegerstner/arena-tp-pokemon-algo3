package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Coleccionista
import ar.edu.unsam.algo3.tp.model.Criador
import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Genero
import ar.edu.unsam.algo3.tp.model.Luchador
import ar.edu.unsam.algo3.tp.model.Pokemon
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class PerfilTest extends TestHelper{
	
	Criador criador = new Criador
	
	Coleccionista coleccionista = new Coleccionista
	
	Luchador luchador = new Luchador
	
	Entrenador entrenador
	
	@Before
	def void init(){
		
		entrenador = crearEntrenador
		
	}
	
	@Test
	def testEsCriadorExperto(){
		
		entrenador.cantidadPokemonesEvolucionados = 21
		
		for( var i = 0 ; i < 6 ; i++ ){
			
			var pokemon = new Pokemon
			
			pokemon.experiencia = 30000
			
			entrenador.agregarPokemon( pokemon )
			
		}
		
		entrenador.perfil = criador
		
		Assert.assertTrue( criador.esExperto(entrenador))
		
	}
	
	@Test
	def testNoEsCriadorExperto(){
		
		entrenador.perfil = criador
		
		Assert.assertFalse( criador.esExperto(entrenador))
		
	}
	
	@Test
	def testEsColeccionistaExperto(){
		
		entrenador.perfil = coleccionista
		
		entrenador.experiencia = 85000
		
		for( var i = 0 ; i < 21 ; i ++ ){
			
			entrenador.especiesAtrapadas.add( new Especie() )
			
		}
		
		var pokemonMasculino = new Pokemon
		
		pokemonMasculino.genero = Genero.MASCULINO
		
		var pokemonFemenino = new Pokemon
		
		pokemonFemenino.genero = Genero.FEMENINO
		
		entrenador.agregarPokemon(pokemonMasculino)
		
		entrenador.agregarPokemon(pokemonFemenino)
		
		Assert.assertTrue( coleccionista.esExperto(entrenador))
		
	}
	
	@Test
	def testNoEsColeccionistaExperto(){
		
		entrenador.perfil = coleccionista
		
		Assert.assertFalse( coleccionista.esExperto(entrenador))
		
	}
	
	@Test
	def testEsLuchadorExperto(){
		
		entrenador.experiencia = 210000
		
		entrenador.cantidadCombatesGanados = 31
		
		entrenador.perfil = luchador
		
		Assert.assertTrue( luchador.esExperto(entrenador) )
		
	}
	
	@Test
	def testNoEsLuchadorExperto(){
		
		entrenador.perfil = luchador
		
		Assert.assertFalse( luchador.esExperto(entrenador))
		
	}
	
}